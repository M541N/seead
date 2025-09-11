from django.utils import timezone
from rest_framework import status, permissions, serializers
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView as SimpleJWTRefreshView
from rest_framework_simplejwt.tokens import RefreshToken
from drf_spectacular.utils import extend_schema, OpenApiExample, inline_serializer, OpenApiResponse

from api.services.auth_service import AuthService

from api.serializers.auth_serializers import (
    SignupSerializer,
    CustomTokenObtainPairSerializer,
    UserInfoSerializer,
    LoginSerializer,
    WithdrawalSerializer
)
from api.schemas.auth_schemas import LoginResponseSchema, SignupResponseSchema, LogoutResponseSchema
from api.schemas.common_schemas import ErrorResponseSchema

# 회원가입
class SignupView(APIView):
    permission_classes = [permissions.AllowAny]

    @extend_schema(
        tags=["인증"],
        summary="회원가입",
        request=SignupSerializer,
        responses={
            201: SignupResponseSchema,
            400: ErrorResponseSchema
        }
    )
    def post(self, request):
        serializer = SignupSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.save()
        return Response({"success": True, "user": UserInfoSerializer(user).data}, status=status.HTTP_201_CREATED)

# 로그인
class LoginView(TokenObtainPairView):
    serializer_class = CustomTokenObtainPairSerializer

    @extend_schema(
        tags=["인증"],
        summary="로그인",
        request=LoginSerializer,
        responses={
            200: LoginResponseSchema,
            400: ErrorResponseSchema
        }
    )
    def post(self, request, *args, **kwargs):
        serializer = LoginSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data["user"]

        # ✅ FCM 토큰 업데이트
        # fcm_token = serializer.validated_data.get("fcm_token")
        # if fcm_token:
        #     profile = user.profile
        #     profile.fcm_token = fcm_token
        #     profile.save()

        # JWT 발급
        response = super().post(request, *args, **kwargs)
        response.data["user"] = UserInfoSerializer(user).data
        return response

# 토큰 갱신
class TokenRefreshView(SimpleJWTRefreshView):
    @extend_schema(
        tags=["인증"],
        summary="토큰 갱신"
    )
    def post(self, request, *args, **kwargs):
        return super().post(request, *args, **kwargs)

# 로그아웃
class LogoutView(APIView):
    permission_classes = [permissions.AllowAny]

    @extend_schema(
        tags=["인증"],
        summary="로그아웃",
        request=inline_serializer(
            name="LogoutRequest",
            fields={"refresh": serializers.CharField()}
        ),
        responses={
            205: LogoutResponseSchema,
            400: ErrorResponseSchema
        }
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

    @extend_schema(
        tags=["인증"],
        summary="내 정보 조회",
        responses={200: UserInfoSerializer}
    )
    def get(self, request):
        data = UserInfoSerializer(request.user).data
        # data["fcm_token"] = request.user.profile.fcm_token
        return Response({"success": True, "user": data})

# 회원 탈퇴
class WithdrawalView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    @extend_schema(
        tags=["인증"],
        summary="회원 탈퇴",
        request=None,
        responses={
            204: OpenApiResponse(description="회원 탈퇴 성공"),
        }
    )
    def post(self, request):
        AuthService.withdraw_user(request.user, soft_delete=True)
        return Response(status=status.HTTP_204_NO_CONTENT)