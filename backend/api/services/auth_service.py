from django.utils import timezone

from typing import Optional

from django.contrib.auth import get_user_model
from rest_framework.exceptions import AuthenticationFailed
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework_simplejwt.token_blacklist.models import (
    BlacklistedToken, OutstandingToken
)

User = get_user_model()

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
        
    @staticmethod
    def logout_with_refresh_token(refresh_token_str: str) -> None:
        try:
            token = RefreshToken(refresh_token_str)
            token.blacklist()
        except Exception as e:
            raise AuthenticationFailed("로그아웃에 실패했습니다.")
        
    @staticmethod
    def logout_all_for_user(user: User) -> int:
        count = 0
        for ot in OutstandingToken.objects.filter(user=user):
            BlacklistedToken.objects.get_or_create(token=ot)
            count += 1
            return count
        
    @staticmethod
    def withdraw_user(user: User, *, soft_delete: bool = True) -> None:
        AuthService.logout_all_for_user(user)
        
        if soft_delete:
            if hasattr(user, "deleted_at"):
                user.deleted_at = timezone.now()
            user.is_active = False
            user.save(update_fields=["is_active", "deleted_at"] if hasattr(user, "deleted_at") else ["is_active"])
            
        else:
            user.delete()