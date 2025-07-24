from django.db import models

class Interest(models.Model):
    name = models.CharField(max_length=100, unique=True, verbose_name="관심사명")

    def __str__(self):
        return self.name

    class Meta:
        db_table = "targeting_interest"
        verbose_name = "관심사"
        verbose_name_plural = "관심사 목록"


class Region(models.Model):
    name = models.CharField(max_length=100, unique=True, verbose_name="지역명")

    def __str__(self):
        return self.name

    class Meta:
        db_table = "targeting_region"
        verbose_name = "타겟 지역"
        verbose_name_plural = "타겟 지역 목록"
