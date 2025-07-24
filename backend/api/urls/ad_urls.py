from django.urls import path
from api.views.ad_views import (
    AdListView, AdDetailView, ToggleAdLikeView,
    AdUploadView, AdPerformanceSummaryView, 
    AdLikeCountView, TopLikedAdsView, RecommendedAdView,
    AdExposureView, AdMetricEventView, AdCostSummaryView,
)

urlpatterns = [
    path("list/", AdListView.as_view()),
    path("<int:pk>/", AdDetailView.as_view()),
    path("<int:pk>/like/", ToggleAdLikeView.as_view()),

    path("upload/", AdUploadView.as_view(), name="ad_upload"),
    path("summary/", AdPerformanceSummaryView.as_view(), name="ad_summary"),
    
    path("<int:pk>/likes/", AdLikeCountView.as_view(), name="ad_like_count"),
    path("top-liked/", TopLikedAdsView.as_view(), name="top_liked_ads"),
    path("recommend/", RecommendedAdView.as_view(), name="recommended_ads"),
    path("expose/", AdExposureView.as_view(), name="ad_expose"),
    path("event/", AdMetricEventView.as_view(), name="ad_event_record"),
    
    path("cost-summary/", AdCostSummaryView.as_view(), name="ad_cost_summary"),
]