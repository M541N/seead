// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SeeAD_API.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ad _$AdFromJson(Map<String, dynamic> json) => Ad(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String,
  description: json['description'] as String?,
  media:
      json['media'] == null
          ? null
          : AdMedia.fromJson(json['media'] as Map<String, dynamic>),
  rewardPoint: (json['reward_point'] as num?)?.toInt(),
  redirectUrl: json['redirect_url'] as String,
  liked: json['liked'] as String?,
);

Map<String, dynamic> _$AdToJson(Ad instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'media': instance.media?.toJson(),
  'reward_point': instance.rewardPoint,
  'redirect_url': instance.redirectUrl,
  'liked': instance.liked,
};

AdCampaign _$AdCampaignFromJson(Map<String, dynamic> json) => AdCampaign(
  id: (json['id'] as num?)?.toInt(),
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  name: json['name'] as String,
  status: statusEnumNullableFromJson(json['status']),
  startDate: DateTime.parse(json['start_date'] as String),
  endDate: DateTime.parse(json['end_date'] as String),
  dailyBudget: (json['daily_budget'] as num?)?.toDouble(),
  totalBudget: (json['total_budget'] as num?)?.toDouble(),
  targetGender: adCampaignTargetGenderNullableFromJson(json['target_gender']),
  targetAgeMin: (json['target_age_min'] as num?)?.toInt(),
  targetAgeMax: (json['target_age_max'] as num?)?.toInt(),
  seeadPerView: (json['seead_per_view'] as num?)?.toInt(),
  advertiser: (json['advertiser'] as num?)?.toInt(),
  targetInterests:
      (json['target_interests'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      [],
  targetRegions:
      (json['target_regions'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      [],
);

Map<String, dynamic> _$AdCampaignToJson(
  AdCampaign instance,
) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'name': instance.name,
  'status': statusEnumNullableToJson(instance.status),
  'start_date': _dateToJson(instance.startDate),
  'end_date': _dateToJson(instance.endDate),
  'daily_budget': instance.dailyBudget,
  'total_budget': instance.totalBudget,
  'target_gender': adCampaignTargetGenderNullableToJson(instance.targetGender),
  'target_age_min': instance.targetAgeMin,
  'target_age_max': instance.targetAgeMax,
  'seead_per_view': instance.seeadPerView,
  'advertiser': instance.advertiser,
  'target_interests': instance.targetInterests,
  'target_regions': instance.targetRegions,
};

AdCampaignRequest _$AdCampaignRequestFromJson(Map<String, dynamic> json) =>
    AdCampaignRequest(
      name: json['name'] as String,
      status: statusEnumNullableFromJson(json['status']),
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      dailyBudget: (json['daily_budget'] as num?)?.toDouble(),
      totalBudget: (json['total_budget'] as num?)?.toDouble(),
      targetGender: adCampaignRequestTargetGenderNullableFromJson(
        json['target_gender'],
      ),
      targetAgeMin: (json['target_age_min'] as num?)?.toInt(),
      targetAgeMax: (json['target_age_max'] as num?)?.toInt(),
      seeadPerView: (json['seead_per_view'] as num?)?.toInt(),
      targetInterests:
          (json['target_interests'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      targetRegions:
          (json['target_regions'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
    );

Map<String, dynamic> _$AdCampaignRequestToJson(AdCampaignRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': statusEnumNullableToJson(instance.status),
      'start_date': _dateToJson(instance.startDate),
      'end_date': _dateToJson(instance.endDate),
      'daily_budget': instance.dailyBudget,
      'total_budget': instance.totalBudget,
      'target_gender': adCampaignRequestTargetGenderNullableToJson(
        instance.targetGender,
      ),
      'target_age_min': instance.targetAgeMin,
      'target_age_max': instance.targetAgeMax,
      'seead_per_view': instance.seeadPerView,
      'target_interests': instance.targetInterests,
      'target_regions': instance.targetRegions,
    };

AdCostSummaryResponse _$AdCostSummaryResponseFromJson(
  Map<String, dynamic> json,
) => AdCostSummaryResponse(
  advertiserId: (json['advertiser_id'] as num).toInt(),
  totalRewardBasedCost: (json['total_reward_based_cost'] as num).toDouble(),
);

Map<String, dynamic> _$AdCostSummaryResponseToJson(
  AdCostSummaryResponse instance,
) => <String, dynamic>{
  'advertiser_id': instance.advertiserId,
  'total_reward_based_cost': instance.totalRewardBasedCost,
};

AdExposeRequest _$AdExposeRequestFromJson(Map<String, dynamic> json) =>
    AdExposeRequest(adId: (json['ad_id'] as num).toInt());

Map<String, dynamic> _$AdExposeRequestToJson(AdExposeRequest instance) =>
    <String, dynamic>{'ad_id': instance.adId};

AdLikeCount _$AdLikeCountFromJson(Map<String, dynamic> json) => AdLikeCount(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String,
  likeCount: (json['like_count'] as num).toInt(),
);

Map<String, dynamic> _$AdLikeCountToJson(AdLikeCount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'like_count': instance.likeCount,
    };

AdMedia _$AdMediaFromJson(Map<String, dynamic> json) => AdMedia(
  id: (json['id'] as num?)?.toInt(),
  mediaUrl: json['media_url'] as String,
  thumbnailImg: json['thumbnail_img'] as String?,
  videoFile: json['video_file'] as String?,
  videoDuration: (json['video_duration'] as num?)?.toInt(),
);

Map<String, dynamic> _$AdMediaToJson(AdMedia instance) => <String, dynamic>{
  'id': instance.id,
  'media_url': instance.mediaUrl,
  'thumbnail_img': instance.thumbnailImg,
  'video_file': instance.videoFile,
  'video_duration': instance.videoDuration,
};

AdMediaRequest _$AdMediaRequestFromJson(Map<String, dynamic> json) =>
    AdMediaRequest(
      mediaUrl: json['media_url'] as String,
      thumbnailImg: json['thumbnail_img'] as String?,
      videoFile: json['video_file'] as String?,
      videoDuration: (json['video_duration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AdMediaRequestToJson(AdMediaRequest instance) =>
    <String, dynamic>{
      'media_url': instance.mediaUrl,
      'thumbnail_img': instance.thumbnailImg,
      'video_file': instance.videoFile,
      'video_duration': instance.videoDuration,
    };

AdMetricEventRequest _$AdMetricEventRequestFromJson(
  Map<String, dynamic> json,
) => AdMetricEventRequest(
  adId: (json['ad_id'] as num).toInt(),
  eventType: eventTypeEnumFromJson(json['event_type']),
);

Map<String, dynamic> _$AdMetricEventRequestToJson(
  AdMetricEventRequest instance,
) => <String, dynamic>{
  'ad_id': instance.adId,
  'event_type': eventTypeEnumToJson(instance.eventType),
};

AdPerformanceSummaryResponse _$AdPerformanceSummaryResponseFromJson(
  Map<String, dynamic> json,
) => AdPerformanceSummaryResponse(
  summary: json['summary'] as Map<String, dynamic>,
);

Map<String, dynamic> _$AdPerformanceSummaryResponseToJson(
  AdPerformanceSummaryResponse instance,
) => <String, dynamic>{'summary': instance.summary};

AdRecommend _$AdRecommendFromJson(Map<String, dynamic> json) => AdRecommend(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String,
  rewardPoint: (json['reward_point'] as num?)?.toInt(),
  redirectUrl: json['redirect_url'] as String,
  mediaUrl: json['media_url'] as String?,
);

Map<String, dynamic> _$AdRecommendToJson(AdRecommend instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'reward_point': instance.rewardPoint,
      'redirect_url': instance.redirectUrl,
      'media_url': instance.mediaUrl,
    };

AdRequest _$AdRequestFromJson(Map<String, dynamic> json) => AdRequest(
  title: json['title'] as String,
  description: json['description'] as String?,
  rewardPoint: (json['reward_point'] as num?)?.toInt(),
  redirectUrl: json['redirect_url'] as String,
);

Map<String, dynamic> _$AdRequestToJson(AdRequest instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'reward_point': instance.rewardPoint,
  'redirect_url': instance.redirectUrl,
};

AdUploadRequest _$AdUploadRequestFromJson(Map<String, dynamic> json) =>
    AdUploadRequest(
      title: json['title'] as String,
      description: json['description'] as String?,
      rewardPoint: (json['reward_point'] as num?)?.toInt(),
      redirectUrl: json['redirect_url'] as String,
      category: (json['category'] as num).toInt(),
      brand: (json['brand'] as num).toInt(),
      videoFile: json['video_file'] as String?,
      thumbnailImg: json['thumbnail_img'] as String?,
    );

Map<String, dynamic> _$AdUploadRequestToJson(AdUploadRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'reward_point': instance.rewardPoint,
      'redirect_url': instance.redirectUrl,
      'category': instance.category,
      'brand': instance.brand,
      'video_file': instance.videoFile,
      'thumbnail_img': instance.thumbnailImg,
    };

AdUploadResponse _$AdUploadResponseFromJson(Map<String, dynamic> json) =>
    AdUploadResponse(
      success: json['success'] as bool,
      adId: (json['ad_id'] as num).toInt(),
    );

Map<String, dynamic> _$AdUploadResponseToJson(AdUploadResponse instance) =>
    <String, dynamic>{'success': instance.success, 'ad_id': instance.adId};

AdvertiserDetail _$AdvertiserDetailFromJson(Map<String, dynamic> json) =>
    AdvertiserDetail(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      homepageUrl: json['homepage_url'] as String?,
      businessInfo:
          json['business_info'] == null
              ? null
              : BusinessInfo.fromJson(
                json['business_info'] as Map<String, dynamic>,
              ),
      outsourcingCompanies:
          (json['outsourcing_companies'] as List<dynamic>?)
              ?.map(
                (e) => OutsourcingCompany.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      brands:
          (json['brands'] as List<dynamic>?)
              ?.map((e) => Brand.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$AdvertiserDetailToJson(AdvertiserDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'homepage_url': instance.homepageUrl,
      'business_info': instance.businessInfo?.toJson(),
      'outsourcing_companies':
          instance.outsourcingCompanies?.map((e) => e.toJson()).toList(),
      'brands': instance.brands?.map((e) => e.toJson()).toList(),
    };

AdvertiserUpdateRequest _$AdvertiserUpdateRequestFromJson(
  Map<String, dynamic> json,
) => AdvertiserUpdateRequest(
  name: json['name'] as String,
  description: json['description'] as String?,
  homepageUrl: json['homepage_url'] as String?,
  businessInfo: BusinessInfoRequest.fromJson(
    json['business_info'] as Map<String, dynamic>,
  ),
  outsourcingCompanies:
      (json['outsourcing_companies'] as List<dynamic>?)
          ?.map(
            (e) =>
                OutsourcingCompanyRequest.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  brands:
      (json['brands'] as List<dynamic>?)
          ?.map((e) => BrandRequest.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$AdvertiserUpdateRequestToJson(
  AdvertiserUpdateRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'homepage_url': instance.homepageUrl,
  'business_info': instance.businessInfo.toJson(),
  'outsourcing_companies':
      instance.outsourcingCompanies.map((e) => e.toJson()).toList(),
  'brands': instance.brands.map((e) => e.toJson()).toList(),
};

Brand _$BrandFromJson(Map<String, dynamic> json) => Brand(
  name: json['name'] as String,
  description: json['description'] as String?,
);

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
};

BrandRequest _$BrandRequestFromJson(Map<String, dynamic> json) => BrandRequest(
  name: json['name'] as String,
  description: json['description'] as String?,
);

Map<String, dynamic> _$BrandRequestToJson(BrandRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

BusinessInfo _$BusinessInfoFromJson(Map<String, dynamic> json) => BusinessInfo(
  companyName: json['company_name'] as String,
  companyNameEn: json['company_name_en'] as String?,
  homepageUrl: json['homepage_url'] as String?,
  logoUrl: json['logo_url'] as String?,
  representative: json['representative'] as String?,
  email: json['email'] as String?,
  phoneNo: json['phone_no'] as String?,
);

Map<String, dynamic> _$BusinessInfoToJson(BusinessInfo instance) =>
    <String, dynamic>{
      'company_name': instance.companyName,
      'company_name_en': instance.companyNameEn,
      'homepage_url': instance.homepageUrl,
      'logo_url': instance.logoUrl,
      'representative': instance.representative,
      'email': instance.email,
      'phone_no': instance.phoneNo,
    };

BusinessInfoRequest _$BusinessInfoRequestFromJson(Map<String, dynamic> json) =>
    BusinessInfoRequest(
      companyName: json['company_name'] as String,
      companyNameEn: json['company_name_en'] as String?,
      homepageUrl: json['homepage_url'] as String?,
      logoUrl: json['logo_url'] as String?,
      representative: json['representative'] as String?,
      email: json['email'] as String?,
      phoneNo: json['phone_no'] as String?,
    );

Map<String, dynamic> _$BusinessInfoRequestToJson(
  BusinessInfoRequest instance,
) => <String, dynamic>{
  'company_name': instance.companyName,
  'company_name_en': instance.companyNameEn,
  'homepage_url': instance.homepageUrl,
  'logo_url': instance.logoUrl,
  'representative': instance.representative,
  'email': instance.email,
  'phone_no': instance.phoneNo,
};

CampaignBudgetChargeRequest _$CampaignBudgetChargeRequestFromJson(
  Map<String, dynamic> json,
) => CampaignBudgetChargeRequest(amount: (json['amount'] as num).toDouble());

Map<String, dynamic> _$CampaignBudgetChargeRequestToJson(
  CampaignBudgetChargeRequest instance,
) => <String, dynamic>{'amount': instance.amount};

CampaignDurationExtendRequest _$CampaignDurationExtendRequestFromJson(
  Map<String, dynamic> json,
) => CampaignDurationExtendRequest(
  newEndDate: DateTime.parse(json['new_end_date'] as String),
);

Map<String, dynamic> _$CampaignDurationExtendRequestToJson(
  CampaignDurationExtendRequest instance,
) => <String, dynamic>{'new_end_date': _dateToJson(instance.newEndDate)};

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) =>
    ErrorResponse(
      success: json['success'] as bool,
      error: json['error'] as String,
    );

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{'success': instance.success, 'error': instance.error};

EventRecordResponse _$EventRecordResponseFromJson(Map<String, dynamic> json) =>
    EventRecordResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$EventRecordResponseToJson(
  EventRecordResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
};

LikeCountResponse _$LikeCountResponseFromJson(Map<String, dynamic> json) =>
    LikeCountResponse(likeCount: (json['like_count'] as num).toInt());

Map<String, dynamic> _$LikeCountResponseToJson(LikeCountResponse instance) =>
    <String, dynamic>{'like_count': instance.likeCount};

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
  username: json['username'] as String,
  password: json['password'] as String?,
  fcmToken: json['fcm_token'] as String?,
);

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'fcm_token': instance.fcmToken,
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      access: json['access'] as String,
      refresh: json['refresh'] as String,
      user: UserInfo.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'access': instance.access,
      'refresh': instance.refresh,
      'user': instance.user.toJson(),
    };

LogoutRequestRequest _$LogoutRequestRequestFromJson(
  Map<String, dynamic> json,
) => LogoutRequestRequest(refresh: json['refresh'] as String);

Map<String, dynamic> _$LogoutRequestRequestToJson(
  LogoutRequestRequest instance,
) => <String, dynamic>{'refresh': instance.refresh};

LogoutResponse _$LogoutResponseFromJson(Map<String, dynamic> json) =>
    LogoutResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$LogoutResponseToJson(LogoutResponse instance) =>
    <String, dynamic>{'success': instance.success, 'message': instance.message};

NotFoundResponse _$NotFoundResponseFromJson(Map<String, dynamic> json) =>
    NotFoundResponse(error: json['error'] as String);

Map<String, dynamic> _$NotFoundResponseToJson(NotFoundResponse instance) =>
    <String, dynamic>{'error': instance.error};

OutsourcingCompany _$OutsourcingCompanyFromJson(Map<String, dynamic> json) =>
    OutsourcingCompany(
      name: json['name'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$OutsourcingCompanyToJson(OutsourcingCompany instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

OutsourcingCompanyRequest _$OutsourcingCompanyRequestFromJson(
  Map<String, dynamic> json,
) => OutsourcingCompanyRequest(
  name: json['name'] as String,
  description: json['description'] as String?,
);

Map<String, dynamic> _$OutsourcingCompanyRequestToJson(
  OutsourcingCompanyRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
};

PatchedAdCampaignRequest _$PatchedAdCampaignRequestFromJson(
  Map<String, dynamic> json,
) => PatchedAdCampaignRequest(
  name: json['name'] as String?,
  status: statusEnumNullableFromJson(json['status']),
  startDate:
      json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
  endDate:
      json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
  dailyBudget: (json['daily_budget'] as num?)?.toDouble(),
  totalBudget: (json['total_budget'] as num?)?.toDouble(),
  targetGender: patchedAdCampaignRequestTargetGenderNullableFromJson(
    json['target_gender'],
  ),
  targetAgeMin: (json['target_age_min'] as num?)?.toInt(),
  targetAgeMax: (json['target_age_max'] as num?)?.toInt(),
  seeadPerView: (json['seead_per_view'] as num?)?.toInt(),
  targetInterests:
      (json['target_interests'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      [],
  targetRegions:
      (json['target_regions'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      [],
);

Map<String, dynamic> _$PatchedAdCampaignRequestToJson(
  PatchedAdCampaignRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'status': statusEnumNullableToJson(instance.status),
  'start_date': _dateToJson(instance.startDate),
  'end_date': _dateToJson(instance.endDate),
  'daily_budget': instance.dailyBudget,
  'total_budget': instance.totalBudget,
  'target_gender': patchedAdCampaignRequestTargetGenderNullableToJson(
    instance.targetGender,
  ),
  'target_age_min': instance.targetAgeMin,
  'target_age_max': instance.targetAgeMax,
  'seead_per_view': instance.seeadPerView,
  'target_interests': instance.targetInterests,
  'target_regions': instance.targetRegions,
};

RewardHistory _$RewardHistoryFromJson(Map<String, dynamic> json) =>
    RewardHistory(
      id: (json['id'] as num?)?.toInt(),
      adTitle: json['ad_title'] as String?,
      points: (json['points'] as num).toInt(),
      createdAt:
          json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$RewardHistoryToJson(RewardHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ad_title': instance.adTitle,
      'points': instance.points,
      'created_at': instance.createdAt?.toIso8601String(),
    };

RewardStatus _$RewardStatusFromJson(Map<String, dynamic> json) => RewardStatus(
  availableSeed: (json['available_seed'] as num).toInt(),
  todayClaimed: (json['today_claimed'] as num).toInt(),
  dailyLimit: (json['daily_limit'] as num).toInt(),
);

Map<String, dynamic> _$RewardStatusToJson(RewardStatus instance) =>
    <String, dynamic>{
      'available_seed': instance.availableSeed,
      'today_claimed': instance.todayClaimed,
      'daily_limit': instance.dailyLimit,
    };

SignupRequest _$SignupRequestFromJson(Map<String, dynamic> json) =>
    SignupRequest(
      username: json['username'] as String,
      password: json['password'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$SignupRequestToJson(SignupRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
    };

SignupResponse _$SignupResponseFromJson(Map<String, dynamic> json) =>
    SignupResponse(
      success: json['success'] as bool,
      user: UserInfo.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignupResponseToJson(SignupResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'user': instance.user.toJson(),
    };

SuccessMessageResponse _$SuccessMessageResponseFromJson(
  Map<String, dynamic> json,
) => SuccessMessageResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
);

Map<String, dynamic> _$SuccessMessageResponseToJson(
  SuccessMessageResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
};

ToggleLikeResponse _$ToggleLikeResponseFromJson(Map<String, dynamic> json) =>
    ToggleLikeResponse(
      success: json['success'] as bool,
      liked: json['liked'] as bool,
      adId: (json['ad_id'] as num).toInt(),
    );

Map<String, dynamic> _$ToggleLikeResponseToJson(ToggleLikeResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'liked': instance.liked,
      'ad_id': instance.adId,
    };

TokenRefresh _$TokenRefreshFromJson(Map<String, dynamic> json) => TokenRefresh(
  access: json['access'] as String?,
  refresh: json['refresh'] as String,
);

Map<String, dynamic> _$TokenRefreshToJson(TokenRefresh instance) =>
    <String, dynamic>{'access': instance.access, 'refresh': instance.refresh};

TokenRefreshRequest _$TokenRefreshRequestFromJson(Map<String, dynamic> json) =>
    TokenRefreshRequest(refresh: json['refresh'] as String);

Map<String, dynamic> _$TokenRefreshRequestToJson(
  TokenRefreshRequest instance,
) => <String, dynamic>{'refresh': instance.refresh};

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
  id: (json['id'] as num?)?.toInt(),
  username: json['username'] as String,
  email: json['email'] as String?,
);

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'email': instance.email,
};

ApiRewardClaimPost$RequestBody _$ApiRewardClaimPost$RequestBodyFromJson(
  Map<String, dynamic> json,
) => ApiRewardClaimPost$RequestBody(
  adId: (json['ad_id'] as num).toInt(),
  point: (json['point'] as num).toInt(),
);

Map<String, dynamic> _$ApiRewardClaimPost$RequestBodyToJson(
  ApiRewardClaimPost$RequestBody instance,
) => <String, dynamic>{'ad_id': instance.adId, 'point': instance.point};
