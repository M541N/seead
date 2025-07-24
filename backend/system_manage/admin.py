from django.contrib import admin

# 사용자 도메인
from .models.user import Profile, Advertiser, Agency

# 회사 도메인
from .models.company import BusinessInfo, OutsourcingCompany

# 타겟팅 도메인
from .models.targeting import Interest, Region

# 광고 캠페인
from .models.ad_campaign import AdCampaign

# 광고 미디어 및 광고
from .models.ad_media import AdMedia, AdCategory, Ad

# 광고 통계
from .models.ad_stats import (
    AdRewardPoint, AdViewLog, AdViewer,
    AdViewerStats, AdPerformanceSnapshot,
    AdPerformanceSummary, AdLike
)

# 광고 분석 결과
from .models.ad_analysis import AdViewerAnalyticsResult

# 권한
from .models.permission import AccessPermission


admin.site.register(Profile)
admin.site.register(Advertiser)
admin.site.register(Agency)
admin.site.register(BusinessInfo)
admin.site.register(OutsourcingCompany)
admin.site.register(Interest)
admin.site.register(Region)
admin.site.register(AdCampaign)
admin.site.register(AdMedia)
admin.site.register(AdCategory)
admin.site.register(Ad)
admin.site.register(AdRewardPoint)
admin.site.register(AdViewLog)
admin.site.register(AdViewer)
admin.site.register(AdViewerStats)
admin.site.register(AdPerformanceSnapshot)
admin.site.register(AdPerformanceSummary)
admin.site.register(AdViewerAnalyticsResult)
admin.site.register(AdLike)
admin.site.register(AccessPermission)