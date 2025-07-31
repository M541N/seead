from django.urls import path
from api.views.advertiser_views import AdvertiserDetailAPIView, AdvertiserUpdateAPIView

urlpatterns = [
    path('me/', AdvertiserDetailAPIView.as_view(), name='advertiser-detail'),
    path('me/update/', AdvertiserUpdateAPIView.as_view(), name='advertiser-update'),
]