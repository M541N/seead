from django.db import models
from .ad_media import Ad

class AdViewerAnalyticsResult(models.Model):
    ad = models.ForeignKey(Ad, related_name="analytics_results", on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    total_viewers = models.PositiveIntegerField(default=0)
    unique_users = models.PositiveIntegerField(default=0)
    avg_watch_time = models.FloatField(default=0.0)
    age_distribution = models.JSONField()
    gender_distribution = models.JSONField()
    region_distribution = models.JSONField()
    device_distribution = models.JSONField()

    class Meta:
        db_table = "ad_viewer_analytics_result"
        ordering = ['-created_at']
