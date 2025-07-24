from django.db import models
from .user import Advertiser
from .targeting import Interest, Region
from .base import TimeStampedModel
from .user import Profile

class AdCampaign(TimeStampedModel):
    advertiser = models.ForeignKey(Advertiser, on_delete=models.CASCADE, related_name="campaigns", verbose_name="광고주")
    name = models.CharField(max_length=255, verbose_name="캠페인명")

    STATUS_CHOICES = [
        ('DRAFT', '임시저장'),
        ('PENDING_REVIEW', '검토중'),
        ('SCHEDULED', '예약됨'),
        ('OPERATING', '운영 중'),
        ('PAUSED', '일시중지'),
        ('ENDED', '종료됨'),
        ('COMPLETED', '완료됨'),
        ('REJECTED', '거부됨'),
    ]

    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='DRAFT', verbose_name="캠페인 상태")
    start_date = models.DateField(verbose_name="캠페인 시작일")
    end_date = models.DateField(verbose_name="캠페인 종료일")
    daily_budget = models.DecimalField(max_digits=12, decimal_places=2, null=True, blank=True, verbose_name="일일 예산")
    total_budget = models.DecimalField(max_digits=15, decimal_places=2, null=True, blank=True, verbose_name="총 예산")
    target_gender = models.CharField(max_length=10, choices=Profile.GENDER_CHOICES, null=True, blank=True, verbose_name="타겟 성별")
    target_age_min = models.PositiveIntegerField(null=True, blank=True, verbose_name="타겟 최소 연령")
    target_age_max = models.PositiveIntegerField(null=True, blank=True, verbose_name="타겟 최대 연령")
    target_interests = models.ManyToManyField(Interest, blank=True, verbose_name="타겟 관심사")
    target_regions = models.ManyToManyField(Region, blank=True, verbose_name="타겟 지역")
    seead_per_view = models.PositiveIntegerField(default=1, verbose_name="뷰당 지급 Seed")

    def __str__(self):
        return self.name

    class Meta:
        db_table = "ad_campaign"
        verbose_name = "광고 캠페인"
        verbose_name_plural = "광고 캠페인 목록"
        ordering = ['-created_at']
