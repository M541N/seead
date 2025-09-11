from django.contrib.auth.models import Permission
from django.contrib.contenttypes.models import ContentType
from django.db import models
from django.db.models import Q

class AccessPermissionManager(models.Manager):
    def get_queryset(self):
        return super().get_queryset().filter(
            Q(content_type=self.PERMISSION_TYPE.READ) |
            Q(content_type=self.PERMISSION_TYPE.WRITE)
        )

class AccessPermission(Permission):
    class Meta:
        proxy = True

    class __PERMISSION_TYPE:
        def get_all_permissions(self):
            return [self.READ, self.WRITE]

        @property
        def WRITE(self):
            return ContentType.objects.get_or_create(app_label='write', model='write_permission')[0]

        @property
        def READ(self):
            return ContentType.objects.get_or_create(app_label='read', model='read_permission')[0]

    PERMISSION_TYPE = __PERMISSION_TYPE()
    objects = AccessPermissionManager()

    def save(self, *args, **kwargs):
        if self.content_type not in self.PERMISSION_TYPE.get_all_permissions():
            raise ValueError('Not permitted Permission Type.')
        super().save(*args, **kwargs)
