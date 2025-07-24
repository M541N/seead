from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from system_manage.models.notification import Notification
from drf_yasg.utils import swagger_auto_schema

class NotificationListView(APIView):
    permission_classes = [IsAuthenticated]

    @swagger_auto_schema(operation_summary="내 알림 목록 조회")
    def get(self, request):
        notis = Notification.objects.filter(recipient=request.user).order_by('-created_at')[:50]
        data = [{
            "id": n.id,
            "message": n.message,
            "is_read": n.is_read,
            "type": n.type,
            "created_at": n.created_at
        } for n in notis]
        return Response(data)
    
class NotificationMarkReadView(APIView):
    def post(self, request, pk):
        try:
            noti = Notification.objects.get(id=pk, recipient=request.user)
            noti.is_read = True
            noti.save()
            return Response({"success": True})
        except Notification.DoesNotExist:
            return Response({"error": "알림 없음"}, status=404)