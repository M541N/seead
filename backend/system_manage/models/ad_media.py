from django.db import models
from .ad_campaign import AdCampaign
from .company import OutsourcingCompany
from .base import TimeStampedModel
from .user import Advertiser
from .targeting import Region, Interest

class AdMedia(TimeStampedModel):
    campaign = models.ForeignKey(AdCampaign, on_delete=models.CASCADE, related_name="media", null=True, blank=True, verbose_name="캠페인")
    media_url = models.URLField(verbose_name="미디어 URL (외부)")
    thumbnail_img = models.ImageField(upload_to='img/thumbnail/', null=True, blank=True, verbose_name="썸네일 이미지")
    video_file = models.FileField(upload_to='video/', null=True, blank=True, verbose_name="비디오 파일")
    video_duration = models.IntegerField(default=0, verbose_name="비디오 길이(초)")

    def __str__(self):
        return str(self.ad_creative.title) if hasattr(self, 'ad_creative') and self.ad_creative else f"미디어 ID : {self.id}"

    class Meta:
        db_table = "ad_media"
        verbose_name = "미디어"
        verbose_name_plural = "광고 미디어 목록"


class AdCategory(models.Model):
    name = models.CharField(max_length=255, verbose_name="카테고리명")
    parent = models.ForeignKey('self', on_delete=models.CASCADE, null=True, blank=True, related_name='children', verbose_name="상위 카테고리")

    class Meta:
        db_table = "ad_category"

    def __str__(self):
        return self.name

    def is_root(self):
        return self.parent is None

    def level(self):
        level = 0
        parent = self.parent
        while parent:
            level += 1
            parent = parent.parent
        return level


class Ad(models.Model):
    from .company import OutsourcingCompany
    from .user import Advertiser
    from .targeting import Region, Interest
    from .ad_campaign import AdCampaign
    from .ad_media import AdMedia, AdCategory
    from .company import Brand

    title = models.CharField(max_length=255, verbose_name="광고 소재명")
    description = models.TextField(blank=True, verbose_name="소재 설명")
    media = models.OneToOneField(AdMedia, related_name="ad_creative", on_delete=models.SET_NULL, null=True, blank=True, verbose_name="미디어")
    brand = models.ForeignKey('Brand', related_name="ad_creatives", on_delete=models.CASCADE, verbose_name="브랜드")
    category = models.ForeignKey(AdCategory, related_name="ad_creatives", on_delete=models.PROTECT, verbose_name="카테고리")
    outsourcingCompany = models.ForeignKey(OutsourcingCompany, related_name="ad_creatives", null=True, blank=True, on_delete=models.SET_NULL, verbose_name="아웃소싱 회사")
    redirect_url = models.URLField(verbose_name="랜딩 URL")
    reward_point = models.IntegerField(default=0, verbose_name="리워드 포인트")
    exposure_priority = models.IntegerField(default=0, verbose_name="노출 우선순위")
    campaign = models.ForeignKey(AdCampaign, related_name="ads", on_delete=models.CASCADE, verbose_name="캠페인", null=True, blank=True)

    AD_STATUS_CHOICES = [
        ('ACTIVE', '활성'),
        ('INACTIVE', '비활성'),
        ('PENDING_REVIEW', '검토중'),
        ('REJECTED', '거부됨'),
    ]

    status = models.CharField(max_length=20, choices=AD_STATUS_CHOICES, default='PENDING_REVIEW', verbose_name="광고 소재 상태")

    def __str__(self):
        return f"{self.campaign.name} - {self.title}" if self.campaign else self.title

    @property
    def advertiser(self):
        if self.campaign:
            return self.campaign.advertiser
        elif self.brand:
            return self.brand.advertiser
        return None

    class Meta:
        db_table = "ad"
        verbose_name = "광고 소재"
        verbose_name_plural = "광고 소재 목록"
