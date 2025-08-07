from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework import status
from rest_framework import serializers

from drf_spectacular.utils import extend_schema, inline_serializer

from api.serializers.reward_serializers import RewardStatusSerializer, RewardHistorySerializer
from api.services import reward_service

from system_manage.models import AdRewardPoint

class RewardStatusView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(tags=["리워드 관리"], summary="리워드 상태 조회", responses={200: RewardStatusSerializer})
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

    @extend_schema(tags=["리워드 관리"], summary="리워드 지급 이력 조회", responses={200: RewardHistorySerializer(many=True)})
    def get(self, request):
        rewards = AdRewardPoint.objects.filter(viewer=request.user).order_by('-created_at')
        serializer = RewardHistorySerializer(rewards, many=True)
        return Response(serializer.data)

class ClaimRewardView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(
        tags=["리워드 관리"], 
        summary="리워드 지급 요청",
        request=inline_serializer(
        name="ClaimRewardRequest",
        fields={
            "ad_id": serializers.IntegerField(),
            "point": serializers.IntegerField()
        }
    ),
    responses={
        200: inline_serializer(
            name="ClaimRewardSuccess",
            fields={"success": serializers.BooleanField(), "message": serializers.CharField()}
        ),
        400: inline_serializer(
            name="ClaimRewardFail",
            fields={"success": serializers.BooleanField(), "message": serializers.CharField()}
        )
    }
    )
    def post(self, request):
        ad_id = request.data.get("ad_id")
        point = request.data.get("point", 0)

        today_total = reward_service.get_today_claimed_seed(request.user)
        limit = reward_service.get_daily_reward_limit(request.user)

        if today_total + point > limit:
            return Response({"success": False, "message": f"오늘 수령 가능한 최대 리워드({limit})를 초과합니다."}, status=status.HTTP_400_BAD_REQUEST)

        try:
            from system_manage.models import Ad
            ad = Ad.objects.get(id=ad_id)
            reward_service.claim_reward(request.user, ad, point)
            return Response({"success": True, "message": f"{point} 포인트가 지급되었습니다."})
        except Ad.DoesNotExist:
            return Response({"success": False, "message": "해당 광고를 찾을 수 없습니다."}, status=status.HTTP_404_NOT_FOUND)