from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework import serializers

from drf_spectacular.utils import extend_schema, OpenApiParameter, inline_serializer

class UpdateFcmTokenView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(
        summary="FCM 토큰 업데이트",
        tags=["인증"],
        description="FCM 토큰을 업데이트합니다.",
        parameters=[OpenApiParameter(name="fcm_token", description="FCM 토큰", required=True, type=str)],
        request=inline_serializer(
            name="FcmTokenUpdateRequest",
            fields={"fcm_token": serializers.CharField()}
        ),
        responses={200: inline_serializer(
            name="FcmTokenUpdateResponse",
            fields={"message": serializers.CharField()}
        )}
    )
    def post(self, request):
        fcm_token = request.data.get("fcm_token")
        if not fcm_token:
            return Response({"error": "FCM 토큰이 필요합니다."}, status=400)

        profile = request.user.profile
        profile.fcm_token = fcm_token
        profile.save()

        return Response({"message": "FCM 토큰이 업데이트되었습니다."})