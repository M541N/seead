from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import serializers

from drf_spectacular.utils import extend_schema, inline_serializer

from system_manage.models.notification import Notification

class NotificationListView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(
        tags=["알림"], 
        summary="내 알림 목록 조회",
        responses={200: inline_serializer(
            name="NotificationListResponse",
            fields={
                "id": serializers.IntegerField(),
                "message": serializers.CharField(),
                "is_read": serializers.BooleanField(),
                "type": serializers.CharField(),
                "created_at": serializers.DateTimeField()
            },
            many=True
        )}
    )
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
    permission_classes = [IsAuthenticated]

    @extend_schema(tags=["알림"], summary="알림 읽음 처리")
    def post(self, request, pk):
        try:
            noti = Notification.objects.get(id=pk, recipient=request.user)
            noti.is_read = True
            noti.save()
            return Response({"success": True})
        except Notification.DoesNotExist:
            return Response({"error": "알림 없음"}, status=404)