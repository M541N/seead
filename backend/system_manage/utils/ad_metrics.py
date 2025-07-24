from redis import Redis
from django.conf import settings

r = Redis.from_url(settings.CACHES['default']['LOCATION'], decode_responses=True)

def increment_ad_impression(ad_id):
    key = f'ad:{ad_id}:impressions'
    r.incr(key)
    r.expire(key, 60 * 60 * 24)  # 24시간 만료 설정 (선택)
    
def increment_ad_metric(ad_id, metric: str):
    """
    metric: impressions, views, clicks, conversions
    """
    key = f'ad:{ad_id}:{metric}'
    r.incr(key)
    r.expire(key, 60 * 60 * 24)  # 하루 보관