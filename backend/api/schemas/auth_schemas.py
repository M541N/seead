from drf_spectacular.utils import inline_serializer
from rest_framework import serializers
from api.serializers.auth_serializers import UserInfoSerializer

# 로그인 응답
LoginResponseSchema = inline_serializer(
    name="LoginResponse",
    fields={
        "access": serializers.CharField(),
        "refresh": serializers.CharField(),
        "user": UserInfoSerializer()
    }
)

# 회원가입 응답
SignupResponseSchema = inline_serializer(
    name="SignupResponse",
    fields={
        "success": serializers.BooleanField(),
        "user": UserInfoSerializer()
    }
)

# 로그아웃 응답
LogoutResponseSchema = inline_serializer(
    name="LogoutResponse",
    fields={
        "success": serializers.BooleanField(),
        "message": serializers.CharField()
    }
)