from rest_framework import status, permissions
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView as SimpleJWTRefreshView
from rest_framework_simplejwt.tokens import RefreshToken

from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi

from api.serializers.auth_serializers import (
    SignupSerializer,
    CustomTokenObtainPairSerializer,
    UserInfoSerializer
)

# 회원가입
class SignupView(APIView):

    permission_classes = [permissions.AllowAny]

    @swagger_auto_schema(
        operation_summary="회원가입",
        request_body=SignupSerializer,
        responses={201: openapi.Response("생성됨", SignupSerializer)}
    )
    def post(self, request):
        serializer = SignupSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            return Response({"success": True, "user": serializer.data}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# 로그인 (JWT 발급)
class LoginView(TokenObtainPairView):
    
    serializer_class = CustomTokenObtainPairSerializer
    
    @swagger_auto_schema(
        operation_summary="로그인 (JWT 발급)",
        responses={200: openapi.Response("토큰 발급", CustomTokenObtainPairSerializer)}
    )
    def post(self, request, *args, **kwargs):
        return super().post(request, *args, **kwargs)

# 토큰 갱신
class TokenRefreshView(SimpleJWTRefreshView):
    
    @swagger_auto_schema(operation_summary="토큰 갱신")
    def post(self, request, *args, **kwargs):
        return super().post(request, *args, **kwargs)

# 로그아웃 (RefreshToken 폐기)
class LogoutView(APIView):
    
    @swagger_auto_schema(
        operation_summary="로그아웃",
        request_body=openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={"refresh": openapi.Schema(type=openapi.TYPE_STRING)}
        )
    )
    def post(self, request):
        try:
            refresh_token = request.data.get("refresh")
            token = RefreshToken(refresh_token)
            token.blacklist()
            return Response({"success": True, "message": "로그아웃 되었습니다."}, status=status.HTTP_205_RESET_CONTENT)
        except Exception as e:
            return Response({"success": False, "error": str(e)}, status=status.HTTP_400_BAD_REQUEST)

# 사용자 정보 조회
class UserInfoView(APIView):
    permission_classes = [permissions.IsAuthenticated]
    
    @swagger_auto_schema(
        operation_summary="내 정보 조회",
        responses={200: UserInfoSerializer}
    )
    def get(self, request):
        serializer = UserInfoSerializer(request.user)
        return Response({"success": True, "user": serializer.data})