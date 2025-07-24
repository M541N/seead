from system_manage.models.notification import Notification

def send_notification(user, message, type='admin_notice'):
    Notification.objects.create(
        recipient=user,
        message=message,
        type=type
    )