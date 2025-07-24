from rest_framework import serializers
from system_manage.models import AdRewardPoint

class RewardStatusSerializer(serializers.Serializer):
    available_seed = serializers.IntegerField()
    today_claimed = serializers.IntegerField()
    daily_limit = serializers.IntegerField()

class RewardHistorySerializer(serializers.ModelSerializer):
    ad_title = serializers.SerializerMethodField()

    class Meta:
        model = AdRewardPoint
        fields = ['id', 'ad_title', 'points', 'created_at']

    def get_ad_title(self, obj):
        return obj.ad.title