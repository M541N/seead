from django.urls import path
from api.views.reward_views import RewardStatusView, RewardHistoryView, ClaimRewardView

urlpatterns = [
    path("status/", RewardStatusView.as_view(), name="reward_status"),
    path("history/", RewardHistoryView.as_view(), name="reward_history"),
    path("claim/", ClaimRewardView.as_view(), name="claim_reward"),
]