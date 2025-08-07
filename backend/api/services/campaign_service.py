from system_manage.models import AdCampaign, Ad, AdRewardPoint
from system_manage.models.logs import CampaignStatusLog
from system_manage.utils.notification import send_notification

from django.db import transaction
from django.db.models import Sum
from datetime import date

from system_manage.models import User
from system_manage.models.logs import CampaignBudgetLog

def get_advertiser_campaigns(user):
    return AdCampaign.objects.filter(advertiser=user.advertiser).order_by('-created_at')

def is_campaign_owner(user, campaign):
    return campaign.advertiser == user.advertiser

def check_and_update_campaign_status(campaign: AdCampaign):
    """
    캠페인의 예산이 소진되었는지 확인하고 상태를 변경합니다.
    """
    ads = Ad.objects.filter(campaign=campaign)
    total_reward = AdRewardPoint.objects.filter(ad__in=ads).aggregate(
        total=Sum('points')
    )['total'] or 0

    if campaign.total_budget and total_reward >= campaign.total_budget:
        if campaign.status != 'COMPLETED':
            campaign.status = 'COMPLETED'
            campaign.save()
            
            if campaign.status != 'COMPLETED':
                previous = campaign.status
                campaign.status = 'COMPLETED'
                campaign.save()

                CampaignStatusLog.objects.create(
                    campaign=campaign,
                    changed_by=None,
                    previous_status=previous,
                    new_status='COMPLETED',
                    reason="예산 소진 자동 종료"
                )
                
                # 광고주 알림
                send_notification(
                    campaign.advertiser.user,
                    message=f"'{campaign.name}' 캠페인이 예산 소진으로 종료되었습니다.",
                    type="campaign_status"
                )

                # 관리자 알림
                for admin in User.objects.filter(is_staff=True):
                    send_notification(admin, f"[시스템] 캠페인 '{campaign.name}' 종료됨", type="campaign_status")
            
            return True  # 상태 변경됨
    return False  # 변경 없음

def charge_campaign_budget(campaign: AdCampaign, user: User, amount: int):
    """
    캠페인 예산을 충전하고, 관련 로그를 기록하며, 필요 시 상태를 업데이트합니다.
    모든 과정은 하나의 트랜잭션으로 처리됩니다.
    """
    with transaction.atomic():
        previous_budget = campaign.total_budget
        original_status = campaign.status

        # 1. 예산 업데이트
        campaign.total_budget += amount

        # 2. '완료' 상태였을 경우, 날짜에 따라 상태 복구
        new_status = original_status
        if original_status == 'COMPLETED':
            today = date.today()
            if campaign.start_date > today:
                new_status = 'SCHEDULED'
            elif campaign.start_date <= today <= campaign.end_date:
                new_status = 'OPERATING'
            else:
                new_status = 'PAUSED'
        
        campaign.status = new_status
        campaign.save()

        # 3. 예산 변경 로그 기록
        CampaignBudgetLog.objects.create(
            campaign=campaign,
            changed_by=user,
            previous_budget=previous_budget,
            added_amount=amount,
            new_budget=campaign.total_budget
        )

        # 4. 상태 변경 로그 기록
        if original_status != new_status:
            CampaignStatusLog.objects.create(
                campaign=campaign,
                changed_by=user,
                previous_status=original_status,
                new_status=new_status,
                reason="예산 충전 후 자동 복구"
            )

        # 5. 알림 발송 (DB 기록 및 FCM)
        send_notification(
            user,
            message=f"'{campaign.name}' 캠페인에 {amount} Seed가 충전되었습니다.",
            type="budget_update",
            fcm_title="캠페인 예산 충전 완료",
            fcm_body=f"{campaign.name} 캠페인에 예산이 충전되었습니다."
        )
    return campaign
