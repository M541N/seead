from rest_framework import generics, permissions, status
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView
from rest_framework import serializers

from drf_spectacular.utils import extend_schema, inline_serializer
from api.serializers.campaign_serializers import (
    AdCampaignSerializer, CampaignBudgetChargeSerializer, CampaignDurationExtendSerializer
)

from system_manage.models import AdCampaign
from system_manage.models.logs import CampaignBudgetLog, CampaignStatusLog
from api.services import campaign_service


class CampaignListView(generics.ListAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = AdCampaignSerializer

    @extend_schema(tags=["캠페인 관리"], summary="광고 캠페인 목록 조회", responses={200: AdCampaignSerializer(many=True)})
    def get_queryset(self):
        return campaign_service.get_advertiser_campaigns(self.request.user)


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
        if not campaign_service.is_campaign_owner(request.user, campaign):
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
        if not campaign_service.is_campaign_owner(request.user, campaign):
            return Response({"detail": "권한이 없습니다."}, status=status.HTTP_403_FORBIDDEN)
        return action_method(request)


class CampaignBudgetChargeView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(
        tags=["캠페인 관리"], 
        summary="캠페인 예산 충전 (완료 상태 복구 포함)", 
        request=CampaignDurationExtendSerializer,
        responses={200: inline_serializer(
            name="CampaignDurationExtendResponse",
            fields={
                "success": serializers.BooleanField(),
                "new_end_date": serializers.DateField()
            }
        )}
    )
    def post(self, request, pk):
        try:
            campaign = AdCampaign.objects.get(pk=pk, advertiser=request.user.advertiser)
        except AdCampaign.DoesNotExist:
            return Response({"error": "캠페인을 찾을 수 없습니다."}, status=404)

        serializer = CampaignBudgetChargeSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        amount = serializer.validated_data['amount']

        updated_campaign = campaign_service.charge_campaign_budget(
            campaign=campaign,
            user=request.user,
            amount=amount
        )

        return Response({
            "success": True,
            "new_total_budget": updated_campaign.total_budget,
            "new_status": updated_campaign.status
        })


class CampaignDurationExtendView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(
        tags=["캠페인 관리"], 
        summary="캠페인 종료일 연장", 
        request=CampaignDurationExtendSerializer,
        responses={200: inline_serializer(
            name="CampaignDurationExtendResponse",
            fields={
                "success": serializers.BooleanField(),
                "new_end_date": serializers.DateField()
            }
        )}
    )
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

    @extend_schema(
        tags=["캠페인 관리"], 
        summary="캠페인 로그 조회 (예산/상태 변경)",
        responses={200: inline_serializer(
            name="CampaignLogResponse",
            fields={
                "budget_logs": serializers.ListField(child=serializers.DictField()),
                "status_logs": serializers.ListField(child=serializers.DictField()),
            }
        )},
    )
    def get(self, request, pk):
        try:
            campaign = AdCampaign.objects.get(pk=pk, advertiser=request.user.advertiser)
        except AdCampaign.DoesNotExist:
            return Response({"error": "캠페인을 찾을 수 없습니다."}, status=404)

        budget_logs = campaign.budget_logs.all().values('changed_at', 'previous_budget', 'added_amount', 'new_budget')
        status_logs = campaign.status_logs.all().values('changed_at', 'previous_status', 'new_status', 'reason')

        return Response({"budget_logs": list(budget_logs), "status_logs": list(status_logs)})