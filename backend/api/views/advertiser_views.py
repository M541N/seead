from drf_spectacular.utils import extend_schema, OpenApiExample
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework import status
from system_manage.models.user import Advertiser
from api.serializers.advertiser_serializers import AdvertiserDetailSerializer, AdvertiserUpdateSerializer

class AdvertiserDetailAPIView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(
        responses={200: AdvertiserDetailSerializer},
        summary="광고주 정보 조회",
        description="로그인된 사용자의 광고주 상세 정보를 조회합니다."
    )
    def get(self, request):
        try:
            # request.user.advertiser를 통해 바로 접근하는 것이 더 효율적입니다.
            advertiser = request.user.advertiser
            serializer = AdvertiserDetailSerializer(advertiser)
            return Response(serializer.data)
        except Advertiser.DoesNotExist:
            return Response({"error": "광고주 정보를 찾을 수 없습니다."}, status=status.HTTP_404_NOT_FOUND)

class AdvertiserUpdateAPIView(APIView):
    permission_classes = [IsAuthenticated]

    @extend_schema(
        request=AdvertiserUpdateSerializer,
        responses={200: AdvertiserDetailSerializer},
        summary="광고주 정보 수정",
        description="광고주 기본 정보와 회사, 아웃소싱 회사, 브랜드 정보를 수정합니다.",
        examples=[
            OpenApiExample(
                "광고주 정보 수정 예시",
                value={
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
            )
        ]
    )
    def put(self, request):
        try:
            advertiser = request.user.advertiser
        except Advertiser.DoesNotExist:
            return Response({"error": "광고주 정보를 찾을 수 없습니다."}, status=status.HTTP_404_NOT_FOUND)
            
        serializer = AdvertiserUpdateSerializer(advertiser, data=request.data)
        serializer.is_valid(raise_exception=True)
        advertiser = serializer.save()
        return Response(AdvertiserDetailSerializer(advertiser).data, status=status.HTTP_200_OK)