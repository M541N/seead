from system_manage.models import AdCampaign, Ad, AdRewardPoint
from system_manage.models.logs import CampaignStatusLog

from system_manage.utils.notification import send_notification

from django.db.models import Sum

from system_manage.models import User

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