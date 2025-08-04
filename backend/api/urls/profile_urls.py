from django.urls import path
from api.views.profile_views import UpdateFcmTokenView

urlpatterns = [
    path('fcm/update/', UpdateFcmTokenView.as_view(), name='update-fcm-token'),
]