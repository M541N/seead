from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework import status
from system_manage.models.user import Advertiser
from api.serializers.advertiser_serializers import AdvertiserDetailSerializer, AdvertiserUpdateSerializer

class AdvertiserUpdateAPIView(APIView):
    permission_classes = [IsAuthenticated]

    advertiser_update_example = {
        "name": "테스트 광고주",
        "description": "새로운 광고주 설명",
        "homepage_url": "https://example.com",
        "business_info": {
            "company_name": "테스트 회사",
            "company_name_en": "Test Company",
            "homepage_url": "https://company.com",
            "logo_url": "/media/image/business/logo/logo.png",
            "representative": "홍길동",
            "email": "test@example.com",
            "phone_no": "010-1234-5678"
        },
        "outsourcing_companies": [
            {"name": "아웃소싱 A", "description": "영상 제작"}
        ],
        "brands": [
            {"name": "브랜드 A", "description": "주요 브랜드"}
        ]
    }

    @swagger_auto_schema(
        request_body=AdvertiserUpdateSerializer,
        responses={200: AdvertiserDetailSerializer},
        operation_summary="광고주 정보 수정",
        operation_description="광고주 기본 정보와 회사, 아웃소싱 회사, 브랜드 정보를 수정합니다.",
        examples={
            "application/json": advertiser_update_example
        }
    )
    def put(self, request):
        advertiser = Advertiser.objects.get(user=request.user)
        serializer = AdvertiserUpdateSerializer(advertiser, data=request.data)
        serializer.is_valid(raise_exception=True)
        advertiser = serializer.save()
        return Response(AdvertiserDetailSerializer(advertiser).data, status=status.HTTP_200_OK)