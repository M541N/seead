from drf_spectacular.utils import inline_serializer
from rest_framework import serializers

# 리워드 지급 응답
ClaimRewardResponseSchema = inline_serializer(
    name="ClaimRewardResponse",
    fields={
        "success": serializers.BooleanField(),
        "message": serializers.CharField(),
    }
)
