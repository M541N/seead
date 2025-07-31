from rest_framework import serializers
from system_manage.models.company import BusinessInfo, OutsourcingCompany, Brand
from system_manage.models.user import Advertiser


class BusinessInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = BusinessInfo
        fields = ['company_name', 'company_name_en', 'homepage_url', 'logo_url', 'representative', 'email', 'phone_no']


class OutsourcingCompanySerializer(serializers.ModelSerializer):
    class Meta:
        model = OutsourcingCompany
        fields = ['name', 'description']


class BrandSerializer(serializers.ModelSerializer):
    class Meta:
        model = Brand
        fields = ['name', 'description']


class AdvertiserUpdateSerializer(serializers.ModelSerializer):
    business_info = BusinessInfoSerializer()
    outsourcing_companies = OutsourcingCompanySerializer(many=True)
    brands = BrandSerializer(many=True)

    class Meta:
        model = Advertiser
        fields = ['name', 'description', 'homepage_url', 'business_info', 'outsourcing_companies', 'brands']

    def update(self, instance, validated_data):
        # 광고주 기본 정보 업데이트
        instance.name = validated_data.get('name', instance.name)
        instance.description = validated_data.get('description', instance.description)
        instance.homepage_url = validated_data.get('homepage_url', instance.homepage_url)
        instance.save()

        # BusinessInfo 업데이트
        business_info_data = validated_data.pop('business_info', None)
        if business_info_data:
            business_info, _ = BusinessInfo.objects.update_or_create(
                advertiser=instance, defaults=business_info_data
            )

        # OutsourcingCompanies 업데이트
        outsourcing_data = validated_data.pop('outsourcing_companies', [])
        instance.outsourcing_companies.all().delete()  # 전체 삭제 후 재등록
        for data in outsourcing_data:
            OutsourcingCompany.objects.create(advertiser=instance, agency=instance.user.agency if hasattr(instance.user, 'agency') else None, **data)

        # Brands 업데이트
        brand_data = validated_data.pop('brands', [])
        instance.brands.all().delete()  # 전체 삭제 후 재등록
        for data in brand_data:
            Brand.objects.create(advertiser=instance, **data)

        return instance