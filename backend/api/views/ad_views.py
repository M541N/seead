from rest_framework import generics, permissions, status
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView

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

from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi


# 광고 리스트 API
class AdListView(generics.ListAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = AdSerializer

    @swagger_auto_schema(operation_summary="광고 리스트 조회")
    def get_queryset(self):
        return get_ad_queryset_for_user(self.request.user)

# 광고 상세 정보 API
class AdDetailView(generics.RetrieveAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = AdSerializer
    queryset = Ad.objects.select_related('media')
    
    @swagger_auto_schema(operation_summary="광고 상세 조회")
    def get(self, request, *args, **kwargs):
        return super().get(request, *args, **kwargs)

# 광고 좋아요 토글 API
class ToggleAdLikeView(generics.GenericAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = AdSerializer
    queryset = Ad.objects.all()
    
    @swagger_auto_schema(
        operation_summary="광고 좋아요 토글",
        request_body=None,
        responses={200: openapi.Response("좋아요 상태", openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'success': openapi.Schema(type=openapi.TYPE_BOOLEAN),
                'liked': openapi.Schema(type=openapi.TYPE_BOOLEAN),
                'ad_id': openapi.Schema(type=openapi.TYPE_INTEGER)
            }
        ))}
    )
    def post(self, request, pk):
        ad = self.get_object()
        liked = toggle_ad_like(ad, request.user)
        return Response({
            "success": True,
            "liked": liked,
            "ad_id": ad.id
        }, status=status.HTTP_200_OK)

class AdUploadView(APIView):
    permission_classes = [IsAuthenticated]
    parser_classes = [MultiPartParser, FormParser]

    @swagger_auto_schema(
        operation_summary="광고 등록 (영상 업로드)",
        request_body=AdUploadSerializer
    )
    def post(self, request):
        serializer = AdUploadSerializer(data=request.data)
        if serializer.is_valid():
            ad = serializer.save()
            return Response({"success": True, "ad_id": ad.id}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class AdPerformanceSummaryView(APIView):
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(operation_summary="광고 성과 요약 조회")
    def get(self, request):
        summary = get_advertiser_summary(request.user.advertiser)
        return Response({"summary": summary})

class AdLikeCountView(APIView):
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(
        operation_summary="특정 광고의 좋아요 수 조회",
        responses={200: openapi.Response("Like Count", openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={"like_count": openapi.Schema(type=openapi.TYPE_INTEGER)}
        ))}
    )
    def get(self, request, pk):
        try:
            ad = Ad.objects.get(pk=pk)
            return Response({"like_count": get_like_count(ad)})
        except Ad.DoesNotExist:
            return Response({"error": "해당 광고를 찾을 수 없습니다."}, status=404)

class TopLikedAdsView(APIView):
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(
        operation_summary="좋아요 많은 광고 Top10 조회",
        responses={200: AdLikeCountSerializer(many=True)}
    )
    def get(self, request):
        ads = get_top_liked_ads()
        serialized = AdLikeCountSerializer(ads, many=True)
        return Response(serialized.data)
    
class RecommendedAdView(APIView):
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(
        operation_summary="시청 이력 기반 추천 광고 조회",
        responses={200: AdRecommendSerializer(many=True)}
    )
    def get(self, request):
        ads = get_recommended_ads_for_user(request.user)
        serializer = AdRecommendSerializer(ads, many=True)
        return Response(serializer.data)
    
class AdExposureView(APIView):
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(
        operation_summary="광고 노출 감지 및 Redis 저장",
        request_body=AdExposeSerializer,
        responses={200: "저장 완료"}
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
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(
        operation_summary="광고 시청/클릭/전환 실시간 기록",
        request_body=AdMetricEventSerializer,
        responses={200: "이벤트 기록 완료"}
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
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(operation_summary="광고주 리워드 기반 광고비 총액 조회")
    def get(self, request):
        advertiser = request.user.advertiser
        total_cost = calculate_total_cost_for_advertiser(advertiser)
        return Response({
            "advertiser_id": advertiser.id,
            "total_reward_based_cost": total_cost
        })