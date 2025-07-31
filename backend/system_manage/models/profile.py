from django.db import models
from django.contrib.auth.models import User

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name="profile")
    member_type = models.CharField(max_length=20, choices=[("user", "User"), ("advertiser", "Advertiser")])
    fcm_token = models.CharField(max_length=255, blank=True, null=True)  # ✅ FCM 토큰 필드 추가

    def __str__(self):
        return f"{self.user.username} - {self.member_type}"