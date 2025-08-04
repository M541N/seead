from django.contrib.auth.models import User
from rest_framework.exceptions import AuthenticationFailed
from rest_framework_simplejwt.tokens import RefreshToken

class AuthService:

    @staticmethod
    def register(username, password, email, member_type):
        if User.objects.filter(username=username).exists():
            raise AuthenticationFailed("이미 존재하는 사용자입니다.")
        user = User.objects.create_user(username=username, password=password, email=email)
        user.profile.member_type = member_type
        user.profile.save()
        return user

    @staticmethod
    def get_tokens_for_user(user):
        refresh = RefreshToken.for_user(user)
        return {
            "refresh": str(refresh),
            "access": str(refresh.access_token),
        }