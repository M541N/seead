from drf_spectacular.utils import inline_serializer
from rest_framework import serializers

# ✅ 공통 성공 응답
SuccessResponseSchema = inline_serializer(
    name="SuccessResponse",
    fields={
        "success": serializers.BooleanField(),
        "message": serializers.CharField(),
    }
)

# ✅ 공통 에러 응답
ErrorResponseSchema = inline_serializer(
    name="ErrorResponse",
    fields={
        "success": serializers.BooleanField(),
        "error": serializers.CharField(),
    }
)