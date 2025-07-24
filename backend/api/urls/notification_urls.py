from django.urls import path
from api.views.notification_views import NotificationListView

urlpatterns = [
    path('', NotificationListView.as_view(), name='notification_list'),
]