from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework import status

from api.serializers.reward_serializers import RewardStatusSerializer, RewardHistorySerializer
from api.services import reward_service

from system_manage.models import AdRewardPoint

from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi

class RewardStatusView(APIView):
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(
        operation_summary="리워드 상태 조회",
        responses={200: RewardStatusSerializer}
    )
    def get(self, request):
        available_seed = request.user.profile.seead_point
        today_claimed = reward_service.get_today_claimed_seed(request.user)
        daily_limit = reward_service.get_daily_reward_limit(request.user)

        data = {
            "available_seed": available_seed,
            "today_claimed": today_claimed,
            "daily_limit": daily_limit,
        }
        serializer = RewardStatusSerializer(data)
        return Response(serializer.data)

class RewardHistoryView(APIView):
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(
        operation_summary="리워드 지급 이력 조회",
        responses={200: RewardHistorySerializer(many=True)}
    )
    def get(self, request):
        rewards = AdRewardPoint.objects.filter(viewer=request.user).order_by('-created_at')
        serializer = RewardHistorySerializer(rewards, many=True)
        return Response(serializer.data)

class ClaimRewardView(APIView):
    permission_classes = [IsAuthenticated]
    
    @swagger_auto_schema(
        operation_summary="리워드 지급 요청",
        request_body=openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'ad_id': openapi.Schema(type=openapi.TYPE_INTEGER),
                'point': openapi.Schema(type=openapi.TYPE_INTEGER)
            },
            required=['ad_id', 'point']
        ),
        responses={200: openapi.Response("지급 결과")}
    )
    def post(self, request):
        ad_id = request.data.get("ad_id")
        point = request.data.get("point", 0)

        # 누적 한도 확인
        today_total = reward_service.get_today_claimed_seed(request.user)
        limit = reward_service.get_daily_reward_limit(request.user)

        if today_total + point > limit:
            return Response({
                "success": False,
                "message": f"오늘 수령 가능한 최대 리워드({limit})를 초과합니다."
            }, status=status.HTTP_400_BAD_REQUEST)

        # 실제 리워드 지급
        try:
            from system_manage.models import Ad
            ad = Ad.objects.get(id=ad_id)
            reward_service.claim_reward(request.user, ad, point)
            return Response({
                "success": True,
                "message": f"{point} 포인트가 지급되었습니다."
            })
        except Ad.DoesNotExist:
            return Response({
                "success": False,
                "message": "해당 광고를 찾을 수 없습니다."
            }, status=status.HTTP_404_NOT_FOUND)