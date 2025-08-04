from rest_framework import generics, permissions, status
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView

from drf_spectacular.utils import extend_schema
from api.serializers.campaign_serializers import (
    AdCampaignSerializer, CampaignBudgetChargeSerializer, CampaignDurationExtendSerializer
)
from system_manage.models import AdCampaign
from system_manage.models.logs import CampaignBudgetLog, CampaignStatusLog
from api.services.campaign_service import get_advertiser_campaigns, is_campaign_owner
from system_manage.utils.notification import send_notification
from system_manage.utils.fcm import send_fcm_notification


class CampaignListView(generics.ListAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = AdCampaignSerializer

    @extend_schema(tags=["캠페인 관리"], summary="광고 캠페인 목록 조회", responses={200: AdCampaignSerializer(many=True)})
    def get_queryset(self):
        return get_advertiser_campaigns(self.request.user)


class CampaignCreateView(generics.CreateAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = AdCampaignSerializer

    @extend_schema(tags=["캠페인 관리"], summary="광고 캠페인 등록", request=AdCampaignSerializer, responses={201: AdCampaignSerializer})
    def perform_create(self, serializer):
        serializer.save(advertiser=self.request.user.advertiser)


class CampaignDetailView(generics.RetrieveAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = AdCampaignSerializer
    queryset = AdCampaign.objects.all()

    @extend_schema(tags=["캠페인 관리"], summary="캠페인 상세 조회", responses={200: AdCampaignSerializer})
    def get(self, request, *args, **kwargs):
        campaign = self.get_object()
        if not is_campaign_owner(request.user, campaign):
            return Response({"detail": "권한이 없습니다."}, status=status.HTTP_403_FORBIDDEN)
        return super().get(request, *args, **kwargs)


class CampaignUpdateDeleteView(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = AdCampaignSerializer
    queryset = AdCampaign.objects.all()

    @extend_schema(tags=["캠페인 관리"], summary="캠페인 수정", request=AdCampaignSerializer, responses={200: AdCampaignSerializer})
    def put(self, request, *args, **kwargs):
        return self._check_and_execute(request, super().put)

    @extend_schema(tags=["캠페인 관리"], summary="캠페인 삭제", responses={204: None})
    def delete(self, request, *args, **kwargs):
        return self._check_and_execute(request, super().delete)

    def _check_and_execute(self, request, action_method):
        campaign = self.get_object()
        if not is_campaign_owner(request.user, campaign):
            return Response({"detail": "권한이 없습니다."}, status=status.HTTP_403_FORBIDDEN)
        return action_method(request)


class CampaignBudgetChargeView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(tags=["캠페인 관리"], summary="캠페인 예산 충전 (완료 상태 복구 포함)", request=CampaignBudgetChargeSerializer)
    def post(self, request, pk):
        try:
            campaign = AdCampaign.objects.get(pk=pk, advertiser=request.user.advertiser)
        except AdCampaign.DoesNotExist:
            return Response({"error": "캠페인을 찾을 수 없습니다."}, status=404)

        serializer = CampaignBudgetChargeSerializer(data=request.data)
        if serializer.is_valid():
            amount = serializer.validated_data['amount']
            campaign.total_budget += amount

            original_status = campaign.status
            if campaign.status == 'COMPLETED':
                from datetime import date
                today = date.today()
                if campaign.start_date > today:
                    campaign.status = 'SCHEDULED'
                elif campaign.start_date <= today <= campaign.end_date:
                    campaign.status = 'OPERATING'
                else:
                    campaign.status = 'PAUSED'

            CampaignBudgetLog.objects.create(
                campaign=campaign,
                changed_by=request.user,
                previous_budget=campaign.total_budget - amount,
                added_amount=amount,
                new_budget=campaign.total_budget
            )

            if original_status != campaign.status:
                CampaignStatusLog.objects.create(
                    campaign=campaign,
                    changed_by=request.user,
                    previous_status=original_status,
                    new_status=campaign.status,
                    reason="예산 충전 후 자동 복구"
                )

            campaign.save()

            send_notification(
                request.user,
                message=f"'{campaign.name}' 캠페인에 {amount} Seed가 충전되었습니다.",
                type="budget_update"
            )

            fcm_token = campaign.advertiser.user.profile.fcm_token
            if fcm_token:
                send_fcm_notification(
                    fcm_token,
                    title="캠페인 예산 충전 완료",
                    body=f"{campaign.name} 캠페인에 예산이 충전되었습니다."
                )

            return Response({"success": True, "new_total_budget": campaign.total_budget, "new_status": campaign.status})
        return Response(serializer.errors, status=400)


class CampaignDurationExtendView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(tags=["캠페인 관리"], summary="캠페인 종료일 연장", request=CampaignDurationExtendSerializer)
    def post(self, request, pk):
        try:
            campaign = AdCampaign.objects.get(pk=pk, advertiser=request.user.advertiser)
        except AdCampaign.DoesNotExist:
            return Response({"error": "캠페인을 찾을 수 없습니다."}, status=404)

        serializer = CampaignDurationExtendSerializer(data=request.data)
        if serializer.is_valid():
            new_end_date = serializer.validated_data['new_end_date']
            if new_end_date <= campaign.end_date:
                return Response({"error": "종료일은 현재 종료일보다 이후여야 합니다."}, status=400)
            campaign.end_date = new_end_date
            campaign.save()
            return Response({"success": True, "new_end_date": campaign.end_date})
        return Response(serializer.errors, status=400)


class CampaignLogView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(tags=["캠페인 관리"], summary="캠페인 로그 조회 (예산/상태 변경)")
    def get(self, request, pk):
        try:
            campaign = AdCampaign.objects.get(pk=pk, advertiser=request.user.advertiser)
        except AdCampaign.DoesNotExist:
            return Response({"error": "캠페인을 찾을 수 없습니다."}, status=404)

        budget_logs = campaign.budget_logs.all().values('changed_at', 'previous_budget', 'added_amount', 'new_budget')
        status_logs = campaign.status_logs.all().values('changed_at', 'previous_status', 'new_status', 'reason')

        return Response({"budget_logs": list(budget_logs), "status_logs": list(status_logs)})