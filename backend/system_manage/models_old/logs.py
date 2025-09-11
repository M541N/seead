from django.db import models
from system_manage.models import AdCampaign, Advertiser
from django.conf import settings

class CampaignBudgetLog(models.Model):
    campaign = models.ForeignKey(AdCampaign, on_delete=models.CASCADE, related_name="budget_logs")
    changed_by = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.SET_NULL, null=True, blank=True)
    previous_budget = models.DecimalField(max_digits=15, decimal_places=2)
    added_amount = models.DecimalField(max_digits=15, decimal_places=2)
    new_budget = models.DecimalField(max_digits=15, decimal_places=2)
    changed_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "log_campaign_budget"
        ordering = ['-changed_at']

class CampaignStatusLog(models.Model):
    campaign = models.ForeignKey(AdCampaign, on_delete=models.CASCADE, related_name="status_logs")
    previous_status = models.CharField(max_length=20)
    new_status = models.CharField(max_length=20)
    changed_by = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.SET_NULL, null=True, blank=True)
    reason = models.CharField(max_length=255, blank=True)
    changed_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "log_campaign_status"
        ordering = ['-changed_at']