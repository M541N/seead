from django.contrib import admin
from django.urls import path, include

from rest_framework import permissions

from drf_yasg.views import get_schema_view
from drf_yasg import openapi

schema_view = get_schema_view(
    openapi.Info(
        title="seeAD 숏폼 광고 플랫폼 API",
        default_version='v1',
        description="앱/웹 공용 광고 플랫폼 API 문서\n\n⚙️ 인증 토큰은 오른쪽 Authorize 버튼을 통해 입력하세요.",
        terms_of_service="https://www.seead.com/terms/",
        contact=openapi.Contact(name="개발팀", email="support@seead.com", url="https://seead.com"),
        license=openapi.License(name="MIT License"),
    ),
    public=True,
    permission_classes=(permissions.AllowAny,),
)
urlpatterns = [
    path('admin/', admin.site.urls),
    
    path("api/auth/", include("api.urls.auth_urls")),
    path("api/ad/", include("api.urls.ad_urls")),
    path("api/reward/", include("api.urls.reward_urls")),
    path("api/campaign/", include("api.urls.campaign_urls")),
    
    path('swagger/', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
    path('redoc/', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),
    path("api/notifications/", include("api.urls.notification_urls")),
]
