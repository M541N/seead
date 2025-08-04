from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from drf_spectacular.utils import extend_schema, OpenApiParameter

class UpdateFcmTokenView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(
        summary="FCM 토큰 업데이트",
        parameters=[OpenApiParameter(name="fcm_token", description="FCM 토큰", required=True, type=str)]
    )
    def post(self, request):
        fcm_token = request.data.get("fcm_token")
        if not fcm_token:
            return Response({"error": "FCM 토큰이 필요합니다."}, status=400)

        profile = request.user.profile
        profile.fcm_token = fcm_token
        profile.save()

        return Response({"message": "FCM 토큰이 업데이트되었습니다."})