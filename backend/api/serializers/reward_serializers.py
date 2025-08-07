from rest_framework import serializers
from system_manage.models import AdRewardPoint

from drf_spectacular.utils import extend_schema_field

class RewardStatusSerializer(serializers.Serializer):
    available_seed = serializers.IntegerField()
    today_claimed = serializers.IntegerField()
    daily_limit = serializers.IntegerField()

class RewardHistorySerializer(serializers.ModelSerializer):
    ad_title = serializers.SerializerMethodField()

    class Meta:
        model = AdRewardPoint
        fields = ['id', 'ad_title', 'points', 'created_at']

    @extend_schema_field(serializers.CharField())
    def get_ad_title(self, obj):
        return obj.ad.title