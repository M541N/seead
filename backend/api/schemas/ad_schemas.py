from drf_spectacular.utils import inline_serializer
from rest_framework import serializers

# 광고 좋아요 토글 응답
ToggleLikeResponseSchema = inline_serializer(
    name="ToggleLikeResponse",
    fields={
        "success": serializers.BooleanField(),
        "liked": serializers.BooleanField(),
        "ad_id": serializers.IntegerField(),
    }
)

# 광고 업로드 응답
AdUploadResponseSchema = inline_serializer(
    name="AdUploadResponse",
    fields={
        "success": serializers.BooleanField(),
        "ad_id": serializers.IntegerField(),
    }
)

# 광고 성과 요약 응답
AdPerformanceSummaryResponseSchema = inline_serializer(
    name="AdPerformanceSummaryResponse",
    fields={
        "summary": serializers.DictField(),
    }
)