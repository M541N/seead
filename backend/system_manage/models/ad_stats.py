from django.db import models
from django.utils import timezone
from django.contrib.auth.models import User
from django.db.models import Count, Sum, Q, F
from .ad_media import Ad

class AdRewardPoint(models.Model):
    ad = models.ForeignKey(Ad, related_name="reward_points", on_delete=models.CASCADE)
    viewer = models.ForeignKey(User, related_name="reward_points", on_delete=models.CASCADE)
    points = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="지급일시")

    def __str__(self):
        return str(self.ad)

    class Meta:
        db_table = "ad_reward"
        verbose_name = "광고 리워드 지급 내역"
        verbose_name_plural = "광고 리워드 지급 내역 목록"

class AdViewLog(models.Model):
    ad = models.ForeignKey(Ad, on_delete=models.CASCADE, related_name='view_logs')
    viewer = models.ForeignKey(User, on_delete=models.CASCADE, related_name='view_logs', null=True, blank=True)
    viewed_at = models.DateTimeField(default=timezone.now)
    converted = models.BooleanField(default=False)
    converted_at = models.DateTimeField(null=True, blank=True)
    user_agent = models.TextField(blank=True)

    class Meta:
        indexes = [models.Index(fields=['ad', 'viewed_at'])]

class AdViewer(models.Model):
    ad = models.ForeignKey(Ad, related_name="viewers", on_delete=models.CASCADE)
    viewer = models.ForeignKey(User, related_name="viewers", on_delete=models.CASCADE)
    watch_time = models.FloatField(default=0.0)
    viewed_at = models.DateTimeField(auto_now_add=True)
    clicked = models.BooleanField(default=False)
    is_complete = models.BooleanField(default=False)
    reward_given = models.BooleanField(default=False)
    device = models.CharField(max_length=255, default="")
    impressions = models.IntegerField(default=0)

    def __str__(self):
        return str(self.ad)

    class Meta:
        db_table = "ad_viewer"

class AdViewerStats(models.Model):
    ad = models.OneToOneField(Ad, related_name="stats", on_delete=models.CASCADE)
    total_views = models.IntegerField(default=0)
    total_clicks = models.IntegerField(default=0)
    total_watch_time = models.FloatField(default=0.0)
    total_complete_views = models.IntegerField(default=0)
    total_rewards_given = models.IntegerField(default=0)
    total_impressions = models.IntegerField(default=0)

    def update_stats(self):
        viewers = self.ad.viewers
        annotated = viewers.aggregate(
            total_views=Count('id'),
            total_clicks=Count('id', filter=Q(clicked=True)),
            total_watch_time=Sum('watch_time'),
            total_complete_views=Count('id', filter=Q(is_complete=True))
        )
        total_rewards = AdRewardPoint.objects.filter(ad=self.ad).aggregate(
            total_rewards=Sum('points')
        )['total_rewards'] or 0

        self.total_views = annotated['total_views'] or 0
        self.total_clicks = annotated['total_clicks'] or 0
        self.total_watch_time = annotated['total_watch_time'] or 0.0
        self.total_complete_views = annotated['total_complete_views'] or 0
        self.total_rewards_given = total_rewards
        self.save()

    def __str__(self):
        return str(self.ad)

    class Meta:
        db_table = "ad_viewer_stats"

class AdPerformanceSnapshot(models.Model):
    ad = models.ForeignKey(Ad, on_delete=models.CASCADE, related_name='performance_snapshots')
    date = models.DateField()
    impressions = models.PositiveIntegerField(default=0)
    views = models.PositiveIntegerField(default=0)
    completions = models.PositiveIntegerField(default=0)
    clicks = models.PositiveIntegerField(default=0)
    conversions = models.PositiveIntegerField(default=0)
    reward_given = models.PositiveIntegerField(default=0)
    seead_used = models.PositiveIntegerField(default=0)

    class Meta:
        unique_together = ('ad', 'date')
        indexes = [models.Index(fields=['ad', 'date'])]
        verbose_name = "일별 광고 성과"
        verbose_name_plural = "일별 광고 성과 목록"

class AdPerformanceSummary(models.Model):
    PERIOD_CHOICES = [
        ('1d', 'Daily'),
        ('7d', 'Weekly'),
        ('30d', 'Monthly')
    ]

    ad = models.ForeignKey(Ad, on_delete=models.CASCADE, related_name='performance_summaries')
    period = models.CharField(max_length=4, choices=PERIOD_CHOICES)
    start_date = models.DateField()
    impressions = models.PositiveIntegerField(default=0)
    conversions = models.PositiveIntegerField(default=0)
    ctr = models.FloatField(default=0.0)
    conversion_rate = models.FloatField(default=0.0)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        unique_together = ('ad', 'period', 'start_date')
        indexes = [models.Index(fields=['ad', 'period', 'start_date'])]

    def __str__(self):
        return f"{self.ad_id} - {self.period} - {self.start_date}"

class AdLike(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='ad_likes')
    ad = models.ForeignKey(Ad, on_delete=models.CASCADE, related_name='likes')
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('user', 'ad')
        verbose_name = "광고 좋아요"
        verbose_name_plural = "광고 좋아요 목록"

    def __str__(self):
        return f"{self.user.username} likes {self.ad.title}"