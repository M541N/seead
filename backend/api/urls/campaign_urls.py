from django.urls import path
from api.views.campaign_views import (
    CampaignListView,
    CampaignDetailView,
    CampaignCreateView,
    CampaignUpdateDeleteView,
    CampaignBudgetChargeView,
    CampaignDurationExtendView,
    CampaignLogView,
)

urlpatterns = [
    path("", CampaignListView.as_view(), name="campaign_list"),
    path("create/", CampaignCreateView.as_view(), name="campaign_create"),
    path("<int:pk>/", CampaignDetailView.as_view(), name="campaign_detail"),
    path("<int:pk>/edit/", CampaignUpdateDeleteView.as_view(), name="campaign_update_delete"),
    path("<int:pk>/charge-budget/", CampaignBudgetChargeView.as_view(), name="campaign_budget_charge"),
    path("<int:pk>/extend-duration/", CampaignDurationExtendView.as_view(), name="campaign_extend_duration"),
    path("<int:pk>/logs/", CampaignLogView.as_view(), name="campaign_logs"),
]