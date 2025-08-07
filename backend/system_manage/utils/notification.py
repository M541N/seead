from system_manage.models.notification import Notification
from api.services.fcm_service import send_fcm_task

def send_notification(user, message: str, type: str = "admin_notice", fcm_title=None, fcm_body=None):
    """
    알림 생성 및 FCM 푸시 발송
    """
    noti = Notification.objects.create(
        recipient=user,
        message=message,
        type=type
    )

    fcm_token = getattr(user.profile, "fcm_token", None)
    if fcm_token:
        send_fcm_task.delay(
            fcm_token,
            fcm_title or "새 알림",
            fcm_body or message
        )

    return noti