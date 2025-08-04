import logging

from django.db import transaction
from django.db.models import F
from django.utils import timezone

from celery import shared_task
from celery.schedules import crontab

from system_manage.models import Ad, AdPerformanceSnapshot, AdCampaign
from backend.system_manage.utils.ad_metrics import r

from api.services.campaign_service import check_and_update_campaign_status

logger = logging.getLogger(__name__)

REALTIME_METRICS_CONFIG = {
    'impressions': 'impressions',
    'views': 'views',
    'clicks': 'clicks',
    'conversions': 'conversions',
}

CELERY_BEAT_SCHEDULE = {
    'check-campaign-budget-every-10-minutes': {
        'task': 'tasks.check_campaign_budget_task',
        'schedule': crontab(minute='*/10'),
    },
}


@shared_task
def flush_realtime_metrics_to_db():
    logger.info("Starting flush_realtime_metrics_to_db task...")

    today = timezone.now().date()
    ad_ids = list(Ad.objects.values_list('id', flat=True))
    for ad_id in ad_ids:
        snapshot_field_updates = {}
        redis_keys_to_reset = []

        for metric_key_redis, field in REALTIME_METRICS_CONFIG.items():
            redis_key = f'ad:{ad_id}:{metric_key_redis}'
            try:
                count = int(r.get(redis_key) or 0)
            except:
                continue

            if count > 0:
                snapshot_field_updates[field] = count
                redis_keys_to_reset.append(redis_key)

        if not snapshot_field_updates:
            continue

        try:
            with transaction.atomic():
                snapshot, created = AdPerformanceSnapshot.objects.get_or_create(
                    ad_id=ad_id,
                    date=today,
                    defaults=snapshot_field_updates
                )
                if not created:
                    update_ops = {field: F(field) + val for field, val in snapshot_field_updates.items()}
                    AdPerformanceSnapshot.objects.filter(pk=snapshot.pk).update(**update_ops)

                pipe = r.pipeline()
                for key in redis_keys_to_reset:
                    pipe.set(key, 0)
                pipe.execute()

        except Exception as e:
            logger.error(f"Error flushing metrics for ad {ad_id}: {e}")
            
@shared_task
def check_campaign_budget_task():
    """
    모든 운영중/예약중 캠페인을 대상으로 예산 소진 여부를 확인하고
    필요한 경우 상태를 변경합니다.
    """
    active_campaigns = AdCampaign.objects.filter(
        status__in=['OPERATING', 'SCHEDULED']
    )

    for campaign in active_campaigns:
        changed = check_and_update_campaign_status(campaign)
        if changed:
            print(f"[BUDGET LIMIT] 캠페인 {campaign.id} 예산 소진으로 상태 변경됨.")