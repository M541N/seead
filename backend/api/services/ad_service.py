from system_manage.models import Ad, AdLike, AdViewer, AdCampaign, AdRewardPoint

from django.db.models import Sum, Count, Q

def get_ad_queryset_for_user(user):
    return Ad.objects.select_related('media').filter(status='ACTIVE').order_by('-exposure_priority')

def toggle_ad_like(ad, user):
    like, created = AdLike.objects.get_or_create(ad=ad, user=user)
    if not created:
        like.delete()
        return False
    return True

def get_advertiser_summary(advertiser):
    ads = Ad.objects.filter(campaign__advertiser=advertiser)
    return ads.aggregate(
        total_ads=Count('id'),
        total_views=Sum('viewers__impressions'),
        total_watch_time=Sum('viewers__watch_time'),
        total_clicks=Sum('viewers__clicked'),
        total_rewards=Sum('reward_points__points')
    )

def get_top_liked_ads(limit=10):
    return Ad.objects.annotate(like_count=Count('likes')) \
             .filter(status='ACTIVE') \
             .order_by('-like_count')[:limit]

def get_like_count(ad):
    return ad.likes.count()

def get_recommended_ads_for_user(user, limit=10):
    profile = user.profile
    viewed_ad_ids = AdViewer.objects.filter(viewer=user).values_list('ad_id', flat=True)

    campaign_filter = Q()
    if profile.gender:
        campaign_filter &= Q(target_gender=profile.gender)

    if profile.age:
        campaign_filter &= Q(target_age_min__lte=profile.age) & Q(target_age_max__gte=profile.age)

    interest_ids = profile.interest_set.values_list('id', flat=True)
    region_name = profile.address.split(" ")[0] if profile.address else None

    campaign_filter &= (
        Q(target_interests__in=interest_ids) |
        Q(target_regions__name__icontains=region_name)
    )

    candidate_campaigns = AdCampaign.objects.filter(campaign_filter).distinct()
    return Ad.objects.filter(
        campaign__in=candidate_campaigns,
        status='ACTIVE'
    ).exclude(id__in=viewed_ad_ids).order_by('-exposure_priority')[:limit]
    
def calculate_ad_cost(ad: Ad):
    """
    광고 1건에 대해 지급된 리워드 총합을 광고비로 간주합니다.
    """
    total_paid = AdRewardPoint.objects.filter(ad=ad).aggregate(
        total=Sum('points')
    )['total'] or 0

    return total_paid

def calculate_total_cost_for_advertiser(advertiser):
    """
    광고주 전체 광고의 누적 광고비
    """
    ads = Ad.objects.filter(campaign__advertiser=advertiser)
    total = 0
    for ad in ads:
        total += calculate_ad_cost(ad)
    return total