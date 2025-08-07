from rest_framework import serializers
from system_manage.models import Ad, AdLike, AdMedia, Brand, AdCategory

from drf_spectacular.utils import extend_schema_field

class AdMediaSerializer(serializers.ModelSerializer):
    class Meta:
        model = AdMedia
        fields = ['id', 'media_url', 'thumbnail_img', 'video_file', 'video_duration']

class AdSerializer(serializers.ModelSerializer):
    media = AdMediaSerializer(read_only=True)
    liked = serializers.SerializerMethodField()

    class Meta:
        model = Ad
        fields = ['id', 'title', 'description', 'media', 'reward_point', 'redirect_url', 'liked']

    @extend_schema_field(serializers.BooleanField())
    def get_liked(self, obj):
        user = self.context['request'].user
        return AdLike.objects.filter(ad=obj, user=user).exists()
    
class AdUploadSerializer(serializers.ModelSerializer):
    video_file = serializers.FileField(write_only=True)
    thumbnail_img = serializers.ImageField(write_only=True)

    class Meta:
        model = Ad
        fields = [
            'title', 'description', 'reward_point', 'redirect_url',
            'category', 'brand',
            'video_file', 'thumbnail_img'
        ]

    def create(self, validated_data):
        video = validated_data.pop('video_file')
        thumb = validated_data.pop('thumbnail_img')
        media = AdMedia.objects.create(video_file=video, thumbnail_img=thumb)
        validated_data['media'] = media
        return Ad.objects.create(**validated_data)
    
class AdLikeCountSerializer(serializers.ModelSerializer):
    like_count = serializers.IntegerField()

    class Meta:
        model = Ad
        fields = ['id', 'title', 'like_count']
        
class AdRecommendSerializer(serializers.ModelSerializer):
    media_url = serializers.SerializerMethodField()

    class Meta:
        model = Ad
        fields = ['id', 'title', 'reward_point', 'redirect_url', 'media_url']

    @extend_schema_field(serializers.URLField())
    def get_media_url(self, obj):
        return obj.media.media_url if obj.media else None

class AdExposeSerializer(serializers.Serializer):
    ad_id = serializers.IntegerField()
    
class AdMetricEventSerializer(serializers.Serializer):
    ad_id = serializers.IntegerField()
    event_type = serializers.ChoiceField(choices=['view', 'click', 'conversion'])