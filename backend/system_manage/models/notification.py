from django.db import models
from django.contrib.auth.models import User

class Notification(models.Model):
    recipient = models.ForeignKey(User, on_delete=models.CASCADE, related_name="notifications")
    message = models.TextField()
    is_read = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    type = models.CharField(max_length=30, choices=[
        ('campaign_status', '캠페인 상태 변경'),
        ('budget_update', '예산 충전'),
        ('admin_notice', '관리자 알림'),
    ])

    class Meta:
        db_table = "system_notification"
        ordering = ['-created_at']