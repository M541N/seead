from django.contrib import admin
from django.urls import path, include
from django.conf import settings

from drf_spectacular.views import SpectacularAPIView, SpectacularSwaggerView, SpectacularRedocView

urlpatterns = [
    path('admin/', admin.site.urls),
    
    path("api/auth/", include("api.urls.auth_urls")),
    path("api/ad/", include("api.urls.ad_urls")),
    path("api/reward/", include("api.urls.reward_urls")),
    path("api/campaign/", include("api.urls.campaign_urls")),
    path("api/notifications/", include("api.urls.notification_urls")),
    path('api/advertiser/', include('api.urls.advertiser_urls')),
 
    # path('api/brand/', include('api.urls.brand_urls')),
    
    path("api/profile/", include("api.urls.profile_urls")),
    
    # drf-spectacular URL
    path('api/schema/', SpectacularAPIView.as_view(), name='schema'),
    path('api/swagger/', SpectacularSwaggerView.as_view(url_name='schema'), name='swagger-ui'),
    path('api/redoc/', SpectacularRedocView.as_view(url_name='schema'), name='redoc'),
]