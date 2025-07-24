from system_manage.models import AdRewardPoint
from django.conf import settings
from django.utils import timezone
from django.db import models
from datetime import timedelta

def get_daily_reward_limit(user):
    level = getattr(user.profile, 'member_level', None)
    return settings.REWARD_CLAIM_DAILY_LIMITS.get(level, settings.DEFAULT_REWARD_CLAIM_DAILY_LIMIT)

def get_today_claimed_seed(user):
    today = timezone.now().date()
    return AdRewardPoint.objects.filter(
        viewer=user,
        created_at__date=today
    ).aggregate(total=models.Sum('points'))['total'] or 0

def claim_reward(user, ad, point):
    from system_manage.models import AdRewardPoint
    AdRewardPoint.objects.create(ad=ad, viewer=user, points=point)
    user.profile.seead_point += point
    user.profile.save()