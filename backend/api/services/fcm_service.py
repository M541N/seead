from pyfcm import FCMNotification
from django.conf import settings

class FCMService:
    def __init__(self):
        self.fcm = FCMNotification(api_key=settings.FCM_SERVER_KEY)

    def send_notification(self, token: str, title: str, body: str, data: dict = None):
        """
        단일 디바이스에 푸시 알림 전송
        """
        if not token:
            return {"success": False, "message": "FCM 토큰 없음"}

        result = self.fcm.notify_single_device(
            registration_id=token,
            message_title=title,
            message_body=body,
            data_message=data or {}
        )
        return result

    def send_bulk_notification(self, tokens: list, title: str, body: str, data: dict = None):
        """
        다중 디바이스에 푸시 알림 전송
        """
        tokens = [t for t in tokens if t]
        if not tokens:
            return {"success": False, "message": "유효한 FCM 토큰 없음"}

        result = self.fcm.notify_multiple_devices(
            registration_ids=tokens,
            message_title=title,
            message_body=body,
            data_message=data or {}
        )
        return result