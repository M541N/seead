from rest_framework import generics, permissions, status, serializers
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.views import APIView
from drf_spectacular.utils import extend_schema, inline_serializer, OpenApiExample, extend_schema_field

from system_manage.models import Ad
from system_manage.utils.ad_metrics import increment_ad_impression, increment_ad_metric
from api.serializers.ad_serializers import (
    AdSerializer, AdUploadSerializer, AdLikeCountSerializer,
    AdRecommendSerializer, AdExposeSerializer, AdMetricEventSerializer
)
from api.services.ad_service import (
    get_ad_queryset_for_user, toggle_ad_like, get_advertiser_summary,
    get_like_count, get_top_liked_ads, get_recommended_ads_for_user,
    calculate_total_cost_for_advertiser
)

from api.schemas.common_schemas import SuccessResponseSchema, ErrorResponseSchema
from api.schemas.ad_schemas import ToggleLikeResponseSchema, AdUploadResponseSchema

@extend_schema(tags=["광고 관리"], summary="광고 리스트 조회", responses={200: AdSerializer(many=True)})
class AdListView(generics.ListAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = AdSerializer

    def get_queryset(self):
        return get_ad_queryset_for_user(self.request.user)


class AdDetailView(generics.RetrieveAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = AdSerializer
    queryset = Ad.objects.select_related('media')

    @extend_schema(tags=["광고 관리"], summary="광고 상세 조회", responses={200: AdSerializer})
    def get(self, request, *args, **kwargs):
        return super().get(request, *args, **kwargs)


class ToggleAdLikeView(generics.GenericAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = AdSerializer
    queryset = Ad.objects.all()

    @extend_schema(
        tags=["광고 관리"], 
        summary="광고 좋아요 토글",
        description="로그인된 사용자가 광고 좋아요 상태를 토글합니다.",
        responses={
            200: inline_serializer(
                name="ToggleLikeResponse",
                fields={
                    "success": serializers.BooleanField(),
                    "liked": serializers.BooleanField(),
                    "ad_id": serializers.IntegerField(),
                }
            )
        }
    )
    def post(self, request, *args, **kwargs):
        ad = self.get_object()
        liked = toggle_ad_like(ad, request.user)
        return Response({"success": True, "liked": liked, "ad_id": ad.id}, status=status.HTTP_200_OK)


class AdUploadView(APIView):
    permission_classes = [permissions.IsAuthenticated]
    parser_classes = [MultiPartParser, FormParser]

    @extend_schema(
        tags=["광고 관리"], 
        summary="광고 등록 (영상 업로드)",
        request=AdUploadSerializer,
        responses={
            201: inline_serializer(
                name="AdUploadResponse",
                fields={"success": serializers.BooleanField(), "ad_id": serializers.IntegerField()}
            )
        }
    )
    def post(self, request):
        serializer = AdUploadSerializer(data=request.data)
        if serializer.is_valid():
            ad = serializer.save()
            return Response({"success": True, "ad_id": ad.id}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class AdPerformanceSummaryView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    @extend_schema(
        tags=["광고 관리"], 
        summary="광고 성과 요약 조회",
        responses={
            200: inline_serializer(
                name="AdPerformanceSummaryResponse",
                fields={"summary": serializers.DictField()}
            )
        }
    )
    def get(self, request):
        summary = get_advertiser_summary(request.user.advertiser)
        return Response({"summary": summary})


class AdLikeCountView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    @extend_schema(
        tags=["광고 관리"], 
        summary="특정 광고의 좋아요 수 조회",
        responses={
            200: inline_serializer(name="LikeCountResponse", fields={"like_count": serializers.IntegerField()}),
            404: inline_serializer(name="NotFoundResponse", fields={"error": serializers.CharField()})
        }
    )
    def get(self, request, *args, **kwargs):
        pk = kwargs.get('pk')
        try:
            ad = Ad.objects.get(pk=pk)
            return Response({"like_count": get_like_count(ad)})
        except Ad.DoesNotExist:
            return Response({"error": "해당 광고를 찾을 수 없습니다."}, status=404)


class TopLikedAdsView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    @extend_schema(tags=["광고 관리"], summary="좋아요 많은 광고 Top10 조회", responses={200: AdLikeCountSerializer(many=True)})
    def get(self, request):
        ads = get_top_liked_ads()
        serialized = AdLikeCountSerializer(ads, many=True)
        return Response(serialized.data)


class RecommendedAdView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    @extend_schema(tags=["광고 관리"], summary="시청 이력 기반 추천 광고 조회", responses={200: AdRecommendSerializer(many=True)})
    def get(self, request):
        ads = get_recommended_ads_for_user(request.user)
        serializer = AdRecommendSerializer(ads, many=True)
        return Response(serializer.data)


class AdExposureView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    @extend_schema(
        tags=["광고 관리"], 
        summary="광고 노출 감지 및 Redis 저장",
        request=AdExposeSerializer,
        responses={
            200: inline_serializer(
                name="SuccessMessageResponse",
                fields={"success": serializers.BooleanField(), "message": serializers.CharField()}
            )
        }
    )
    def post(self, request):
        serializer = AdExposeSerializer(data=request.data)
        if serializer.is_valid():
            ad_id = serializer.validated_data['ad_id']
            try:
                Ad.objects.get(pk=ad_id)
                increment_ad_impression(ad_id)
                return Response({"success": True, "message": "노출 기록 완료"}, status=200)
            except Ad.DoesNotExist:
                return Response({"success": False, "error": "광고를 찾을 수 없습니다"}, status=404)
        return Response(serializer.errors, status=400)


class AdMetricEventView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    @extend_schema(
        tags=["광고 관리"], 
        summary="광고 시청/클릭/전환 실시간 기록",
        request=AdMetricEventSerializer,
        responses={
            200: inline_serializer(
                name="EventRecordResponse",
                fields={"success": serializers.BooleanField(), "message": serializers.CharField()}
            )
        }
    )
    def post(self, request):
        serializer = AdMetricEventSerializer(data=request.data)
        if serializer.is_valid():
            ad_id = serializer.validated_data['ad_id']
            event = serializer.validated_data['event_type']
            try:
                Ad.objects.get(pk=ad_id)
                metric_map = {'view': 'views', 'click': 'clicks', 'conversion': 'conversions'}
                increment_ad_metric(ad_id, metric_map[event])
                return Response({"success": True, "message": f"{event} 기록 완료"}, status=200)
            except Ad.DoesNotExist:
                return Response({"error": "광고 없음"}, status=404)
        return Response(serializer.errors, status=400)


class AdCostSummaryView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    @extend_schema(
        tags=["광고 관리"], 
        summary="광고주 리워드 기반 광고비 총액 조회",
        responses={
            200: inline_serializer(
                name="AdCostSummaryResponse",
                fields={"advertiser_id": serializers.IntegerField(), "total_reward_based_cost": serializers.FloatField()}
            )
        }
    )
    def get(self, request):
        advertiser = request.user.advertiser
        total_cost = calculate_total_cost_for_advertiser(advertiser)
        return Response({
            "advertiser_id": advertiser.id,
            "total_reward_based_cost": total_cost
        })