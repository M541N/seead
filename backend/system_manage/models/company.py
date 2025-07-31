from django.db import models

from .user import Advertiser, Agency

class ActiveBusinessInfoManager(models.Manager):
    def get_queryset(self):
        return super().get_queryset().filter(is_deleted=False)


class BusinessInfo(models.Model):
    advertiser = models.OneToOneField(
        Advertiser,
        on_delete=models.CASCADE,
        related_name="business_info",
        verbose_name="광고주"
    )
    company_name = models.CharField(max_length=50, verbose_name="회사명")
    company_name_en = models.CharField(max_length=50, default="", verbose_name="회사명(영문)")
    homepage_url = models.CharField(max_length=1024, default="", verbose_name="홈페이지URL")
    logo_url = models.ImageField(
        max_length=1024,
        default="image/business/logo/",
        upload_to="image/business/logo/",
        blank=True,
        null=True,
        verbose_name="로고 이미지"
    )
    representative = models.CharField(max_length=50, default="", verbose_name="대표자명")
    email = models.EmailField(max_length=1024, default="", verbose_name="이메일")
    phone_no = models.CharField(max_length=1024, default="", verbose_name="전화번호")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="생성일시")
    is_deleted = models.BooleanField(default=False, verbose_name="삭제 여부")

    objects = models.Manager()
    active_objects = ActiveBusinessInfoManager()

    def __str__(self):
        return self.company_name

    class Meta:
        db_table = "business_info"
        verbose_name = "회사 정보"
        verbose_name_plural = "회사 정보 목록"


class OutsourcingCompany(models.Model):
    agency = models.ForeignKey(
        Agency,
        related_name="outsourcing_companies",
        on_delete=models.CASCADE,
        verbose_name="에이전시"
    )
    advertiser = models.ForeignKey(
        Advertiser,
        related_name="outsourcing_companies",
        on_delete=models.CASCADE,
        verbose_name="광고주",
        null=True,
        blank=True
    )
    name = models.CharField(max_length=255, verbose_name="아웃소싱 회사명")
    description = models.TextField(blank=True, verbose_name="설명")

    def __str__(self):
        return self.name

    class Meta:
        db_table = "ad_outsourcing_company"
        verbose_name = "아웃소싱 회사"
        verbose_name_plural = "아웃소싱 회사 목록"


class Brand(models.Model):
    advertiser = models.ForeignKey(
        Advertiser,
        related_name='brands',
        on_delete=models.CASCADE,
        verbose_name="광고주"
    )
    name = models.CharField(max_length=255, verbose_name="브랜드명")
    description = models.TextField(blank=True, verbose_name="설명")

    def __str__(self):
        return self.name

    class Meta:
        db_table = "ad_brand"
        verbose_name = "브랜드"
        verbose_name_plural = "브랜드 목록"