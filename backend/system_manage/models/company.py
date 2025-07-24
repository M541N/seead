from django.db import models

class ActiveBusinessInfoManager(models.Manager):
    def get_queryset(self):
        return super().get_queryset().filter(is_deleted=False)

class BusinessInfo(models.Model):
    company_name = models.CharField(max_length=50, verbose_name="회사명")
    company_name_en = models.CharField(max_length=50, default="", verbose_name="회사명(영문)")
    homepage_url = models.CharField(max_length=1024, default="", verbose_name="홈페이지URL")
    logo_url = models.ImageField(max_length=1024, default="image/business/logo/", upload_to="image/business/logo/", blank=True, null=True, verbose_name="로고 이미지")
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
    from .user import Agency

    agency = models.ForeignKey(Agency, related_name="outsourcing_companies", on_delete=models.CASCADE, verbose_name="에이전시")
    name = models.CharField(max_length=255, verbose_name="아웃소싱 회사명")
    description = models.TextField(blank=True, verbose_name="설명")

    def __str__(self):
        return self.name

    class Meta:
        db_table = "ad_outsourcing_company"
        verbose_name = "아웃소싱 회사"
        verbose_name_plural = "아웃소싱 회사 목록"