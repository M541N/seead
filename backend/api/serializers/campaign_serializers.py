from rest_framework import serializers
from system_manage.models import AdCampaign, Interest, Region

class AdCampaignSerializer(serializers.ModelSerializer):
    class Meta:
        model = AdCampaign
        fields = '__all__'
        read_only_fields = ['advertiser', 'created_at', 'updated_at']
        
class CampaignBudgetChargeSerializer(serializers.Serializer):
    amount = serializers.DecimalField(max_digits=15, decimal_places=2)

class CampaignDurationExtendSerializer(serializers.Serializer):
    new_end_date = serializers.DateField()