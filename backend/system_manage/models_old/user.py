from django.db import models
from django.contrib.auth.models import AbstractUser, Group, Permission
from django.db.models.signals import post_save
from django.dispatch import receiver
from datetime import date

class User(AbstractUser):
    groups = models.ManyToManyField(
        Group,
        verbose_name='groups',
        blank=True,
        help_text='The groups this user belongs to. A user will get all permissions granted to each of their groups.',
        related_name="custom_user_groups",
        related_query_name="user",
    )
    user_permissions = models.ManyToManyField(
        Permission,
        verbose_name='user permissions',
        blank=True,
        help_text='Specific permissions for this user.',
        related_name="custom_user_permissions",
        related_query_name="user",
    )
    role = models.CharField(max_length=32, default='user', verbose_name="사용자 역할")
    deleted_at = models.DateTimeField(null=True, blank=True, verbose_name="삭제된 시간")
    is_deleted = models.BooleanField(default=False, verbose_name="삭제 여부")
    
    @property
    def is_deleted(self) -> bool:
        return self.deleted_at is not None

class Profile(models.Model):
    GENDER_CHOICES = (
        ('Male', '남성'),
        ('Female', '여성'),
    )

    MEMBER_TYPE_CHOICE = (
        ('user', '일반 유저'),
        ('advertiser', '광고주'),
        ('agency', '에이전시'),
    )

    MEMBER_LEVEL_CHOICES = (
        ('B', 'B 등급'),
        ('A', 'A 등급'),
        ('S', 'S 등급'),
    )

    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name="profile")
    date_of_birth = models.DateField(null=True, blank=True, verbose_name="생년월일")
    gender = models.CharField(max_length=10, choices=GENDER_CHOICES, default='Male', verbose_name="성별")
    address = models.CharField(max_length=255, default='', verbose_name="주소")
    phone_number = models.CharField(max_length=15, blank=True, null=True, unique=True, verbose_name="전화번호")
    sns_url = models.CharField(max_length=1024, null=True, blank=True, verbose_name="SNS URL")
    membername = models.CharField(null=True, blank=True, max_length=50, verbose_name="회원 이름")
    member_type = models.CharField(max_length=100, choices=MEMBER_TYPE_CHOICE, default="user", verbose_name="회원 유형")
    member_level = models.CharField(max_length=10, choices=MEMBER_LEVEL_CHOICES, default='B', verbose_name="회원 등급")
    profile_img = models.ImageField(null=True, blank=True, upload_to="image/user/profile", verbose_name="프로필 이미지")
    is_active = models.BooleanField(default=True, verbose_name="활성 여부")
    seead_point = models.IntegerField(default=0, verbose_name="씨앗 포인트")

    # ✅ FCM 토큰 필드 추가
    # fcm_token = models.CharField(max_length=255, blank=True, null=True, verbose_name="FCM 토큰")

    def __str__(self):
        return self.membername if self.membername else self.user.username

    class Meta:
        db_table = "auth_profile"
        verbose_name = "프로필"
        verbose_name_plural = "프로필 목록"

    @property
    def age(self):
        if not self.date_of_birth:
            return None
        today = date.today()
        return today.year - self.date_of_birth.year - ((today.month, today.day) < (self.date_of_birth.month, self.date_of_birth.day))

@receiver(post_save, sender=User)
def create_user_profile(sender, instance, created, **kwargs):
    if created:
        Profile.objects.create(user=instance)

@receiver(post_save, sender=User)
def save_user_profile(sender, instance, **kwargs):
    instance.profile.save()


class Advertiser(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name="advertiser", verbose_name="사용자")
    name = models.CharField(max_length=255, verbose_name="광고주 / 회사명")
    description = models.TextField(blank=True, verbose_name="설명")
    homepage_url = models.URLField(default="", blank=True, verbose_name="홈페이지 URL")

    def __str__(self):
        return self.name

    class Meta:
        db_table = "ad_advertiser"
        verbose_name = "광고주"
        verbose_name_plural = "광고주 목록"


class Agency(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='agency', verbose_name="사용자")
    name = models.CharField(max_length=255, verbose_name="에이전시명")
    description = models.TextField(blank=True, verbose_name="설명")

    def __str__(self):
        return self.name

    class Meta:
        db_table = "ad_agency"
        verbose_name = "에이전시"
        verbose_name_plural = "에이전시 목록"
