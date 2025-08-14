// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;
import 'SeeAD_API.enums.swagger.dart' as enums;
export 'SeeAD_API.enums.swagger.dart';

part 'SeeAD_API.swagger.chopper.dart';
part 'SeeAD_API.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class SeeADAPI extends ChopperService {
  static SeeADAPI create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    List<Interceptor>? interceptors,
  }) {
    if (client != null) {
      return _$SeeADAPI(client);
    }

    final newClient = ChopperClient(
      services: [_$SeeADAPI()],
      converter: converter ?? $JsonSerializableConverter(),
      interceptors: interceptors ?? [],
      client: httpClient,
      authenticator: authenticator,
      errorConverter: errorConverter,
      baseUrl: baseUrl ?? Uri.parse('http://'),
    );
    return _$SeeADAPI(newClient);
  }

  ///광고 상세 조회
  ///@param id
  Future<chopper.Response<Ad>> apiAdIdGet({required int? id}) {
    generatedMapping.putIfAbsent(Ad, () => Ad.fromJsonFactory);

    return _apiAdIdGet(id: id);
  }

  ///광고 상세 조회
  ///@param id
  @GET(path: '/api/ad/{id}/')
  Future<chopper.Response<Ad>> _apiAdIdGet({@Path('id') required int? id});

  ///광고 좋아요 토글
  ///@param id
  Future<chopper.Response<ToggleLikeResponse>> apiAdIdLikePost({
    required int? id,
    required AdRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      ToggleLikeResponse,
      () => ToggleLikeResponse.fromJsonFactory,
    );

    return _apiAdIdLikePost(id: id, body: body);
  }

  ///광고 좋아요 토글
  ///@param id
  @POST(path: '/api/ad/{id}/like/', optionalBody: true)
  Future<chopper.Response<ToggleLikeResponse>> _apiAdIdLikePost({
    @Path('id') required int? id,
    @Body() required AdRequest? body,
  });

  ///특정 광고의 좋아요 수 조회
  ///@param id
  Future<chopper.Response<LikeCountResponse>> apiAdIdLikesGet({
    required int? id,
  }) {
    generatedMapping.putIfAbsent(
      LikeCountResponse,
      () => LikeCountResponse.fromJsonFactory,
    );

    return _apiAdIdLikesGet(id: id);
  }

  ///특정 광고의 좋아요 수 조회
  ///@param id
  @GET(path: '/api/ad/{id}/likes/')
  Future<chopper.Response<LikeCountResponse>> _apiAdIdLikesGet({
    @Path('id') required int? id,
  });

  ///광고주 리워드 기반 광고비 총액 조회
  Future<chopper.Response<AdCostSummaryResponse>> apiAdCostSummaryGet() {
    generatedMapping.putIfAbsent(
      AdCostSummaryResponse,
      () => AdCostSummaryResponse.fromJsonFactory,
    );

    return _apiAdCostSummaryGet();
  }

  ///광고주 리워드 기반 광고비 총액 조회
  @GET(path: '/api/ad/cost-summary/')
  Future<chopper.Response<AdCostSummaryResponse>> _apiAdCostSummaryGet();

  ///광고 시청/클릭/전환 실시간 기록
  Future<chopper.Response<EventRecordResponse>> apiAdEventPost({
    required AdMetricEventRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      EventRecordResponse,
      () => EventRecordResponse.fromJsonFactory,
    );

    return _apiAdEventPost(body: body);
  }

  ///광고 시청/클릭/전환 실시간 기록
  @POST(path: '/api/ad/event/', optionalBody: true)
  Future<chopper.Response<EventRecordResponse>> _apiAdEventPost({
    @Body() required AdMetricEventRequest? body,
  });

  ///광고 노출 감지 및 Redis 저장
  Future<chopper.Response<SuccessMessageResponse>> apiAdExposePost({
    required AdExposeRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      SuccessMessageResponse,
      () => SuccessMessageResponse.fromJsonFactory,
    );

    return _apiAdExposePost(body: body);
  }

  ///광고 노출 감지 및 Redis 저장
  @POST(path: '/api/ad/expose/', optionalBody: true)
  Future<chopper.Response<SuccessMessageResponse>> _apiAdExposePost({
    @Body() required AdExposeRequest? body,
  });

  ///광고 리스트 조회
  Future<chopper.Response<List<Ad>>> apiAdListGet() {
    generatedMapping.putIfAbsent(Ad, () => Ad.fromJsonFactory);

    return _apiAdListGet();
  }

  ///광고 리스트 조회
  @GET(path: '/api/ad/list/')
  Future<chopper.Response<List<Ad>>> _apiAdListGet();

  ///시청 이력 기반 추천 광고 조회
  Future<chopper.Response<List<AdRecommend>>> apiAdRecommendGet() {
    generatedMapping.putIfAbsent(
      AdRecommend,
      () => AdRecommend.fromJsonFactory,
    );

    return _apiAdRecommendGet();
  }

  ///시청 이력 기반 추천 광고 조회
  @GET(path: '/api/ad/recommend/')
  Future<chopper.Response<List<AdRecommend>>> _apiAdRecommendGet();

  ///광고 성과 요약 조회
  Future<chopper.Response<AdPerformanceSummaryResponse>> apiAdSummaryGet() {
    generatedMapping.putIfAbsent(
      AdPerformanceSummaryResponse,
      () => AdPerformanceSummaryResponse.fromJsonFactory,
    );

    return _apiAdSummaryGet();
  }

  ///광고 성과 요약 조회
  @GET(path: '/api/ad/summary/')
  Future<chopper.Response<AdPerformanceSummaryResponse>> _apiAdSummaryGet();

  ///좋아요 많은 광고 Top10 조회
  Future<chopper.Response<List<AdLikeCount>>> apiAdTopLikedGet() {
    generatedMapping.putIfAbsent(
      AdLikeCount,
      () => AdLikeCount.fromJsonFactory,
    );

    return _apiAdTopLikedGet();
  }

  ///좋아요 많은 광고 Top10 조회
  @GET(path: '/api/ad/top-liked/')
  Future<chopper.Response<List<AdLikeCount>>> _apiAdTopLikedGet();

  ///광고 등록 (영상 업로드)
  Future<chopper.Response<AdUploadResponse>> apiAdUploadPost({
    required AdUploadRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      AdUploadResponse,
      () => AdUploadResponse.fromJsonFactory,
    );

    return _apiAdUploadPost(body: body);
  }

  ///광고 등록 (영상 업로드)
  @POST(path: '/api/ad/upload/', optionalBody: true)
  Future<chopper.Response<AdUploadResponse>> _apiAdUploadPost({
    @Body() required AdUploadRequest? body,
  });

  ///광고주 정보 조회
  Future<chopper.Response<AdvertiserDetail>> apiAdvertiserMeGet() {
    generatedMapping.putIfAbsent(
      AdvertiserDetail,
      () => AdvertiserDetail.fromJsonFactory,
    );

    return _apiAdvertiserMeGet();
  }

  ///광고주 정보 조회
  @GET(path: '/api/advertiser/me/')
  Future<chopper.Response<AdvertiserDetail>> _apiAdvertiserMeGet();

  ///광고주 정보 수정
  Future<chopper.Response<AdvertiserDetail>> apiAdvertiserMeUpdatePut({
    required AdvertiserUpdateRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      AdvertiserDetail,
      () => AdvertiserDetail.fromJsonFactory,
    );

    return _apiAdvertiserMeUpdatePut(body: body);
  }

  ///광고주 정보 수정
  @PUT(path: '/api/advertiser/me/update/', optionalBody: true)
  Future<chopper.Response<AdvertiserDetail>> _apiAdvertiserMeUpdatePut({
    @Body() required AdvertiserUpdateRequest? body,
  });

  ///로그인
  Future<chopper.Response<LoginResponse>> apiAuthLoginPost({
    required LoginRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      LoginResponse,
      () => LoginResponse.fromJsonFactory,
    );

    return _apiAuthLoginPost(body: body);
  }

  ///로그인
  @POST(path: '/api/auth/login/', optionalBody: true)
  Future<chopper.Response<LoginResponse>> _apiAuthLoginPost({
    @Body() required LoginRequest? body,
  });

  ///로그아웃
  Future<chopper.Response<LogoutResponse>> apiAuthLogoutPost({
    required LogoutRequestRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      LogoutResponse,
      () => LogoutResponse.fromJsonFactory,
    );

    return _apiAuthLogoutPost(body: body);
  }

  ///로그아웃
  @POST(path: '/api/auth/logout/', optionalBody: true)
  Future<chopper.Response<LogoutResponse>> _apiAuthLogoutPost({
    @Body() required LogoutRequestRequest? body,
  });

  ///내 정보 조회
  Future<chopper.Response<UserInfo>> apiAuthMeGet() {
    generatedMapping.putIfAbsent(UserInfo, () => UserInfo.fromJsonFactory);

    return _apiAuthMeGet();
  }

  ///내 정보 조회
  @GET(path: '/api/auth/me/')
  Future<chopper.Response<UserInfo>> _apiAuthMeGet();

  ///회원가입
  Future<chopper.Response<SignupResponse>> apiAuthSignupPost({
    required SignupRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      SignupResponse,
      () => SignupResponse.fromJsonFactory,
    );

    return _apiAuthSignupPost(body: body);
  }

  ///회원가입
  @POST(path: '/api/auth/signup/', optionalBody: true)
  Future<chopper.Response<SignupResponse>> _apiAuthSignupPost({
    @Body() required SignupRequest? body,
  });

  ///토큰 갱신
  Future<chopper.Response<TokenRefresh>> apiAuthTokenRefreshPost({
    required TokenRefreshRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      TokenRefresh,
      () => TokenRefresh.fromJsonFactory,
    );

    return _apiAuthTokenRefreshPost(body: body);
  }

  ///토큰 갱신
  @POST(path: '/api/auth/token/refresh/', optionalBody: true)
  Future<chopper.Response<TokenRefresh>> _apiAuthTokenRefreshPost({
    @Body() required TokenRefreshRequest? body,
  });

  ///
  Future<chopper.Response<List<AdCampaign>>> apiCampaignGet() {
    generatedMapping.putIfAbsent(AdCampaign, () => AdCampaign.fromJsonFactory);

    return _apiCampaignGet();
  }

  ///
  @GET(path: '/api/campaign/')
  Future<chopper.Response<List<AdCampaign>>> _apiCampaignGet();

  ///캠페인 상세 조회
  ///@param id
  Future<chopper.Response<AdCampaign>> apiCampaignIdGet({required int? id}) {
    generatedMapping.putIfAbsent(AdCampaign, () => AdCampaign.fromJsonFactory);

    return _apiCampaignIdGet(id: id);
  }

  ///캠페인 상세 조회
  ///@param id
  @GET(path: '/api/campaign/{id}/')
  Future<chopper.Response<AdCampaign>> _apiCampaignIdGet({
    @Path('id') required int? id,
  });

  ///캠페인 예산 충전 (완료 상태 복구 포함)
  ///@param id
  Future<chopper.Response> apiCampaignIdChargeBudgetPost({
    required int? id,
    required CampaignBudgetChargeRequest? body,
  }) {
    return _apiCampaignIdChargeBudgetPost(id: id, body: body);
  }

  ///캠페인 예산 충전 (완료 상태 복구 포함)
  ///@param id
  @POST(path: '/api/campaign/{id}/charge-budget/', optionalBody: true)
  Future<chopper.Response> _apiCampaignIdChargeBudgetPost({
    @Path('id') required int? id,
    @Body() required CampaignBudgetChargeRequest? body,
  });

  ///
  ///@param id
  Future<chopper.Response<AdCampaign>> apiCampaignIdEditGet({
    required int? id,
  }) {
    generatedMapping.putIfAbsent(AdCampaign, () => AdCampaign.fromJsonFactory);

    return _apiCampaignIdEditGet(id: id);
  }

  ///
  ///@param id
  @GET(path: '/api/campaign/{id}/edit/')
  Future<chopper.Response<AdCampaign>> _apiCampaignIdEditGet({
    @Path('id') required int? id,
  });

  ///캠페인 수정
  ///@param id
  Future<chopper.Response<AdCampaign>> apiCampaignIdEditPut({
    required int? id,
    required AdCampaignRequest? body,
  }) {
    generatedMapping.putIfAbsent(AdCampaign, () => AdCampaign.fromJsonFactory);

    return _apiCampaignIdEditPut(id: id, body: body);
  }

  ///캠페인 수정
  ///@param id
  @PUT(path: '/api/campaign/{id}/edit/', optionalBody: true)
  Future<chopper.Response<AdCampaign>> _apiCampaignIdEditPut({
    @Path('id') required int? id,
    @Body() required AdCampaignRequest? body,
  });

  ///
  ///@param id
  Future<chopper.Response<AdCampaign>> apiCampaignIdEditPatch({
    required int? id,
    required PatchedAdCampaignRequest? body,
  }) {
    generatedMapping.putIfAbsent(AdCampaign, () => AdCampaign.fromJsonFactory);

    return _apiCampaignIdEditPatch(id: id, body: body);
  }

  ///
  ///@param id
  @PATCH(path: '/api/campaign/{id}/edit/', optionalBody: true)
  Future<chopper.Response<AdCampaign>> _apiCampaignIdEditPatch({
    @Path('id') required int? id,
    @Body() required PatchedAdCampaignRequest? body,
  });

  ///캠페인 삭제
  ///@param id
  Future<chopper.Response> apiCampaignIdEditDelete({required int? id}) {
    return _apiCampaignIdEditDelete(id: id);
  }

  ///캠페인 삭제
  ///@param id
  @DELETE(path: '/api/campaign/{id}/edit/')
  Future<chopper.Response> _apiCampaignIdEditDelete({
    @Path('id') required int? id,
  });

  ///캠페인 종료일 연장
  ///@param id
  Future<chopper.Response> apiCampaignIdExtendDurationPost({
    required int? id,
    required CampaignDurationExtendRequest? body,
  }) {
    return _apiCampaignIdExtendDurationPost(id: id, body: body);
  }

  ///캠페인 종료일 연장
  ///@param id
  @POST(path: '/api/campaign/{id}/extend-duration/', optionalBody: true)
  Future<chopper.Response> _apiCampaignIdExtendDurationPost({
    @Path('id') required int? id,
    @Body() required CampaignDurationExtendRequest? body,
  });

  ///캠페인 로그 조회 (예산/상태 변경)
  ///@param id
  Future<chopper.Response> apiCampaignIdLogsGet({required int? id}) {
    return _apiCampaignIdLogsGet(id: id);
  }

  ///캠페인 로그 조회 (예산/상태 변경)
  ///@param id
  @GET(path: '/api/campaign/{id}/logs/')
  Future<chopper.Response> _apiCampaignIdLogsGet({
    @Path('id') required int? id,
  });

  ///
  Future<chopper.Response<AdCampaign>> apiCampaignCreatePost({
    required AdCampaignRequest? body,
  }) {
    generatedMapping.putIfAbsent(AdCampaign, () => AdCampaign.fromJsonFactory);

    return _apiCampaignCreatePost(body: body);
  }

  ///
  @POST(path: '/api/campaign/create/', optionalBody: true)
  Future<chopper.Response<AdCampaign>> _apiCampaignCreatePost({
    @Body() required AdCampaignRequest? body,
  });

  ///내 알림 목록 조회
  Future<chopper.Response> apiNotificationsGet() {
    return _apiNotificationsGet();
  }

  ///내 알림 목록 조회
  @GET(path: '/api/notifications/')
  Future<chopper.Response> _apiNotificationsGet();

  ///FCM 토큰 업데이트
  ///@param fcm_token FCM 토큰
  Future<chopper.Response> apiProfileFcmUpdatePost({
    required String? fcmToken,
  }) {
    return _apiProfileFcmUpdatePost(fcmToken: fcmToken);
  }

  ///FCM 토큰 업데이트
  ///@param fcm_token FCM 토큰
  @POST(path: '/api/profile/fcm/update/', optionalBody: true)
  Future<chopper.Response> _apiProfileFcmUpdatePost({
    @Query('fcm_token') required String? fcmToken,
  });

  ///리워드 지급 요청
  Future<chopper.Response> apiRewardClaimPost({
    required ApiRewardClaimPost$RequestBody? body,
  }) {
    return _apiRewardClaimPost(body: body);
  }

  ///리워드 지급 요청
  @POST(path: '/api/reward/claim/', optionalBody: true)
  Future<chopper.Response> _apiRewardClaimPost({
    @Body() required ApiRewardClaimPost$RequestBody? body,
  });

  ///리워드 지급 이력 조회
  Future<chopper.Response<List<RewardHistory>>> apiRewardHistoryGet() {
    generatedMapping.putIfAbsent(
      RewardHistory,
      () => RewardHistory.fromJsonFactory,
    );

    return _apiRewardHistoryGet();
  }

  ///리워드 지급 이력 조회
  @GET(path: '/api/reward/history/')
  Future<chopper.Response<List<RewardHistory>>> _apiRewardHistoryGet();

  ///리워드 상태 조회
  Future<chopper.Response<RewardStatus>> apiRewardStatusGet() {
    generatedMapping.putIfAbsent(
      RewardStatus,
      () => RewardStatus.fromJsonFactory,
    );

    return _apiRewardStatusGet();
  }

  ///리워드 상태 조회
  @GET(path: '/api/reward/status/')
  Future<chopper.Response<RewardStatus>> _apiRewardStatusGet();
}

@JsonSerializable(explicitToJson: true)
class Ad {
  const Ad({
    this.id,
    required this.title,
    this.description,
    this.media,
    this.rewardPoint,
    required this.redirectUrl,
    this.liked,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => _$AdFromJson(json);

  static const toJsonFactory = _$AdToJson;
  Map<String, dynamic> toJson() => _$AdToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'media')
  final AdMedia? media;
  @JsonKey(name: 'reward_point')
  final int? rewardPoint;
  @JsonKey(name: 'redirect_url')
  final String redirectUrl;
  @JsonKey(name: 'liked')
  final String? liked;
  static const fromJsonFactory = _$AdFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Ad &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.media, media) ||
                const DeepCollectionEquality().equals(other.media, media)) &&
            (identical(other.rewardPoint, rewardPoint) ||
                const DeepCollectionEquality().equals(
                  other.rewardPoint,
                  rewardPoint,
                )) &&
            (identical(other.redirectUrl, redirectUrl) ||
                const DeepCollectionEquality().equals(
                  other.redirectUrl,
                  redirectUrl,
                )) &&
            (identical(other.liked, liked) ||
                const DeepCollectionEquality().equals(other.liked, liked)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(media) ^
      const DeepCollectionEquality().hash(rewardPoint) ^
      const DeepCollectionEquality().hash(redirectUrl) ^
      const DeepCollectionEquality().hash(liked) ^
      runtimeType.hashCode;
}

extension $AdExtension on Ad {
  Ad copyWith({
    int? id,
    String? title,
    String? description,
    AdMedia? media,
    int? rewardPoint,
    String? redirectUrl,
    String? liked,
  }) {
    return Ad(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      media: media ?? this.media,
      rewardPoint: rewardPoint ?? this.rewardPoint,
      redirectUrl: redirectUrl ?? this.redirectUrl,
      liked: liked ?? this.liked,
    );
  }

  Ad copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String>? title,
    Wrapped<String?>? description,
    Wrapped<AdMedia?>? media,
    Wrapped<int?>? rewardPoint,
    Wrapped<String>? redirectUrl,
    Wrapped<String?>? liked,
  }) {
    return Ad(
      id: (id != null ? id.value : this.id),
      title: (title != null ? title.value : this.title),
      description: (description != null ? description.value : this.description),
      media: (media != null ? media.value : this.media),
      rewardPoint: (rewardPoint != null ? rewardPoint.value : this.rewardPoint),
      redirectUrl: (redirectUrl != null ? redirectUrl.value : this.redirectUrl),
      liked: (liked != null ? liked.value : this.liked),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AdCampaign {
  const AdCampaign({
    this.id,
    this.createdAt,
    this.updatedAt,
    required this.name,
    this.status,
    required this.startDate,
    required this.endDate,
    this.dailyBudget,
    this.totalBudget,
    this.targetGender,
    this.targetAgeMin,
    this.targetAgeMax,
    this.seeadPerView,
    this.advertiser,
    this.targetInterests,
    this.targetRegions,
  });

  factory AdCampaign.fromJson(Map<String, dynamic> json) =>
      _$AdCampaignFromJson(json);

  static const toJsonFactory = _$AdCampaignToJson;
  Map<String, dynamic> toJson() => _$AdCampaignToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(
    name: 'status',
    toJson: statusEnumNullableToJson,
    fromJson: statusEnumNullableFromJson,
  )
  final enums.StatusEnum? status;
  @JsonKey(name: 'start_date', toJson: _dateToJson)
  final DateTime startDate;
  @JsonKey(name: 'end_date', toJson: _dateToJson)
  final DateTime endDate;
  @JsonKey(name: 'daily_budget')
  final double? dailyBudget;
  @JsonKey(name: 'total_budget')
  final double? totalBudget;
  @JsonKey(
    name: 'target_gender',
    toJson: adCampaignTargetGenderNullableToJson,
    fromJson: adCampaignTargetGenderNullableFromJson,
  )
  final enums.AdCampaignTargetGender? targetGender;
  @JsonKey(name: 'target_age_min')
  final int? targetAgeMin;
  @JsonKey(name: 'target_age_max')
  final int? targetAgeMax;
  @JsonKey(name: 'seead_per_view')
  final int? seeadPerView;
  @JsonKey(name: 'advertiser')
  final int? advertiser;
  @JsonKey(name: 'target_interests', defaultValue: <int>[])
  final List<int>? targetInterests;
  @JsonKey(name: 'target_regions', defaultValue: <int>[])
  final List<int>? targetRegions;
  static const fromJsonFactory = _$AdCampaignFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdCampaign &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality().equals(
                  other.endDate,
                  endDate,
                )) &&
            (identical(other.dailyBudget, dailyBudget) ||
                const DeepCollectionEquality().equals(
                  other.dailyBudget,
                  dailyBudget,
                )) &&
            (identical(other.totalBudget, totalBudget) ||
                const DeepCollectionEquality().equals(
                  other.totalBudget,
                  totalBudget,
                )) &&
            (identical(other.targetGender, targetGender) ||
                const DeepCollectionEquality().equals(
                  other.targetGender,
                  targetGender,
                )) &&
            (identical(other.targetAgeMin, targetAgeMin) ||
                const DeepCollectionEquality().equals(
                  other.targetAgeMin,
                  targetAgeMin,
                )) &&
            (identical(other.targetAgeMax, targetAgeMax) ||
                const DeepCollectionEquality().equals(
                  other.targetAgeMax,
                  targetAgeMax,
                )) &&
            (identical(other.seeadPerView, seeadPerView) ||
                const DeepCollectionEquality().equals(
                  other.seeadPerView,
                  seeadPerView,
                )) &&
            (identical(other.advertiser, advertiser) ||
                const DeepCollectionEquality().equals(
                  other.advertiser,
                  advertiser,
                )) &&
            (identical(other.targetInterests, targetInterests) ||
                const DeepCollectionEquality().equals(
                  other.targetInterests,
                  targetInterests,
                )) &&
            (identical(other.targetRegions, targetRegions) ||
                const DeepCollectionEquality().equals(
                  other.targetRegions,
                  targetRegions,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(dailyBudget) ^
      const DeepCollectionEquality().hash(totalBudget) ^
      const DeepCollectionEquality().hash(targetGender) ^
      const DeepCollectionEquality().hash(targetAgeMin) ^
      const DeepCollectionEquality().hash(targetAgeMax) ^
      const DeepCollectionEquality().hash(seeadPerView) ^
      const DeepCollectionEquality().hash(advertiser) ^
      const DeepCollectionEquality().hash(targetInterests) ^
      const DeepCollectionEquality().hash(targetRegions) ^
      runtimeType.hashCode;
}

extension $AdCampaignExtension on AdCampaign {
  AdCampaign copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    enums.StatusEnum? status,
    DateTime? startDate,
    DateTime? endDate,
    double? dailyBudget,
    double? totalBudget,
    enums.AdCampaignTargetGender? targetGender,
    int? targetAgeMin,
    int? targetAgeMax,
    int? seeadPerView,
    int? advertiser,
    List<int>? targetInterests,
    List<int>? targetRegions,
  }) {
    return AdCampaign(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dailyBudget: dailyBudget ?? this.dailyBudget,
      totalBudget: totalBudget ?? this.totalBudget,
      targetGender: targetGender ?? this.targetGender,
      targetAgeMin: targetAgeMin ?? this.targetAgeMin,
      targetAgeMax: targetAgeMax ?? this.targetAgeMax,
      seeadPerView: seeadPerView ?? this.seeadPerView,
      advertiser: advertiser ?? this.advertiser,
      targetInterests: targetInterests ?? this.targetInterests,
      targetRegions: targetRegions ?? this.targetRegions,
    );
  }

  AdCampaign copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<String>? name,
    Wrapped<enums.StatusEnum?>? status,
    Wrapped<DateTime>? startDate,
    Wrapped<DateTime>? endDate,
    Wrapped<double?>? dailyBudget,
    Wrapped<double?>? totalBudget,
    Wrapped<enums.AdCampaignTargetGender?>? targetGender,
    Wrapped<int?>? targetAgeMin,
    Wrapped<int?>? targetAgeMax,
    Wrapped<int?>? seeadPerView,
    Wrapped<int?>? advertiser,
    Wrapped<List<int>?>? targetInterests,
    Wrapped<List<int>?>? targetRegions,
  }) {
    return AdCampaign(
      id: (id != null ? id.value : this.id),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      name: (name != null ? name.value : this.name),
      status: (status != null ? status.value : this.status),
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
      dailyBudget: (dailyBudget != null ? dailyBudget.value : this.dailyBudget),
      totalBudget: (totalBudget != null ? totalBudget.value : this.totalBudget),
      targetGender: (targetGender != null
          ? targetGender.value
          : this.targetGender),
      targetAgeMin: (targetAgeMin != null
          ? targetAgeMin.value
          : this.targetAgeMin),
      targetAgeMax: (targetAgeMax != null
          ? targetAgeMax.value
          : this.targetAgeMax),
      seeadPerView: (seeadPerView != null
          ? seeadPerView.value
          : this.seeadPerView),
      advertiser: (advertiser != null ? advertiser.value : this.advertiser),
      targetInterests: (targetInterests != null
          ? targetInterests.value
          : this.targetInterests),
      targetRegions: (targetRegions != null
          ? targetRegions.value
          : this.targetRegions),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AdCampaignRequest {
  const AdCampaignRequest({
    required this.name,
    this.status,
    required this.startDate,
    required this.endDate,
    this.dailyBudget,
    this.totalBudget,
    this.targetGender,
    this.targetAgeMin,
    this.targetAgeMax,
    this.seeadPerView,
    this.targetInterests,
    this.targetRegions,
  });

  factory AdCampaignRequest.fromJson(Map<String, dynamic> json) =>
      _$AdCampaignRequestFromJson(json);

  static const toJsonFactory = _$AdCampaignRequestToJson;
  Map<String, dynamic> toJson() => _$AdCampaignRequestToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(
    name: 'status',
    toJson: statusEnumNullableToJson,
    fromJson: statusEnumNullableFromJson,
  )
  final enums.StatusEnum? status;
  @JsonKey(name: 'start_date', toJson: _dateToJson)
  final DateTime startDate;
  @JsonKey(name: 'end_date', toJson: _dateToJson)
  final DateTime endDate;
  @JsonKey(name: 'daily_budget')
  final double? dailyBudget;
  @JsonKey(name: 'total_budget')
  final double? totalBudget;
  @JsonKey(
    name: 'target_gender',
    toJson: adCampaignRequestTargetGenderNullableToJson,
    fromJson: adCampaignRequestTargetGenderNullableFromJson,
  )
  final enums.AdCampaignRequestTargetGender? targetGender;
  @JsonKey(name: 'target_age_min')
  final int? targetAgeMin;
  @JsonKey(name: 'target_age_max')
  final int? targetAgeMax;
  @JsonKey(name: 'seead_per_view')
  final int? seeadPerView;
  @JsonKey(name: 'target_interests', defaultValue: <int>[])
  final List<int>? targetInterests;
  @JsonKey(name: 'target_regions', defaultValue: <int>[])
  final List<int>? targetRegions;
  static const fromJsonFactory = _$AdCampaignRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdCampaignRequest &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality().equals(
                  other.endDate,
                  endDate,
                )) &&
            (identical(other.dailyBudget, dailyBudget) ||
                const DeepCollectionEquality().equals(
                  other.dailyBudget,
                  dailyBudget,
                )) &&
            (identical(other.totalBudget, totalBudget) ||
                const DeepCollectionEquality().equals(
                  other.totalBudget,
                  totalBudget,
                )) &&
            (identical(other.targetGender, targetGender) ||
                const DeepCollectionEquality().equals(
                  other.targetGender,
                  targetGender,
                )) &&
            (identical(other.targetAgeMin, targetAgeMin) ||
                const DeepCollectionEquality().equals(
                  other.targetAgeMin,
                  targetAgeMin,
                )) &&
            (identical(other.targetAgeMax, targetAgeMax) ||
                const DeepCollectionEquality().equals(
                  other.targetAgeMax,
                  targetAgeMax,
                )) &&
            (identical(other.seeadPerView, seeadPerView) ||
                const DeepCollectionEquality().equals(
                  other.seeadPerView,
                  seeadPerView,
                )) &&
            (identical(other.targetInterests, targetInterests) ||
                const DeepCollectionEquality().equals(
                  other.targetInterests,
                  targetInterests,
                )) &&
            (identical(other.targetRegions, targetRegions) ||
                const DeepCollectionEquality().equals(
                  other.targetRegions,
                  targetRegions,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(dailyBudget) ^
      const DeepCollectionEquality().hash(totalBudget) ^
      const DeepCollectionEquality().hash(targetGender) ^
      const DeepCollectionEquality().hash(targetAgeMin) ^
      const DeepCollectionEquality().hash(targetAgeMax) ^
      const DeepCollectionEquality().hash(seeadPerView) ^
      const DeepCollectionEquality().hash(targetInterests) ^
      const DeepCollectionEquality().hash(targetRegions) ^
      runtimeType.hashCode;
}

extension $AdCampaignRequestExtension on AdCampaignRequest {
  AdCampaignRequest copyWith({
    String? name,
    enums.StatusEnum? status,
    DateTime? startDate,
    DateTime? endDate,
    double? dailyBudget,
    double? totalBudget,
    enums.AdCampaignRequestTargetGender? targetGender,
    int? targetAgeMin,
    int? targetAgeMax,
    int? seeadPerView,
    List<int>? targetInterests,
    List<int>? targetRegions,
  }) {
    return AdCampaignRequest(
      name: name ?? this.name,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dailyBudget: dailyBudget ?? this.dailyBudget,
      totalBudget: totalBudget ?? this.totalBudget,
      targetGender: targetGender ?? this.targetGender,
      targetAgeMin: targetAgeMin ?? this.targetAgeMin,
      targetAgeMax: targetAgeMax ?? this.targetAgeMax,
      seeadPerView: seeadPerView ?? this.seeadPerView,
      targetInterests: targetInterests ?? this.targetInterests,
      targetRegions: targetRegions ?? this.targetRegions,
    );
  }

  AdCampaignRequest copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<enums.StatusEnum?>? status,
    Wrapped<DateTime>? startDate,
    Wrapped<DateTime>? endDate,
    Wrapped<double?>? dailyBudget,
    Wrapped<double?>? totalBudget,
    Wrapped<enums.AdCampaignRequestTargetGender?>? targetGender,
    Wrapped<int?>? targetAgeMin,
    Wrapped<int?>? targetAgeMax,
    Wrapped<int?>? seeadPerView,
    Wrapped<List<int>?>? targetInterests,
    Wrapped<List<int>?>? targetRegions,
  }) {
    return AdCampaignRequest(
      name: (name != null ? name.value : this.name),
      status: (status != null ? status.value : this.status),
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
      dailyBudget: (dailyBudget != null ? dailyBudget.value : this.dailyBudget),
      totalBudget: (totalBudget != null ? totalBudget.value : this.totalBudget),
      targetGender: (targetGender != null
          ? targetGender.value
          : this.targetGender),
      targetAgeMin: (targetAgeMin != null
          ? targetAgeMin.value
          : this.targetAgeMin),
      targetAgeMax: (targetAgeMax != null
          ? targetAgeMax.value
          : this.targetAgeMax),
      seeadPerView: (seeadPerView != null
          ? seeadPerView.value
          : this.seeadPerView),
      targetInterests: (targetInterests != null
          ? targetInterests.value
          : this.targetInterests),
      targetRegions: (targetRegions != null
          ? targetRegions.value
          : this.targetRegions),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AdCostSummaryResponse {
  const AdCostSummaryResponse({
    required this.advertiserId,
    required this.totalRewardBasedCost,
  });

  factory AdCostSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$AdCostSummaryResponseFromJson(json);

  static const toJsonFactory = _$AdCostSummaryResponseToJson;
  Map<String, dynamic> toJson() => _$AdCostSummaryResponseToJson(this);

  @JsonKey(name: 'advertiser_id')
  final int advertiserId;
  @JsonKey(name: 'total_reward_based_cost')
  final double totalRewardBasedCost;
  static const fromJsonFactory = _$AdCostSummaryResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdCostSummaryResponse &&
            (identical(other.advertiserId, advertiserId) ||
                const DeepCollectionEquality().equals(
                  other.advertiserId,
                  advertiserId,
                )) &&
            (identical(other.totalRewardBasedCost, totalRewardBasedCost) ||
                const DeepCollectionEquality().equals(
                  other.totalRewardBasedCost,
                  totalRewardBasedCost,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(advertiserId) ^
      const DeepCollectionEquality().hash(totalRewardBasedCost) ^
      runtimeType.hashCode;
}

extension $AdCostSummaryResponseExtension on AdCostSummaryResponse {
  AdCostSummaryResponse copyWith({
    int? advertiserId,
    double? totalRewardBasedCost,
  }) {
    return AdCostSummaryResponse(
      advertiserId: advertiserId ?? this.advertiserId,
      totalRewardBasedCost: totalRewardBasedCost ?? this.totalRewardBasedCost,
    );
  }

  AdCostSummaryResponse copyWithWrapped({
    Wrapped<int>? advertiserId,
    Wrapped<double>? totalRewardBasedCost,
  }) {
    return AdCostSummaryResponse(
      advertiserId: (advertiserId != null
          ? advertiserId.value
          : this.advertiserId),
      totalRewardBasedCost: (totalRewardBasedCost != null
          ? totalRewardBasedCost.value
          : this.totalRewardBasedCost),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AdExposeRequest {
  const AdExposeRequest({required this.adId});

  factory AdExposeRequest.fromJson(Map<String, dynamic> json) =>
      _$AdExposeRequestFromJson(json);

  static const toJsonFactory = _$AdExposeRequestToJson;
  Map<String, dynamic> toJson() => _$AdExposeRequestToJson(this);

  @JsonKey(name: 'ad_id')
  final int adId;
  static const fromJsonFactory = _$AdExposeRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdExposeRequest &&
            (identical(other.adId, adId) ||
                const DeepCollectionEquality().equals(other.adId, adId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(adId) ^ runtimeType.hashCode;
}

extension $AdExposeRequestExtension on AdExposeRequest {
  AdExposeRequest copyWith({int? adId}) {
    return AdExposeRequest(adId: adId ?? this.adId);
  }

  AdExposeRequest copyWithWrapped({Wrapped<int>? adId}) {
    return AdExposeRequest(adId: (adId != null ? adId.value : this.adId));
  }
}

@JsonSerializable(explicitToJson: true)
class AdLikeCount {
  const AdLikeCount({this.id, required this.title, required this.likeCount});

  factory AdLikeCount.fromJson(Map<String, dynamic> json) =>
      _$AdLikeCountFromJson(json);

  static const toJsonFactory = _$AdLikeCountToJson;
  Map<String, dynamic> toJson() => _$AdLikeCountToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'like_count')
  final int likeCount;
  static const fromJsonFactory = _$AdLikeCountFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdLikeCount &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.likeCount, likeCount) ||
                const DeepCollectionEquality().equals(
                  other.likeCount,
                  likeCount,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(likeCount) ^
      runtimeType.hashCode;
}

extension $AdLikeCountExtension on AdLikeCount {
  AdLikeCount copyWith({int? id, String? title, int? likeCount}) {
    return AdLikeCount(
      id: id ?? this.id,
      title: title ?? this.title,
      likeCount: likeCount ?? this.likeCount,
    );
  }

  AdLikeCount copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String>? title,
    Wrapped<int>? likeCount,
  }) {
    return AdLikeCount(
      id: (id != null ? id.value : this.id),
      title: (title != null ? title.value : this.title),
      likeCount: (likeCount != null ? likeCount.value : this.likeCount),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AdMedia {
  const AdMedia({
    this.id,
    required this.mediaUrl,
    this.thumbnailImg,
    this.videoFile,
    this.videoDuration,
  });

  factory AdMedia.fromJson(Map<String, dynamic> json) =>
      _$AdMediaFromJson(json);

  static const toJsonFactory = _$AdMediaToJson;
  Map<String, dynamic> toJson() => _$AdMediaToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'media_url')
  final String mediaUrl;
  @JsonKey(name: 'thumbnail_img')
  final String? thumbnailImg;
  @JsonKey(name: 'video_file')
  final String? videoFile;
  @JsonKey(name: 'video_duration')
  final int? videoDuration;
  static const fromJsonFactory = _$AdMediaFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdMedia &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.mediaUrl, mediaUrl) ||
                const DeepCollectionEquality().equals(
                  other.mediaUrl,
                  mediaUrl,
                )) &&
            (identical(other.thumbnailImg, thumbnailImg) ||
                const DeepCollectionEquality().equals(
                  other.thumbnailImg,
                  thumbnailImg,
                )) &&
            (identical(other.videoFile, videoFile) ||
                const DeepCollectionEquality().equals(
                  other.videoFile,
                  videoFile,
                )) &&
            (identical(other.videoDuration, videoDuration) ||
                const DeepCollectionEquality().equals(
                  other.videoDuration,
                  videoDuration,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(mediaUrl) ^
      const DeepCollectionEquality().hash(thumbnailImg) ^
      const DeepCollectionEquality().hash(videoFile) ^
      const DeepCollectionEquality().hash(videoDuration) ^
      runtimeType.hashCode;
}

extension $AdMediaExtension on AdMedia {
  AdMedia copyWith({
    int? id,
    String? mediaUrl,
    String? thumbnailImg,
    String? videoFile,
    int? videoDuration,
  }) {
    return AdMedia(
      id: id ?? this.id,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      thumbnailImg: thumbnailImg ?? this.thumbnailImg,
      videoFile: videoFile ?? this.videoFile,
      videoDuration: videoDuration ?? this.videoDuration,
    );
  }

  AdMedia copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String>? mediaUrl,
    Wrapped<String?>? thumbnailImg,
    Wrapped<String?>? videoFile,
    Wrapped<int?>? videoDuration,
  }) {
    return AdMedia(
      id: (id != null ? id.value : this.id),
      mediaUrl: (mediaUrl != null ? mediaUrl.value : this.mediaUrl),
      thumbnailImg: (thumbnailImg != null
          ? thumbnailImg.value
          : this.thumbnailImg),
      videoFile: (videoFile != null ? videoFile.value : this.videoFile),
      videoDuration: (videoDuration != null
          ? videoDuration.value
          : this.videoDuration),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AdMediaRequest {
  const AdMediaRequest({
    required this.mediaUrl,
    this.thumbnailImg,
    this.videoFile,
    this.videoDuration,
  });

  factory AdMediaRequest.fromJson(Map<String, dynamic> json) =>
      _$AdMediaRequestFromJson(json);

  static const toJsonFactory = _$AdMediaRequestToJson;
  Map<String, dynamic> toJson() => _$AdMediaRequestToJson(this);

  @JsonKey(name: 'media_url')
  final String mediaUrl;
  @JsonKey(name: 'thumbnail_img')
  final String? thumbnailImg;
  @JsonKey(name: 'video_file')
  final String? videoFile;
  @JsonKey(name: 'video_duration')
  final int? videoDuration;
  static const fromJsonFactory = _$AdMediaRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdMediaRequest &&
            (identical(other.mediaUrl, mediaUrl) ||
                const DeepCollectionEquality().equals(
                  other.mediaUrl,
                  mediaUrl,
                )) &&
            (identical(other.thumbnailImg, thumbnailImg) ||
                const DeepCollectionEquality().equals(
                  other.thumbnailImg,
                  thumbnailImg,
                )) &&
            (identical(other.videoFile, videoFile) ||
                const DeepCollectionEquality().equals(
                  other.videoFile,
                  videoFile,
                )) &&
            (identical(other.videoDuration, videoDuration) ||
                const DeepCollectionEquality().equals(
                  other.videoDuration,
                  videoDuration,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(mediaUrl) ^
      const DeepCollectionEquality().hash(thumbnailImg) ^
      const DeepCollectionEquality().hash(videoFile) ^
      const DeepCollectionEquality().hash(videoDuration) ^
      runtimeType.hashCode;
}

extension $AdMediaRequestExtension on AdMediaRequest {
  AdMediaRequest copyWith({
    String? mediaUrl,
    String? thumbnailImg,
    String? videoFile,
    int? videoDuration,
  }) {
    return AdMediaRequest(
      mediaUrl: mediaUrl ?? this.mediaUrl,
      thumbnailImg: thumbnailImg ?? this.thumbnailImg,
      videoFile: videoFile ?? this.videoFile,
      videoDuration: videoDuration ?? this.videoDuration,
    );
  }

  AdMediaRequest copyWithWrapped({
    Wrapped<String>? mediaUrl,
    Wrapped<String?>? thumbnailImg,
    Wrapped<String?>? videoFile,
    Wrapped<int?>? videoDuration,
  }) {
    return AdMediaRequest(
      mediaUrl: (mediaUrl != null ? mediaUrl.value : this.mediaUrl),
      thumbnailImg: (thumbnailImg != null
          ? thumbnailImg.value
          : this.thumbnailImg),
      videoFile: (videoFile != null ? videoFile.value : this.videoFile),
      videoDuration: (videoDuration != null
          ? videoDuration.value
          : this.videoDuration),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AdMetricEventRequest {
  const AdMetricEventRequest({required this.adId, required this.eventType});

  factory AdMetricEventRequest.fromJson(Map<String, dynamic> json) =>
      _$AdMetricEventRequestFromJson(json);

  static const toJsonFactory = _$AdMetricEventRequestToJson;
  Map<String, dynamic> toJson() => _$AdMetricEventRequestToJson(this);

  @JsonKey(name: 'ad_id')
  final int adId;
  @JsonKey(
    name: 'event_type',
    toJson: eventTypeEnumToJson,
    fromJson: eventTypeEnumFromJson,
  )
  final enums.EventTypeEnum eventType;
  static const fromJsonFactory = _$AdMetricEventRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdMetricEventRequest &&
            (identical(other.adId, adId) ||
                const DeepCollectionEquality().equals(other.adId, adId)) &&
            (identical(other.eventType, eventType) ||
                const DeepCollectionEquality().equals(
                  other.eventType,
                  eventType,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(adId) ^
      const DeepCollectionEquality().hash(eventType) ^
      runtimeType.hashCode;
}

extension $AdMetricEventRequestExtension on AdMetricEventRequest {
  AdMetricEventRequest copyWith({int? adId, enums.EventTypeEnum? eventType}) {
    return AdMetricEventRequest(
      adId: adId ?? this.adId,
      eventType: eventType ?? this.eventType,
    );
  }

  AdMetricEventRequest copyWithWrapped({
    Wrapped<int>? adId,
    Wrapped<enums.EventTypeEnum>? eventType,
  }) {
    return AdMetricEventRequest(
      adId: (adId != null ? adId.value : this.adId),
      eventType: (eventType != null ? eventType.value : this.eventType),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AdPerformanceSummaryResponse {
  const AdPerformanceSummaryResponse({required this.summary});

  factory AdPerformanceSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$AdPerformanceSummaryResponseFromJson(json);

  static const toJsonFactory = _$AdPerformanceSummaryResponseToJson;
  Map<String, dynamic> toJson() => _$AdPerformanceSummaryResponseToJson(this);

  @JsonKey(name: 'summary')
  final Map<String, dynamic> summary;
  static const fromJsonFactory = _$AdPerformanceSummaryResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdPerformanceSummaryResponse &&
            (identical(other.summary, summary) ||
                const DeepCollectionEquality().equals(other.summary, summary)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(summary) ^ runtimeType.hashCode;
}

extension $AdPerformanceSummaryResponseExtension
    on AdPerformanceSummaryResponse {
  AdPerformanceSummaryResponse copyWith({Map<String, dynamic>? summary}) {
    return AdPerformanceSummaryResponse(summary: summary ?? this.summary);
  }

  AdPerformanceSummaryResponse copyWithWrapped({
    Wrapped<Map<String, dynamic>>? summary,
  }) {
    return AdPerformanceSummaryResponse(
      summary: (summary != null ? summary.value : this.summary),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AdRecommend {
  const AdRecommend({
    this.id,
    required this.title,
    this.rewardPoint,
    required this.redirectUrl,
    this.mediaUrl,
  });

  factory AdRecommend.fromJson(Map<String, dynamic> json) =>
      _$AdRecommendFromJson(json);

  static const toJsonFactory = _$AdRecommendToJson;
  Map<String, dynamic> toJson() => _$AdRecommendToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'reward_point')
  final int? rewardPoint;
  @JsonKey(name: 'redirect_url')
  final String redirectUrl;
  @JsonKey(name: 'media_url')
  final String? mediaUrl;
  static const fromJsonFactory = _$AdRecommendFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdRecommend &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.rewardPoint, rewardPoint) ||
                const DeepCollectionEquality().equals(
                  other.rewardPoint,
                  rewardPoint,
                )) &&
            (identical(other.redirectUrl, redirectUrl) ||
                const DeepCollectionEquality().equals(
                  other.redirectUrl,
                  redirectUrl,
                )) &&
            (identical(other.mediaUrl, mediaUrl) ||
                const DeepCollectionEquality().equals(
                  other.mediaUrl,
                  mediaUrl,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(rewardPoint) ^
      const DeepCollectionEquality().hash(redirectUrl) ^
      const DeepCollectionEquality().hash(mediaUrl) ^
      runtimeType.hashCode;
}

extension $AdRecommendExtension on AdRecommend {
  AdRecommend copyWith({
    int? id,
    String? title,
    int? rewardPoint,
    String? redirectUrl,
    String? mediaUrl,
  }) {
    return AdRecommend(
      id: id ?? this.id,
      title: title ?? this.title,
      rewardPoint: rewardPoint ?? this.rewardPoint,
      redirectUrl: redirectUrl ?? this.redirectUrl,
      mediaUrl: mediaUrl ?? this.mediaUrl,
    );
  }

  AdRecommend copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String>? title,
    Wrapped<int?>? rewardPoint,
    Wrapped<String>? redirectUrl,
    Wrapped<String?>? mediaUrl,
  }) {
    return AdRecommend(
      id: (id != null ? id.value : this.id),
      title: (title != null ? title.value : this.title),
      rewardPoint: (rewardPoint != null ? rewardPoint.value : this.rewardPoint),
      redirectUrl: (redirectUrl != null ? redirectUrl.value : this.redirectUrl),
      mediaUrl: (mediaUrl != null ? mediaUrl.value : this.mediaUrl),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AdRequest {
  const AdRequest({
    required this.title,
    this.description,
    this.rewardPoint,
    required this.redirectUrl,
  });

  factory AdRequest.fromJson(Map<String, dynamic> json) =>
      _$AdRequestFromJson(json);

  static const toJsonFactory = _$AdRequestToJson;
  Map<String, dynamic> toJson() => _$AdRequestToJson(this);

  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'reward_point')
  final int? rewardPoint;
  @JsonKey(name: 'redirect_url')
  final String redirectUrl;
  static const fromJsonFactory = _$AdRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdRequest &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.rewardPoint, rewardPoint) ||
                const DeepCollectionEquality().equals(
                  other.rewardPoint,
                  rewardPoint,
                )) &&
            (identical(other.redirectUrl, redirectUrl) ||
                const DeepCollectionEquality().equals(
                  other.redirectUrl,
                  redirectUrl,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(rewardPoint) ^
      const DeepCollectionEquality().hash(redirectUrl) ^
      runtimeType.hashCode;
}

extension $AdRequestExtension on AdRequest {
  AdRequest copyWith({
    String? title,
    String? description,
    int? rewardPoint,
    String? redirectUrl,
  }) {
    return AdRequest(
      title: title ?? this.title,
      description: description ?? this.description,
      rewardPoint: rewardPoint ?? this.rewardPoint,
      redirectUrl: redirectUrl ?? this.redirectUrl,
    );
  }

  AdRequest copyWithWrapped({
    Wrapped<String>? title,
    Wrapped<String?>? description,
    Wrapped<int?>? rewardPoint,
    Wrapped<String>? redirectUrl,
  }) {
    return AdRequest(
      title: (title != null ? title.value : this.title),
      description: (description != null ? description.value : this.description),
      rewardPoint: (rewardPoint != null ? rewardPoint.value : this.rewardPoint),
      redirectUrl: (redirectUrl != null ? redirectUrl.value : this.redirectUrl),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AdUploadRequest {
  const AdUploadRequest({
    required this.title,
    this.description,
    this.rewardPoint,
    required this.redirectUrl,
    required this.category,
    required this.brand,
    this.videoFile,
    this.thumbnailImg,
  });

  factory AdUploadRequest.fromJson(Map<String, dynamic> json) =>
      _$AdUploadRequestFromJson(json);

  static const toJsonFactory = _$AdUploadRequestToJson;
  Map<String, dynamic> toJson() => _$AdUploadRequestToJson(this);

  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'reward_point')
  final int? rewardPoint;
  @JsonKey(name: 'redirect_url')
  final String redirectUrl;
  @JsonKey(name: 'category')
  final int category;
  @JsonKey(name: 'brand')
  final int brand;
  @JsonKey(name: 'video_file')
  final String? videoFile;
  @JsonKey(name: 'thumbnail_img')
  final String? thumbnailImg;
  static const fromJsonFactory = _$AdUploadRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdUploadRequest &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.rewardPoint, rewardPoint) ||
                const DeepCollectionEquality().equals(
                  other.rewardPoint,
                  rewardPoint,
                )) &&
            (identical(other.redirectUrl, redirectUrl) ||
                const DeepCollectionEquality().equals(
                  other.redirectUrl,
                  redirectUrl,
                )) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality().equals(
                  other.category,
                  category,
                )) &&
            (identical(other.brand, brand) ||
                const DeepCollectionEquality().equals(other.brand, brand)) &&
            (identical(other.videoFile, videoFile) ||
                const DeepCollectionEquality().equals(
                  other.videoFile,
                  videoFile,
                )) &&
            (identical(other.thumbnailImg, thumbnailImg) ||
                const DeepCollectionEquality().equals(
                  other.thumbnailImg,
                  thumbnailImg,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(rewardPoint) ^
      const DeepCollectionEquality().hash(redirectUrl) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(brand) ^
      const DeepCollectionEquality().hash(videoFile) ^
      const DeepCollectionEquality().hash(thumbnailImg) ^
      runtimeType.hashCode;
}

extension $AdUploadRequestExtension on AdUploadRequest {
  AdUploadRequest copyWith({
    String? title,
    String? description,
    int? rewardPoint,
    String? redirectUrl,
    int? category,
    int? brand,
    String? videoFile,
    String? thumbnailImg,
  }) {
    return AdUploadRequest(
      title: title ?? this.title,
      description: description ?? this.description,
      rewardPoint: rewardPoint ?? this.rewardPoint,
      redirectUrl: redirectUrl ?? this.redirectUrl,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      videoFile: videoFile ?? this.videoFile,
      thumbnailImg: thumbnailImg ?? this.thumbnailImg,
    );
  }

  AdUploadRequest copyWithWrapped({
    Wrapped<String>? title,
    Wrapped<String?>? description,
    Wrapped<int?>? rewardPoint,
    Wrapped<String>? redirectUrl,
    Wrapped<int>? category,
    Wrapped<int>? brand,
    Wrapped<String?>? videoFile,
    Wrapped<String?>? thumbnailImg,
  }) {
    return AdUploadRequest(
      title: (title != null ? title.value : this.title),
      description: (description != null ? description.value : this.description),
      rewardPoint: (rewardPoint != null ? rewardPoint.value : this.rewardPoint),
      redirectUrl: (redirectUrl != null ? redirectUrl.value : this.redirectUrl),
      category: (category != null ? category.value : this.category),
      brand: (brand != null ? brand.value : this.brand),
      videoFile: (videoFile != null ? videoFile.value : this.videoFile),
      thumbnailImg: (thumbnailImg != null
          ? thumbnailImg.value
          : this.thumbnailImg),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AdUploadResponse {
  const AdUploadResponse({required this.success, required this.adId});

  factory AdUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$AdUploadResponseFromJson(json);

  static const toJsonFactory = _$AdUploadResponseToJson;
  Map<String, dynamic> toJson() => _$AdUploadResponseToJson(this);

  @JsonKey(name: 'success')
  final bool success;
  @JsonKey(name: 'ad_id')
  final int adId;
  static const fromJsonFactory = _$AdUploadResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdUploadResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.adId, adId) ||
                const DeepCollectionEquality().equals(other.adId, adId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(adId) ^
      runtimeType.hashCode;
}

extension $AdUploadResponseExtension on AdUploadResponse {
  AdUploadResponse copyWith({bool? success, int? adId}) {
    return AdUploadResponse(
      success: success ?? this.success,
      adId: adId ?? this.adId,
    );
  }

  AdUploadResponse copyWithWrapped({
    Wrapped<bool>? success,
    Wrapped<int>? adId,
  }) {
    return AdUploadResponse(
      success: (success != null ? success.value : this.success),
      adId: (adId != null ? adId.value : this.adId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AdvertiserDetail {
  const AdvertiserDetail({
    this.id,
    required this.name,
    this.description,
    this.homepageUrl,
    this.businessInfo,
    this.outsourcingCompanies,
    this.brands,
  });

  factory AdvertiserDetail.fromJson(Map<String, dynamic> json) =>
      _$AdvertiserDetailFromJson(json);

  static const toJsonFactory = _$AdvertiserDetailToJson;
  Map<String, dynamic> toJson() => _$AdvertiserDetailToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'homepage_url')
  final String? homepageUrl;
  @JsonKey(name: 'business_info')
  final BusinessInfo? businessInfo;
  @JsonKey(name: 'outsourcing_companies', defaultValue: <OutsourcingCompany>[])
  final List<OutsourcingCompany>? outsourcingCompanies;
  @JsonKey(name: 'brands', defaultValue: <Brand>[])
  final List<Brand>? brands;
  static const fromJsonFactory = _$AdvertiserDetailFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdvertiserDetail &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.homepageUrl, homepageUrl) ||
                const DeepCollectionEquality().equals(
                  other.homepageUrl,
                  homepageUrl,
                )) &&
            (identical(other.businessInfo, businessInfo) ||
                const DeepCollectionEquality().equals(
                  other.businessInfo,
                  businessInfo,
                )) &&
            (identical(other.outsourcingCompanies, outsourcingCompanies) ||
                const DeepCollectionEquality().equals(
                  other.outsourcingCompanies,
                  outsourcingCompanies,
                )) &&
            (identical(other.brands, brands) ||
                const DeepCollectionEquality().equals(other.brands, brands)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(homepageUrl) ^
      const DeepCollectionEquality().hash(businessInfo) ^
      const DeepCollectionEquality().hash(outsourcingCompanies) ^
      const DeepCollectionEquality().hash(brands) ^
      runtimeType.hashCode;
}

extension $AdvertiserDetailExtension on AdvertiserDetail {
  AdvertiserDetail copyWith({
    int? id,
    String? name,
    String? description,
    String? homepageUrl,
    BusinessInfo? businessInfo,
    List<OutsourcingCompany>? outsourcingCompanies,
    List<Brand>? brands,
  }) {
    return AdvertiserDetail(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      homepageUrl: homepageUrl ?? this.homepageUrl,
      businessInfo: businessInfo ?? this.businessInfo,
      outsourcingCompanies: outsourcingCompanies ?? this.outsourcingCompanies,
      brands: brands ?? this.brands,
    );
  }

  AdvertiserDetail copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String>? name,
    Wrapped<String?>? description,
    Wrapped<String?>? homepageUrl,
    Wrapped<BusinessInfo?>? businessInfo,
    Wrapped<List<OutsourcingCompany>?>? outsourcingCompanies,
    Wrapped<List<Brand>?>? brands,
  }) {
    return AdvertiserDetail(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      homepageUrl: (homepageUrl != null ? homepageUrl.value : this.homepageUrl),
      businessInfo: (businessInfo != null
          ? businessInfo.value
          : this.businessInfo),
      outsourcingCompanies: (outsourcingCompanies != null
          ? outsourcingCompanies.value
          : this.outsourcingCompanies),
      brands: (brands != null ? brands.value : this.brands),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AdvertiserUpdateRequest {
  const AdvertiserUpdateRequest({
    required this.name,
    this.description,
    this.homepageUrl,
    required this.businessInfo,
    required this.outsourcingCompanies,
    required this.brands,
  });

  factory AdvertiserUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$AdvertiserUpdateRequestFromJson(json);

  static const toJsonFactory = _$AdvertiserUpdateRequestToJson;
  Map<String, dynamic> toJson() => _$AdvertiserUpdateRequestToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'homepage_url')
  final String? homepageUrl;
  @JsonKey(name: 'business_info')
  final BusinessInfoRequest businessInfo;
  @JsonKey(
    name: 'outsourcing_companies',
    defaultValue: <OutsourcingCompanyRequest>[],
  )
  final List<OutsourcingCompanyRequest> outsourcingCompanies;
  @JsonKey(name: 'brands', defaultValue: <BrandRequest>[])
  final List<BrandRequest> brands;
  static const fromJsonFactory = _$AdvertiserUpdateRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdvertiserUpdateRequest &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.homepageUrl, homepageUrl) ||
                const DeepCollectionEquality().equals(
                  other.homepageUrl,
                  homepageUrl,
                )) &&
            (identical(other.businessInfo, businessInfo) ||
                const DeepCollectionEquality().equals(
                  other.businessInfo,
                  businessInfo,
                )) &&
            (identical(other.outsourcingCompanies, outsourcingCompanies) ||
                const DeepCollectionEquality().equals(
                  other.outsourcingCompanies,
                  outsourcingCompanies,
                )) &&
            (identical(other.brands, brands) ||
                const DeepCollectionEquality().equals(other.brands, brands)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(homepageUrl) ^
      const DeepCollectionEquality().hash(businessInfo) ^
      const DeepCollectionEquality().hash(outsourcingCompanies) ^
      const DeepCollectionEquality().hash(brands) ^
      runtimeType.hashCode;
}

extension $AdvertiserUpdateRequestExtension on AdvertiserUpdateRequest {
  AdvertiserUpdateRequest copyWith({
    String? name,
    String? description,
    String? homepageUrl,
    BusinessInfoRequest? businessInfo,
    List<OutsourcingCompanyRequest>? outsourcingCompanies,
    List<BrandRequest>? brands,
  }) {
    return AdvertiserUpdateRequest(
      name: name ?? this.name,
      description: description ?? this.description,
      homepageUrl: homepageUrl ?? this.homepageUrl,
      businessInfo: businessInfo ?? this.businessInfo,
      outsourcingCompanies: outsourcingCompanies ?? this.outsourcingCompanies,
      brands: brands ?? this.brands,
    );
  }

  AdvertiserUpdateRequest copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? description,
    Wrapped<String?>? homepageUrl,
    Wrapped<BusinessInfoRequest>? businessInfo,
    Wrapped<List<OutsourcingCompanyRequest>>? outsourcingCompanies,
    Wrapped<List<BrandRequest>>? brands,
  }) {
    return AdvertiserUpdateRequest(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      homepageUrl: (homepageUrl != null ? homepageUrl.value : this.homepageUrl),
      businessInfo: (businessInfo != null
          ? businessInfo.value
          : this.businessInfo),
      outsourcingCompanies: (outsourcingCompanies != null
          ? outsourcingCompanies.value
          : this.outsourcingCompanies),
      brands: (brands != null ? brands.value : this.brands),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Brand {
  const Brand({required this.name, this.description});

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  static const toJsonFactory = _$BrandToJson;
  Map<String, dynamic> toJson() => _$BrandToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String? description;
  static const fromJsonFactory = _$BrandFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Brand &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $BrandExtension on Brand {
  Brand copyWith({String? name, String? description}) {
    return Brand(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Brand copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? description,
  }) {
    return Brand(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BrandRequest {
  const BrandRequest({required this.name, this.description});

  factory BrandRequest.fromJson(Map<String, dynamic> json) =>
      _$BrandRequestFromJson(json);

  static const toJsonFactory = _$BrandRequestToJson;
  Map<String, dynamic> toJson() => _$BrandRequestToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String? description;
  static const fromJsonFactory = _$BrandRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BrandRequest &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $BrandRequestExtension on BrandRequest {
  BrandRequest copyWith({String? name, String? description}) {
    return BrandRequest(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  BrandRequest copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? description,
  }) {
    return BrandRequest(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BusinessInfo {
  const BusinessInfo({
    required this.companyName,
    this.companyNameEn,
    this.homepageUrl,
    this.logoUrl,
    this.representative,
    this.email,
    this.phoneNo,
  });

  factory BusinessInfo.fromJson(Map<String, dynamic> json) =>
      _$BusinessInfoFromJson(json);

  static const toJsonFactory = _$BusinessInfoToJson;
  Map<String, dynamic> toJson() => _$BusinessInfoToJson(this);

  @JsonKey(name: 'company_name')
  final String companyName;
  @JsonKey(name: 'company_name_en')
  final String? companyNameEn;
  @JsonKey(name: 'homepage_url')
  final String? homepageUrl;
  @JsonKey(name: 'logo_url')
  final String? logoUrl;
  @JsonKey(name: 'representative')
  final String? representative;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone_no')
  final String? phoneNo;
  static const fromJsonFactory = _$BusinessInfoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BusinessInfo &&
            (identical(other.companyName, companyName) ||
                const DeepCollectionEquality().equals(
                  other.companyName,
                  companyName,
                )) &&
            (identical(other.companyNameEn, companyNameEn) ||
                const DeepCollectionEquality().equals(
                  other.companyNameEn,
                  companyNameEn,
                )) &&
            (identical(other.homepageUrl, homepageUrl) ||
                const DeepCollectionEquality().equals(
                  other.homepageUrl,
                  homepageUrl,
                )) &&
            (identical(other.logoUrl, logoUrl) ||
                const DeepCollectionEquality().equals(
                  other.logoUrl,
                  logoUrl,
                )) &&
            (identical(other.representative, representative) ||
                const DeepCollectionEquality().equals(
                  other.representative,
                  representative,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNo, phoneNo) ||
                const DeepCollectionEquality().equals(other.phoneNo, phoneNo)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(companyName) ^
      const DeepCollectionEquality().hash(companyNameEn) ^
      const DeepCollectionEquality().hash(homepageUrl) ^
      const DeepCollectionEquality().hash(logoUrl) ^
      const DeepCollectionEquality().hash(representative) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phoneNo) ^
      runtimeType.hashCode;
}

extension $BusinessInfoExtension on BusinessInfo {
  BusinessInfo copyWith({
    String? companyName,
    String? companyNameEn,
    String? homepageUrl,
    String? logoUrl,
    String? representative,
    String? email,
    String? phoneNo,
  }) {
    return BusinessInfo(
      companyName: companyName ?? this.companyName,
      companyNameEn: companyNameEn ?? this.companyNameEn,
      homepageUrl: homepageUrl ?? this.homepageUrl,
      logoUrl: logoUrl ?? this.logoUrl,
      representative: representative ?? this.representative,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
    );
  }

  BusinessInfo copyWithWrapped({
    Wrapped<String>? companyName,
    Wrapped<String?>? companyNameEn,
    Wrapped<String?>? homepageUrl,
    Wrapped<String?>? logoUrl,
    Wrapped<String?>? representative,
    Wrapped<String?>? email,
    Wrapped<String?>? phoneNo,
  }) {
    return BusinessInfo(
      companyName: (companyName != null ? companyName.value : this.companyName),
      companyNameEn: (companyNameEn != null
          ? companyNameEn.value
          : this.companyNameEn),
      homepageUrl: (homepageUrl != null ? homepageUrl.value : this.homepageUrl),
      logoUrl: (logoUrl != null ? logoUrl.value : this.logoUrl),
      representative: (representative != null
          ? representative.value
          : this.representative),
      email: (email != null ? email.value : this.email),
      phoneNo: (phoneNo != null ? phoneNo.value : this.phoneNo),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BusinessInfoRequest {
  const BusinessInfoRequest({
    required this.companyName,
    this.companyNameEn,
    this.homepageUrl,
    this.logoUrl,
    this.representative,
    this.email,
    this.phoneNo,
  });

  factory BusinessInfoRequest.fromJson(Map<String, dynamic> json) =>
      _$BusinessInfoRequestFromJson(json);

  static const toJsonFactory = _$BusinessInfoRequestToJson;
  Map<String, dynamic> toJson() => _$BusinessInfoRequestToJson(this);

  @JsonKey(name: 'company_name')
  final String companyName;
  @JsonKey(name: 'company_name_en')
  final String? companyNameEn;
  @JsonKey(name: 'homepage_url')
  final String? homepageUrl;
  @JsonKey(name: 'logo_url')
  final String? logoUrl;
  @JsonKey(name: 'representative')
  final String? representative;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone_no')
  final String? phoneNo;
  static const fromJsonFactory = _$BusinessInfoRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BusinessInfoRequest &&
            (identical(other.companyName, companyName) ||
                const DeepCollectionEquality().equals(
                  other.companyName,
                  companyName,
                )) &&
            (identical(other.companyNameEn, companyNameEn) ||
                const DeepCollectionEquality().equals(
                  other.companyNameEn,
                  companyNameEn,
                )) &&
            (identical(other.homepageUrl, homepageUrl) ||
                const DeepCollectionEquality().equals(
                  other.homepageUrl,
                  homepageUrl,
                )) &&
            (identical(other.logoUrl, logoUrl) ||
                const DeepCollectionEquality().equals(
                  other.logoUrl,
                  logoUrl,
                )) &&
            (identical(other.representative, representative) ||
                const DeepCollectionEquality().equals(
                  other.representative,
                  representative,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNo, phoneNo) ||
                const DeepCollectionEquality().equals(other.phoneNo, phoneNo)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(companyName) ^
      const DeepCollectionEquality().hash(companyNameEn) ^
      const DeepCollectionEquality().hash(homepageUrl) ^
      const DeepCollectionEquality().hash(logoUrl) ^
      const DeepCollectionEquality().hash(representative) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phoneNo) ^
      runtimeType.hashCode;
}

extension $BusinessInfoRequestExtension on BusinessInfoRequest {
  BusinessInfoRequest copyWith({
    String? companyName,
    String? companyNameEn,
    String? homepageUrl,
    String? logoUrl,
    String? representative,
    String? email,
    String? phoneNo,
  }) {
    return BusinessInfoRequest(
      companyName: companyName ?? this.companyName,
      companyNameEn: companyNameEn ?? this.companyNameEn,
      homepageUrl: homepageUrl ?? this.homepageUrl,
      logoUrl: logoUrl ?? this.logoUrl,
      representative: representative ?? this.representative,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
    );
  }

  BusinessInfoRequest copyWithWrapped({
    Wrapped<String>? companyName,
    Wrapped<String?>? companyNameEn,
    Wrapped<String?>? homepageUrl,
    Wrapped<String?>? logoUrl,
    Wrapped<String?>? representative,
    Wrapped<String?>? email,
    Wrapped<String?>? phoneNo,
  }) {
    return BusinessInfoRequest(
      companyName: (companyName != null ? companyName.value : this.companyName),
      companyNameEn: (companyNameEn != null
          ? companyNameEn.value
          : this.companyNameEn),
      homepageUrl: (homepageUrl != null ? homepageUrl.value : this.homepageUrl),
      logoUrl: (logoUrl != null ? logoUrl.value : this.logoUrl),
      representative: (representative != null
          ? representative.value
          : this.representative),
      email: (email != null ? email.value : this.email),
      phoneNo: (phoneNo != null ? phoneNo.value : this.phoneNo),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CampaignBudgetChargeRequest {
  const CampaignBudgetChargeRequest({required this.amount});

  factory CampaignBudgetChargeRequest.fromJson(Map<String, dynamic> json) =>
      _$CampaignBudgetChargeRequestFromJson(json);

  static const toJsonFactory = _$CampaignBudgetChargeRequestToJson;
  Map<String, dynamic> toJson() => _$CampaignBudgetChargeRequestToJson(this);

  @JsonKey(name: 'amount')
  final double amount;
  static const fromJsonFactory = _$CampaignBudgetChargeRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CampaignBudgetChargeRequest &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(amount) ^ runtimeType.hashCode;
}

extension $CampaignBudgetChargeRequestExtension on CampaignBudgetChargeRequest {
  CampaignBudgetChargeRequest copyWith({double? amount}) {
    return CampaignBudgetChargeRequest(amount: amount ?? this.amount);
  }

  CampaignBudgetChargeRequest copyWithWrapped({Wrapped<double>? amount}) {
    return CampaignBudgetChargeRequest(
      amount: (amount != null ? amount.value : this.amount),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CampaignDurationExtendRequest {
  const CampaignDurationExtendRequest({required this.newEndDate});

  factory CampaignDurationExtendRequest.fromJson(Map<String, dynamic> json) =>
      _$CampaignDurationExtendRequestFromJson(json);

  static const toJsonFactory = _$CampaignDurationExtendRequestToJson;
  Map<String, dynamic> toJson() => _$CampaignDurationExtendRequestToJson(this);

  @JsonKey(name: 'new_end_date', toJson: _dateToJson)
  final DateTime newEndDate;
  static const fromJsonFactory = _$CampaignDurationExtendRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CampaignDurationExtendRequest &&
            (identical(other.newEndDate, newEndDate) ||
                const DeepCollectionEquality().equals(
                  other.newEndDate,
                  newEndDate,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(newEndDate) ^ runtimeType.hashCode;
}

extension $CampaignDurationExtendRequestExtension
    on CampaignDurationExtendRequest {
  CampaignDurationExtendRequest copyWith({DateTime? newEndDate}) {
    return CampaignDurationExtendRequest(
      newEndDate: newEndDate ?? this.newEndDate,
    );
  }

  CampaignDurationExtendRequest copyWithWrapped({
    Wrapped<DateTime>? newEndDate,
  }) {
    return CampaignDurationExtendRequest(
      newEndDate: (newEndDate != null ? newEndDate.value : this.newEndDate),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ErrorResponse {
  const ErrorResponse({required this.success, required this.error});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  static const toJsonFactory = _$ErrorResponseToJson;
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

  @JsonKey(name: 'success')
  final bool success;
  @JsonKey(name: 'error')
  final String error;
  static const fromJsonFactory = _$ErrorResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ErrorResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(error) ^
      runtimeType.hashCode;
}

extension $ErrorResponseExtension on ErrorResponse {
  ErrorResponse copyWith({bool? success, String? error}) {
    return ErrorResponse(
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }

  ErrorResponse copyWithWrapped({
    Wrapped<bool>? success,
    Wrapped<String>? error,
  }) {
    return ErrorResponse(
      success: (success != null ? success.value : this.success),
      error: (error != null ? error.value : this.error),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class EventRecordResponse {
  const EventRecordResponse({required this.success, required this.message});

  factory EventRecordResponse.fromJson(Map<String, dynamic> json) =>
      _$EventRecordResponseFromJson(json);

  static const toJsonFactory = _$EventRecordResponseToJson;
  Map<String, dynamic> toJson() => _$EventRecordResponseToJson(this);

  @JsonKey(name: 'success')
  final bool success;
  @JsonKey(name: 'message')
  final String message;
  static const fromJsonFactory = _$EventRecordResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EventRecordResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(message) ^
      runtimeType.hashCode;
}

extension $EventRecordResponseExtension on EventRecordResponse {
  EventRecordResponse copyWith({bool? success, String? message}) {
    return EventRecordResponse(
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  EventRecordResponse copyWithWrapped({
    Wrapped<bool>? success,
    Wrapped<String>? message,
  }) {
    return EventRecordResponse(
      success: (success != null ? success.value : this.success),
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class LikeCountResponse {
  const LikeCountResponse({required this.likeCount});

  factory LikeCountResponse.fromJson(Map<String, dynamic> json) =>
      _$LikeCountResponseFromJson(json);

  static const toJsonFactory = _$LikeCountResponseToJson;
  Map<String, dynamic> toJson() => _$LikeCountResponseToJson(this);

  @JsonKey(name: 'like_count')
  final int likeCount;
  static const fromJsonFactory = _$LikeCountResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LikeCountResponse &&
            (identical(other.likeCount, likeCount) ||
                const DeepCollectionEquality().equals(
                  other.likeCount,
                  likeCount,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(likeCount) ^ runtimeType.hashCode;
}

extension $LikeCountResponseExtension on LikeCountResponse {
  LikeCountResponse copyWith({int? likeCount}) {
    return LikeCountResponse(likeCount: likeCount ?? this.likeCount);
  }

  LikeCountResponse copyWithWrapped({Wrapped<int>? likeCount}) {
    return LikeCountResponse(
      likeCount: (likeCount != null ? likeCount.value : this.likeCount),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class LoginRequest {
  const LoginRequest({required this.username, this.password, this.fcmToken});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  static const toJsonFactory = _$LoginRequestToJson;
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'fcm_token')
  final String? fcmToken;
  static const fromJsonFactory = _$LoginRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LoginRequest &&
            (identical(other.username, username) ||
                const DeepCollectionEquality().equals(
                  other.username,
                  username,
                )) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )) &&
            (identical(other.fcmToken, fcmToken) ||
                const DeepCollectionEquality().equals(
                  other.fcmToken,
                  fcmToken,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(fcmToken) ^
      runtimeType.hashCode;
}

extension $LoginRequestExtension on LoginRequest {
  LoginRequest copyWith({
    String? username,
    String? password,
    String? fcmToken,
  }) {
    return LoginRequest(
      username: username ?? this.username,
      password: password ?? this.password,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  LoginRequest copyWithWrapped({
    Wrapped<String>? username,
    Wrapped<String?>? password,
    Wrapped<String?>? fcmToken,
  }) {
    return LoginRequest(
      username: (username != null ? username.value : this.username),
      password: (password != null ? password.value : this.password),
      fcmToken: (fcmToken != null ? fcmToken.value : this.fcmToken),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class LoginResponse {
  const LoginResponse({
    required this.access,
    required this.refresh,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  static const toJsonFactory = _$LoginResponseToJson;
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @JsonKey(name: 'access')
  final String access;
  @JsonKey(name: 'refresh')
  final String refresh;
  @JsonKey(name: 'user')
  final UserInfo user;
  static const fromJsonFactory = _$LoginResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LoginResponse &&
            (identical(other.access, access) ||
                const DeepCollectionEquality().equals(other.access, access)) &&
            (identical(other.refresh, refresh) ||
                const DeepCollectionEquality().equals(
                  other.refresh,
                  refresh,
                )) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(access) ^
      const DeepCollectionEquality().hash(refresh) ^
      const DeepCollectionEquality().hash(user) ^
      runtimeType.hashCode;
}

extension $LoginResponseExtension on LoginResponse {
  LoginResponse copyWith({String? access, String? refresh, UserInfo? user}) {
    return LoginResponse(
      access: access ?? this.access,
      refresh: refresh ?? this.refresh,
      user: user ?? this.user,
    );
  }

  LoginResponse copyWithWrapped({
    Wrapped<String>? access,
    Wrapped<String>? refresh,
    Wrapped<UserInfo>? user,
  }) {
    return LoginResponse(
      access: (access != null ? access.value : this.access),
      refresh: (refresh != null ? refresh.value : this.refresh),
      user: (user != null ? user.value : this.user),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class LogoutRequestRequest {
  const LogoutRequestRequest({required this.refresh});

  factory LogoutRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$LogoutRequestRequestFromJson(json);

  static const toJsonFactory = _$LogoutRequestRequestToJson;
  Map<String, dynamic> toJson() => _$LogoutRequestRequestToJson(this);

  @JsonKey(name: 'refresh')
  final String refresh;
  static const fromJsonFactory = _$LogoutRequestRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LogoutRequestRequest &&
            (identical(other.refresh, refresh) ||
                const DeepCollectionEquality().equals(other.refresh, refresh)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(refresh) ^ runtimeType.hashCode;
}

extension $LogoutRequestRequestExtension on LogoutRequestRequest {
  LogoutRequestRequest copyWith({String? refresh}) {
    return LogoutRequestRequest(refresh: refresh ?? this.refresh);
  }

  LogoutRequestRequest copyWithWrapped({Wrapped<String>? refresh}) {
    return LogoutRequestRequest(
      refresh: (refresh != null ? refresh.value : this.refresh),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class LogoutResponse {
  const LogoutResponse({required this.success, required this.message});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) =>
      _$LogoutResponseFromJson(json);

  static const toJsonFactory = _$LogoutResponseToJson;
  Map<String, dynamic> toJson() => _$LogoutResponseToJson(this);

  @JsonKey(name: 'success')
  final bool success;
  @JsonKey(name: 'message')
  final String message;
  static const fromJsonFactory = _$LogoutResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LogoutResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(message) ^
      runtimeType.hashCode;
}

extension $LogoutResponseExtension on LogoutResponse {
  LogoutResponse copyWith({bool? success, String? message}) {
    return LogoutResponse(
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  LogoutResponse copyWithWrapped({
    Wrapped<bool>? success,
    Wrapped<String>? message,
  }) {
    return LogoutResponse(
      success: (success != null ? success.value : this.success),
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class NotFoundResponse {
  const NotFoundResponse({required this.error});

  factory NotFoundResponse.fromJson(Map<String, dynamic> json) =>
      _$NotFoundResponseFromJson(json);

  static const toJsonFactory = _$NotFoundResponseToJson;
  Map<String, dynamic> toJson() => _$NotFoundResponseToJson(this);

  @JsonKey(name: 'error')
  final String error;
  static const fromJsonFactory = _$NotFoundResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is NotFoundResponse &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(error) ^ runtimeType.hashCode;
}

extension $NotFoundResponseExtension on NotFoundResponse {
  NotFoundResponse copyWith({String? error}) {
    return NotFoundResponse(error: error ?? this.error);
  }

  NotFoundResponse copyWithWrapped({Wrapped<String>? error}) {
    return NotFoundResponse(error: (error != null ? error.value : this.error));
  }
}

@JsonSerializable(explicitToJson: true)
class OutsourcingCompany {
  const OutsourcingCompany({required this.name, this.description});

  factory OutsourcingCompany.fromJson(Map<String, dynamic> json) =>
      _$OutsourcingCompanyFromJson(json);

  static const toJsonFactory = _$OutsourcingCompanyToJson;
  Map<String, dynamic> toJson() => _$OutsourcingCompanyToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String? description;
  static const fromJsonFactory = _$OutsourcingCompanyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OutsourcingCompany &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $OutsourcingCompanyExtension on OutsourcingCompany {
  OutsourcingCompany copyWith({String? name, String? description}) {
    return OutsourcingCompany(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  OutsourcingCompany copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? description,
  }) {
    return OutsourcingCompany(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class OutsourcingCompanyRequest {
  const OutsourcingCompanyRequest({required this.name, this.description});

  factory OutsourcingCompanyRequest.fromJson(Map<String, dynamic> json) =>
      _$OutsourcingCompanyRequestFromJson(json);

  static const toJsonFactory = _$OutsourcingCompanyRequestToJson;
  Map<String, dynamic> toJson() => _$OutsourcingCompanyRequestToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String? description;
  static const fromJsonFactory = _$OutsourcingCompanyRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OutsourcingCompanyRequest &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $OutsourcingCompanyRequestExtension on OutsourcingCompanyRequest {
  OutsourcingCompanyRequest copyWith({String? name, String? description}) {
    return OutsourcingCompanyRequest(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  OutsourcingCompanyRequest copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? description,
  }) {
    return OutsourcingCompanyRequest(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PatchedAdCampaignRequest {
  const PatchedAdCampaignRequest({
    this.name,
    this.status,
    this.startDate,
    this.endDate,
    this.dailyBudget,
    this.totalBudget,
    this.targetGender,
    this.targetAgeMin,
    this.targetAgeMax,
    this.seeadPerView,
    this.targetInterests,
    this.targetRegions,
  });

  factory PatchedAdCampaignRequest.fromJson(Map<String, dynamic> json) =>
      _$PatchedAdCampaignRequestFromJson(json);

  static const toJsonFactory = _$PatchedAdCampaignRequestToJson;
  Map<String, dynamic> toJson() => _$PatchedAdCampaignRequestToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(
    name: 'status',
    toJson: statusEnumNullableToJson,
    fromJson: statusEnumNullableFromJson,
  )
  final enums.StatusEnum? status;
  @JsonKey(name: 'start_date', toJson: _dateToJson)
  final DateTime? startDate;
  @JsonKey(name: 'end_date', toJson: _dateToJson)
  final DateTime? endDate;
  @JsonKey(name: 'daily_budget')
  final double? dailyBudget;
  @JsonKey(name: 'total_budget')
  final double? totalBudget;
  @JsonKey(
    name: 'target_gender',
    toJson: patchedAdCampaignRequestTargetGenderNullableToJson,
    fromJson: patchedAdCampaignRequestTargetGenderNullableFromJson,
  )
  final enums.PatchedAdCampaignRequestTargetGender? targetGender;
  @JsonKey(name: 'target_age_min')
  final int? targetAgeMin;
  @JsonKey(name: 'target_age_max')
  final int? targetAgeMax;
  @JsonKey(name: 'seead_per_view')
  final int? seeadPerView;
  @JsonKey(name: 'target_interests', defaultValue: <int>[])
  final List<int>? targetInterests;
  @JsonKey(name: 'target_regions', defaultValue: <int>[])
  final List<int>? targetRegions;
  static const fromJsonFactory = _$PatchedAdCampaignRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PatchedAdCampaignRequest &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality().equals(
                  other.endDate,
                  endDate,
                )) &&
            (identical(other.dailyBudget, dailyBudget) ||
                const DeepCollectionEquality().equals(
                  other.dailyBudget,
                  dailyBudget,
                )) &&
            (identical(other.totalBudget, totalBudget) ||
                const DeepCollectionEquality().equals(
                  other.totalBudget,
                  totalBudget,
                )) &&
            (identical(other.targetGender, targetGender) ||
                const DeepCollectionEquality().equals(
                  other.targetGender,
                  targetGender,
                )) &&
            (identical(other.targetAgeMin, targetAgeMin) ||
                const DeepCollectionEquality().equals(
                  other.targetAgeMin,
                  targetAgeMin,
                )) &&
            (identical(other.targetAgeMax, targetAgeMax) ||
                const DeepCollectionEquality().equals(
                  other.targetAgeMax,
                  targetAgeMax,
                )) &&
            (identical(other.seeadPerView, seeadPerView) ||
                const DeepCollectionEquality().equals(
                  other.seeadPerView,
                  seeadPerView,
                )) &&
            (identical(other.targetInterests, targetInterests) ||
                const DeepCollectionEquality().equals(
                  other.targetInterests,
                  targetInterests,
                )) &&
            (identical(other.targetRegions, targetRegions) ||
                const DeepCollectionEquality().equals(
                  other.targetRegions,
                  targetRegions,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(dailyBudget) ^
      const DeepCollectionEquality().hash(totalBudget) ^
      const DeepCollectionEquality().hash(targetGender) ^
      const DeepCollectionEquality().hash(targetAgeMin) ^
      const DeepCollectionEquality().hash(targetAgeMax) ^
      const DeepCollectionEquality().hash(seeadPerView) ^
      const DeepCollectionEquality().hash(targetInterests) ^
      const DeepCollectionEquality().hash(targetRegions) ^
      runtimeType.hashCode;
}

extension $PatchedAdCampaignRequestExtension on PatchedAdCampaignRequest {
  PatchedAdCampaignRequest copyWith({
    String? name,
    enums.StatusEnum? status,
    DateTime? startDate,
    DateTime? endDate,
    double? dailyBudget,
    double? totalBudget,
    enums.PatchedAdCampaignRequestTargetGender? targetGender,
    int? targetAgeMin,
    int? targetAgeMax,
    int? seeadPerView,
    List<int>? targetInterests,
    List<int>? targetRegions,
  }) {
    return PatchedAdCampaignRequest(
      name: name ?? this.name,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dailyBudget: dailyBudget ?? this.dailyBudget,
      totalBudget: totalBudget ?? this.totalBudget,
      targetGender: targetGender ?? this.targetGender,
      targetAgeMin: targetAgeMin ?? this.targetAgeMin,
      targetAgeMax: targetAgeMax ?? this.targetAgeMax,
      seeadPerView: seeadPerView ?? this.seeadPerView,
      targetInterests: targetInterests ?? this.targetInterests,
      targetRegions: targetRegions ?? this.targetRegions,
    );
  }

  PatchedAdCampaignRequest copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<enums.StatusEnum?>? status,
    Wrapped<DateTime?>? startDate,
    Wrapped<DateTime?>? endDate,
    Wrapped<double?>? dailyBudget,
    Wrapped<double?>? totalBudget,
    Wrapped<enums.PatchedAdCampaignRequestTargetGender?>? targetGender,
    Wrapped<int?>? targetAgeMin,
    Wrapped<int?>? targetAgeMax,
    Wrapped<int?>? seeadPerView,
    Wrapped<List<int>?>? targetInterests,
    Wrapped<List<int>?>? targetRegions,
  }) {
    return PatchedAdCampaignRequest(
      name: (name != null ? name.value : this.name),
      status: (status != null ? status.value : this.status),
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
      dailyBudget: (dailyBudget != null ? dailyBudget.value : this.dailyBudget),
      totalBudget: (totalBudget != null ? totalBudget.value : this.totalBudget),
      targetGender: (targetGender != null
          ? targetGender.value
          : this.targetGender),
      targetAgeMin: (targetAgeMin != null
          ? targetAgeMin.value
          : this.targetAgeMin),
      targetAgeMax: (targetAgeMax != null
          ? targetAgeMax.value
          : this.targetAgeMax),
      seeadPerView: (seeadPerView != null
          ? seeadPerView.value
          : this.seeadPerView),
      targetInterests: (targetInterests != null
          ? targetInterests.value
          : this.targetInterests),
      targetRegions: (targetRegions != null
          ? targetRegions.value
          : this.targetRegions),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RewardHistory {
  const RewardHistory({
    this.id,
    this.adTitle,
    required this.points,
    this.createdAt,
  });

  factory RewardHistory.fromJson(Map<String, dynamic> json) =>
      _$RewardHistoryFromJson(json);

  static const toJsonFactory = _$RewardHistoryToJson;
  Map<String, dynamic> toJson() => _$RewardHistoryToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'ad_title')
  final String? adTitle;
  @JsonKey(name: 'points')
  final int points;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  static const fromJsonFactory = _$RewardHistoryFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RewardHistory &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.adTitle, adTitle) ||
                const DeepCollectionEquality().equals(
                  other.adTitle,
                  adTitle,
                )) &&
            (identical(other.points, points) ||
                const DeepCollectionEquality().equals(other.points, points)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(adTitle) ^
      const DeepCollectionEquality().hash(points) ^
      const DeepCollectionEquality().hash(createdAt) ^
      runtimeType.hashCode;
}

extension $RewardHistoryExtension on RewardHistory {
  RewardHistory copyWith({
    int? id,
    String? adTitle,
    int? points,
    DateTime? createdAt,
  }) {
    return RewardHistory(
      id: id ?? this.id,
      adTitle: adTitle ?? this.adTitle,
      points: points ?? this.points,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  RewardHistory copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? adTitle,
    Wrapped<int>? points,
    Wrapped<DateTime?>? createdAt,
  }) {
    return RewardHistory(
      id: (id != null ? id.value : this.id),
      adTitle: (adTitle != null ? adTitle.value : this.adTitle),
      points: (points != null ? points.value : this.points),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RewardStatus {
  const RewardStatus({
    required this.availableSeed,
    required this.todayClaimed,
    required this.dailyLimit,
  });

  factory RewardStatus.fromJson(Map<String, dynamic> json) =>
      _$RewardStatusFromJson(json);

  static const toJsonFactory = _$RewardStatusToJson;
  Map<String, dynamic> toJson() => _$RewardStatusToJson(this);

  @JsonKey(name: 'available_seed')
  final int availableSeed;
  @JsonKey(name: 'today_claimed')
  final int todayClaimed;
  @JsonKey(name: 'daily_limit')
  final int dailyLimit;
  static const fromJsonFactory = _$RewardStatusFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RewardStatus &&
            (identical(other.availableSeed, availableSeed) ||
                const DeepCollectionEquality().equals(
                  other.availableSeed,
                  availableSeed,
                )) &&
            (identical(other.todayClaimed, todayClaimed) ||
                const DeepCollectionEquality().equals(
                  other.todayClaimed,
                  todayClaimed,
                )) &&
            (identical(other.dailyLimit, dailyLimit) ||
                const DeepCollectionEquality().equals(
                  other.dailyLimit,
                  dailyLimit,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(availableSeed) ^
      const DeepCollectionEquality().hash(todayClaimed) ^
      const DeepCollectionEquality().hash(dailyLimit) ^
      runtimeType.hashCode;
}

extension $RewardStatusExtension on RewardStatus {
  RewardStatus copyWith({
    int? availableSeed,
    int? todayClaimed,
    int? dailyLimit,
  }) {
    return RewardStatus(
      availableSeed: availableSeed ?? this.availableSeed,
      todayClaimed: todayClaimed ?? this.todayClaimed,
      dailyLimit: dailyLimit ?? this.dailyLimit,
    );
  }

  RewardStatus copyWithWrapped({
    Wrapped<int>? availableSeed,
    Wrapped<int>? todayClaimed,
    Wrapped<int>? dailyLimit,
  }) {
    return RewardStatus(
      availableSeed: (availableSeed != null
          ? availableSeed.value
          : this.availableSeed),
      todayClaimed: (todayClaimed != null
          ? todayClaimed.value
          : this.todayClaimed),
      dailyLimit: (dailyLimit != null ? dailyLimit.value : this.dailyLimit),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SignupRequest {
  const SignupRequest({required this.username, this.password, this.email});

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);

  static const toJsonFactory = _$SignupRequestToJson;
  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);

  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'email')
  final String? email;
  static const fromJsonFactory = _$SignupRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SignupRequest &&
            (identical(other.username, username) ||
                const DeepCollectionEquality().equals(
                  other.username,
                  username,
                )) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(email) ^
      runtimeType.hashCode;
}

extension $SignupRequestExtension on SignupRequest {
  SignupRequest copyWith({String? username, String? password, String? email}) {
    return SignupRequest(
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
    );
  }

  SignupRequest copyWithWrapped({
    Wrapped<String>? username,
    Wrapped<String?>? password,
    Wrapped<String?>? email,
  }) {
    return SignupRequest(
      username: (username != null ? username.value : this.username),
      password: (password != null ? password.value : this.password),
      email: (email != null ? email.value : this.email),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SignupResponse {
  const SignupResponse({required this.success, required this.user});

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);

  static const toJsonFactory = _$SignupResponseToJson;
  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);

  @JsonKey(name: 'success')
  final bool success;
  @JsonKey(name: 'user')
  final UserInfo user;
  static const fromJsonFactory = _$SignupResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SignupResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(user) ^
      runtimeType.hashCode;
}

extension $SignupResponseExtension on SignupResponse {
  SignupResponse copyWith({bool? success, UserInfo? user}) {
    return SignupResponse(
      success: success ?? this.success,
      user: user ?? this.user,
    );
  }

  SignupResponse copyWithWrapped({
    Wrapped<bool>? success,
    Wrapped<UserInfo>? user,
  }) {
    return SignupResponse(
      success: (success != null ? success.value : this.success),
      user: (user != null ? user.value : this.user),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SuccessMessageResponse {
  const SuccessMessageResponse({required this.success, required this.message});

  factory SuccessMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$SuccessMessageResponseFromJson(json);

  static const toJsonFactory = _$SuccessMessageResponseToJson;
  Map<String, dynamic> toJson() => _$SuccessMessageResponseToJson(this);

  @JsonKey(name: 'success')
  final bool success;
  @JsonKey(name: 'message')
  final String message;
  static const fromJsonFactory = _$SuccessMessageResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SuccessMessageResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(message) ^
      runtimeType.hashCode;
}

extension $SuccessMessageResponseExtension on SuccessMessageResponse {
  SuccessMessageResponse copyWith({bool? success, String? message}) {
    return SuccessMessageResponse(
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  SuccessMessageResponse copyWithWrapped({
    Wrapped<bool>? success,
    Wrapped<String>? message,
  }) {
    return SuccessMessageResponse(
      success: (success != null ? success.value : this.success),
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ToggleLikeResponse {
  const ToggleLikeResponse({
    required this.success,
    required this.liked,
    required this.adId,
  });

  factory ToggleLikeResponse.fromJson(Map<String, dynamic> json) =>
      _$ToggleLikeResponseFromJson(json);

  static const toJsonFactory = _$ToggleLikeResponseToJson;
  Map<String, dynamic> toJson() => _$ToggleLikeResponseToJson(this);

  @JsonKey(name: 'success')
  final bool success;
  @JsonKey(name: 'liked')
  final bool liked;
  @JsonKey(name: 'ad_id')
  final int adId;
  static const fromJsonFactory = _$ToggleLikeResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ToggleLikeResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.liked, liked) ||
                const DeepCollectionEquality().equals(other.liked, liked)) &&
            (identical(other.adId, adId) ||
                const DeepCollectionEquality().equals(other.adId, adId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(liked) ^
      const DeepCollectionEquality().hash(adId) ^
      runtimeType.hashCode;
}

extension $ToggleLikeResponseExtension on ToggleLikeResponse {
  ToggleLikeResponse copyWith({bool? success, bool? liked, int? adId}) {
    return ToggleLikeResponse(
      success: success ?? this.success,
      liked: liked ?? this.liked,
      adId: adId ?? this.adId,
    );
  }

  ToggleLikeResponse copyWithWrapped({
    Wrapped<bool>? success,
    Wrapped<bool>? liked,
    Wrapped<int>? adId,
  }) {
    return ToggleLikeResponse(
      success: (success != null ? success.value : this.success),
      liked: (liked != null ? liked.value : this.liked),
      adId: (adId != null ? adId.value : this.adId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TokenRefresh {
  const TokenRefresh({this.access, required this.refresh});

  factory TokenRefresh.fromJson(Map<String, dynamic> json) =>
      _$TokenRefreshFromJson(json);

  static const toJsonFactory = _$TokenRefreshToJson;
  Map<String, dynamic> toJson() => _$TokenRefreshToJson(this);

  @JsonKey(name: 'access')
  final String? access;
  @JsonKey(name: 'refresh')
  final String refresh;
  static const fromJsonFactory = _$TokenRefreshFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TokenRefresh &&
            (identical(other.access, access) ||
                const DeepCollectionEquality().equals(other.access, access)) &&
            (identical(other.refresh, refresh) ||
                const DeepCollectionEquality().equals(other.refresh, refresh)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(access) ^
      const DeepCollectionEquality().hash(refresh) ^
      runtimeType.hashCode;
}

extension $TokenRefreshExtension on TokenRefresh {
  TokenRefresh copyWith({String? access, String? refresh}) {
    return TokenRefresh(
      access: access ?? this.access,
      refresh: refresh ?? this.refresh,
    );
  }

  TokenRefresh copyWithWrapped({
    Wrapped<String?>? access,
    Wrapped<String>? refresh,
  }) {
    return TokenRefresh(
      access: (access != null ? access.value : this.access),
      refresh: (refresh != null ? refresh.value : this.refresh),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TokenRefreshRequest {
  const TokenRefreshRequest({required this.refresh});

  factory TokenRefreshRequest.fromJson(Map<String, dynamic> json) =>
      _$TokenRefreshRequestFromJson(json);

  static const toJsonFactory = _$TokenRefreshRequestToJson;
  Map<String, dynamic> toJson() => _$TokenRefreshRequestToJson(this);

  @JsonKey(name: 'refresh')
  final String refresh;
  static const fromJsonFactory = _$TokenRefreshRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TokenRefreshRequest &&
            (identical(other.refresh, refresh) ||
                const DeepCollectionEquality().equals(other.refresh, refresh)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(refresh) ^ runtimeType.hashCode;
}

extension $TokenRefreshRequestExtension on TokenRefreshRequest {
  TokenRefreshRequest copyWith({String? refresh}) {
    return TokenRefreshRequest(refresh: refresh ?? this.refresh);
  }

  TokenRefreshRequest copyWithWrapped({Wrapped<String>? refresh}) {
    return TokenRefreshRequest(
      refresh: (refresh != null ? refresh.value : this.refresh),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserInfo {
  const UserInfo({this.id, required this.username, this.email});

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  static const toJsonFactory = _$UserInfoToJson;
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'email')
  final String? email;
  static const fromJsonFactory = _$UserInfoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserInfo &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality().equals(
                  other.username,
                  username,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(email) ^
      runtimeType.hashCode;
}

extension $UserInfoExtension on UserInfo {
  UserInfo copyWith({int? id, String? username, String? email}) {
    return UserInfo(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  UserInfo copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String>? username,
    Wrapped<String?>? email,
  }) {
    return UserInfo(
      id: (id != null ? id.value : this.id),
      username: (username != null ? username.value : this.username),
      email: (email != null ? email.value : this.email),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ApiRewardClaimPost$RequestBody {
  const ApiRewardClaimPost$RequestBody({
    required this.adId,
    required this.point,
  });

  factory ApiRewardClaimPost$RequestBody.fromJson(Map<String, dynamic> json) =>
      _$ApiRewardClaimPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$ApiRewardClaimPost$RequestBodyToJson;
  Map<String, dynamic> toJson() => _$ApiRewardClaimPost$RequestBodyToJson(this);

  @JsonKey(name: 'ad_id')
  final int adId;
  @JsonKey(name: 'point')
  final int point;
  static const fromJsonFactory = _$ApiRewardClaimPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ApiRewardClaimPost$RequestBody &&
            (identical(other.adId, adId) ||
                const DeepCollectionEquality().equals(other.adId, adId)) &&
            (identical(other.point, point) ||
                const DeepCollectionEquality().equals(other.point, point)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(adId) ^
      const DeepCollectionEquality().hash(point) ^
      runtimeType.hashCode;
}

extension $ApiRewardClaimPost$RequestBodyExtension
    on ApiRewardClaimPost$RequestBody {
  ApiRewardClaimPost$RequestBody copyWith({int? adId, int? point}) {
    return ApiRewardClaimPost$RequestBody(
      adId: adId ?? this.adId,
      point: point ?? this.point,
    );
  }

  ApiRewardClaimPost$RequestBody copyWithWrapped({
    Wrapped<int>? adId,
    Wrapped<int>? point,
  }) {
    return ApiRewardClaimPost$RequestBody(
      adId: (adId != null ? adId.value : this.adId),
      point: (point != null ? point.value : this.point),
    );
  }
}

String? adCampaignTargetGenderNullableToJson(
  enums.AdCampaignTargetGender? adCampaignTargetGender,
) {
  return adCampaignTargetGender?.value;
}

String? adCampaignTargetGenderToJson(
  enums.AdCampaignTargetGender adCampaignTargetGender,
) {
  return adCampaignTargetGender.value;
}

enums.AdCampaignTargetGender adCampaignTargetGenderFromJson(
  Object? adCampaignTargetGender, [
  enums.AdCampaignTargetGender? defaultValue,
]) {
  return enums.AdCampaignTargetGender.values.firstWhereOrNull(
        (e) => e.value == adCampaignTargetGender,
      ) ??
      defaultValue ??
      enums.AdCampaignTargetGender.swaggerGeneratedUnknown;
}

enums.AdCampaignTargetGender? adCampaignTargetGenderNullableFromJson(
  Object? adCampaignTargetGender, [
  enums.AdCampaignTargetGender? defaultValue,
]) {
  if (adCampaignTargetGender == null) {
    return null;
  }
  return enums.AdCampaignTargetGender.values.firstWhereOrNull(
        (e) => e.value == adCampaignTargetGender,
      ) ??
      defaultValue;
}

String adCampaignTargetGenderExplodedListToJson(
  List<enums.AdCampaignTargetGender>? adCampaignTargetGender,
) {
  return adCampaignTargetGender?.map((e) => e.value!).join(',') ?? '';
}

List<String> adCampaignTargetGenderListToJson(
  List<enums.AdCampaignTargetGender>? adCampaignTargetGender,
) {
  if (adCampaignTargetGender == null) {
    return [];
  }

  return adCampaignTargetGender.map((e) => e.value!).toList();
}

List<enums.AdCampaignTargetGender> adCampaignTargetGenderListFromJson(
  List? adCampaignTargetGender, [
  List<enums.AdCampaignTargetGender>? defaultValue,
]) {
  if (adCampaignTargetGender == null) {
    return defaultValue ?? [];
  }

  return adCampaignTargetGender
      .map((e) => adCampaignTargetGenderFromJson(e.toString()))
      .toList();
}

List<enums.AdCampaignTargetGender>? adCampaignTargetGenderNullableListFromJson(
  List? adCampaignTargetGender, [
  List<enums.AdCampaignTargetGender>? defaultValue,
]) {
  if (adCampaignTargetGender == null) {
    return defaultValue;
  }

  return adCampaignTargetGender
      .map((e) => adCampaignTargetGenderFromJson(e.toString()))
      .toList();
}

String? adCampaignRequestTargetGenderNullableToJson(
  enums.AdCampaignRequestTargetGender? adCampaignRequestTargetGender,
) {
  return adCampaignRequestTargetGender?.value;
}

String? adCampaignRequestTargetGenderToJson(
  enums.AdCampaignRequestTargetGender adCampaignRequestTargetGender,
) {
  return adCampaignRequestTargetGender.value;
}

enums.AdCampaignRequestTargetGender adCampaignRequestTargetGenderFromJson(
  Object? adCampaignRequestTargetGender, [
  enums.AdCampaignRequestTargetGender? defaultValue,
]) {
  return enums.AdCampaignRequestTargetGender.values.firstWhereOrNull(
        (e) => e.value == adCampaignRequestTargetGender,
      ) ??
      defaultValue ??
      enums.AdCampaignRequestTargetGender.swaggerGeneratedUnknown;
}

enums.AdCampaignRequestTargetGender?
adCampaignRequestTargetGenderNullableFromJson(
  Object? adCampaignRequestTargetGender, [
  enums.AdCampaignRequestTargetGender? defaultValue,
]) {
  if (adCampaignRequestTargetGender == null) {
    return null;
  }
  return enums.AdCampaignRequestTargetGender.values.firstWhereOrNull(
        (e) => e.value == adCampaignRequestTargetGender,
      ) ??
      defaultValue;
}

String adCampaignRequestTargetGenderExplodedListToJson(
  List<enums.AdCampaignRequestTargetGender>? adCampaignRequestTargetGender,
) {
  return adCampaignRequestTargetGender?.map((e) => e.value!).join(',') ?? '';
}

List<String> adCampaignRequestTargetGenderListToJson(
  List<enums.AdCampaignRequestTargetGender>? adCampaignRequestTargetGender,
) {
  if (adCampaignRequestTargetGender == null) {
    return [];
  }

  return adCampaignRequestTargetGender.map((e) => e.value!).toList();
}

List<enums.AdCampaignRequestTargetGender>
adCampaignRequestTargetGenderListFromJson(
  List? adCampaignRequestTargetGender, [
  List<enums.AdCampaignRequestTargetGender>? defaultValue,
]) {
  if (adCampaignRequestTargetGender == null) {
    return defaultValue ?? [];
  }

  return adCampaignRequestTargetGender
      .map((e) => adCampaignRequestTargetGenderFromJson(e.toString()))
      .toList();
}

List<enums.AdCampaignRequestTargetGender>?
adCampaignRequestTargetGenderNullableListFromJson(
  List? adCampaignRequestTargetGender, [
  List<enums.AdCampaignRequestTargetGender>? defaultValue,
]) {
  if (adCampaignRequestTargetGender == null) {
    return defaultValue;
  }

  return adCampaignRequestTargetGender
      .map((e) => adCampaignRequestTargetGenderFromJson(e.toString()))
      .toList();
}

String? blankEnumNullableToJson(enums.BlankEnum? blankEnum) {
  return blankEnum?.value;
}

String? blankEnumToJson(enums.BlankEnum blankEnum) {
  return blankEnum.value;
}

enums.BlankEnum blankEnumFromJson(
  Object? blankEnum, [
  enums.BlankEnum? defaultValue,
]) {
  return enums.BlankEnum.values.firstWhereOrNull((e) => e.value == blankEnum) ??
      defaultValue ??
      enums.BlankEnum.swaggerGeneratedUnknown;
}

enums.BlankEnum? blankEnumNullableFromJson(
  Object? blankEnum, [
  enums.BlankEnum? defaultValue,
]) {
  if (blankEnum == null) {
    return null;
  }
  return enums.BlankEnum.values.firstWhereOrNull((e) => e.value == blankEnum) ??
      defaultValue;
}

String blankEnumExplodedListToJson(List<enums.BlankEnum>? blankEnum) {
  return blankEnum?.map((e) => e.value!).join(',') ?? '';
}

List<String> blankEnumListToJson(List<enums.BlankEnum>? blankEnum) {
  if (blankEnum == null) {
    return [];
  }

  return blankEnum.map((e) => e.value!).toList();
}

List<enums.BlankEnum> blankEnumListFromJson(
  List? blankEnum, [
  List<enums.BlankEnum>? defaultValue,
]) {
  if (blankEnum == null) {
    return defaultValue ?? [];
  }

  return blankEnum.map((e) => blankEnumFromJson(e.toString())).toList();
}

List<enums.BlankEnum>? blankEnumNullableListFromJson(
  List? blankEnum, [
  List<enums.BlankEnum>? defaultValue,
]) {
  if (blankEnum == null) {
    return defaultValue;
  }

  return blankEnum.map((e) => blankEnumFromJson(e.toString())).toList();
}

String? eventTypeEnumNullableToJson(enums.EventTypeEnum? eventTypeEnum) {
  return eventTypeEnum?.value;
}

String? eventTypeEnumToJson(enums.EventTypeEnum eventTypeEnum) {
  return eventTypeEnum.value;
}

enums.EventTypeEnum eventTypeEnumFromJson(
  Object? eventTypeEnum, [
  enums.EventTypeEnum? defaultValue,
]) {
  return enums.EventTypeEnum.values.firstWhereOrNull(
        (e) => e.value == eventTypeEnum,
      ) ??
      defaultValue ??
      enums.EventTypeEnum.swaggerGeneratedUnknown;
}

enums.EventTypeEnum? eventTypeEnumNullableFromJson(
  Object? eventTypeEnum, [
  enums.EventTypeEnum? defaultValue,
]) {
  if (eventTypeEnum == null) {
    return null;
  }
  return enums.EventTypeEnum.values.firstWhereOrNull(
        (e) => e.value == eventTypeEnum,
      ) ??
      defaultValue;
}

String eventTypeEnumExplodedListToJson(
  List<enums.EventTypeEnum>? eventTypeEnum,
) {
  return eventTypeEnum?.map((e) => e.value!).join(',') ?? '';
}

List<String> eventTypeEnumListToJson(List<enums.EventTypeEnum>? eventTypeEnum) {
  if (eventTypeEnum == null) {
    return [];
  }

  return eventTypeEnum.map((e) => e.value!).toList();
}

List<enums.EventTypeEnum> eventTypeEnumListFromJson(
  List? eventTypeEnum, [
  List<enums.EventTypeEnum>? defaultValue,
]) {
  if (eventTypeEnum == null) {
    return defaultValue ?? [];
  }

  return eventTypeEnum.map((e) => eventTypeEnumFromJson(e.toString())).toList();
}

List<enums.EventTypeEnum>? eventTypeEnumNullableListFromJson(
  List? eventTypeEnum, [
  List<enums.EventTypeEnum>? defaultValue,
]) {
  if (eventTypeEnum == null) {
    return defaultValue;
  }

  return eventTypeEnum.map((e) => eventTypeEnumFromJson(e.toString())).toList();
}

String? patchedAdCampaignRequestTargetGenderNullableToJson(
  enums.PatchedAdCampaignRequestTargetGender?
  patchedAdCampaignRequestTargetGender,
) {
  return patchedAdCampaignRequestTargetGender?.value;
}

String? patchedAdCampaignRequestTargetGenderToJson(
  enums.PatchedAdCampaignRequestTargetGender
  patchedAdCampaignRequestTargetGender,
) {
  return patchedAdCampaignRequestTargetGender.value;
}

enums.PatchedAdCampaignRequestTargetGender
patchedAdCampaignRequestTargetGenderFromJson(
  Object? patchedAdCampaignRequestTargetGender, [
  enums.PatchedAdCampaignRequestTargetGender? defaultValue,
]) {
  return enums.PatchedAdCampaignRequestTargetGender.values.firstWhereOrNull(
        (e) => e.value == patchedAdCampaignRequestTargetGender,
      ) ??
      defaultValue ??
      enums.PatchedAdCampaignRequestTargetGender.swaggerGeneratedUnknown;
}

enums.PatchedAdCampaignRequestTargetGender?
patchedAdCampaignRequestTargetGenderNullableFromJson(
  Object? patchedAdCampaignRequestTargetGender, [
  enums.PatchedAdCampaignRequestTargetGender? defaultValue,
]) {
  if (patchedAdCampaignRequestTargetGender == null) {
    return null;
  }
  return enums.PatchedAdCampaignRequestTargetGender.values.firstWhereOrNull(
        (e) => e.value == patchedAdCampaignRequestTargetGender,
      ) ??
      defaultValue;
}

String patchedAdCampaignRequestTargetGenderExplodedListToJson(
  List<enums.PatchedAdCampaignRequestTargetGender>?
  patchedAdCampaignRequestTargetGender,
) {
  return patchedAdCampaignRequestTargetGender?.map((e) => e.value!).join(',') ??
      '';
}

List<String> patchedAdCampaignRequestTargetGenderListToJson(
  List<enums.PatchedAdCampaignRequestTargetGender>?
  patchedAdCampaignRequestTargetGender,
) {
  if (patchedAdCampaignRequestTargetGender == null) {
    return [];
  }

  return patchedAdCampaignRequestTargetGender.map((e) => e.value!).toList();
}

List<enums.PatchedAdCampaignRequestTargetGender>
patchedAdCampaignRequestTargetGenderListFromJson(
  List? patchedAdCampaignRequestTargetGender, [
  List<enums.PatchedAdCampaignRequestTargetGender>? defaultValue,
]) {
  if (patchedAdCampaignRequestTargetGender == null) {
    return defaultValue ?? [];
  }

  return patchedAdCampaignRequestTargetGender
      .map((e) => patchedAdCampaignRequestTargetGenderFromJson(e.toString()))
      .toList();
}

List<enums.PatchedAdCampaignRequestTargetGender>?
patchedAdCampaignRequestTargetGenderNullableListFromJson(
  List? patchedAdCampaignRequestTargetGender, [
  List<enums.PatchedAdCampaignRequestTargetGender>? defaultValue,
]) {
  if (patchedAdCampaignRequestTargetGender == null) {
    return defaultValue;
  }

  return patchedAdCampaignRequestTargetGender
      .map((e) => patchedAdCampaignRequestTargetGenderFromJson(e.toString()))
      .toList();
}

String? statusEnumNullableToJson(enums.StatusEnum? statusEnum) {
  return statusEnum?.value;
}

String? statusEnumToJson(enums.StatusEnum statusEnum) {
  return statusEnum.value;
}

enums.StatusEnum statusEnumFromJson(
  Object? statusEnum, [
  enums.StatusEnum? defaultValue,
]) {
  return enums.StatusEnum.values.firstWhereOrNull(
        (e) => e.value == statusEnum,
      ) ??
      defaultValue ??
      enums.StatusEnum.swaggerGeneratedUnknown;
}

enums.StatusEnum? statusEnumNullableFromJson(
  Object? statusEnum, [
  enums.StatusEnum? defaultValue,
]) {
  if (statusEnum == null) {
    return null;
  }
  return enums.StatusEnum.values.firstWhereOrNull(
        (e) => e.value == statusEnum,
      ) ??
      defaultValue;
}

String statusEnumExplodedListToJson(List<enums.StatusEnum>? statusEnum) {
  return statusEnum?.map((e) => e.value!).join(',') ?? '';
}

List<String> statusEnumListToJson(List<enums.StatusEnum>? statusEnum) {
  if (statusEnum == null) {
    return [];
  }

  return statusEnum.map((e) => e.value!).toList();
}

List<enums.StatusEnum> statusEnumListFromJson(
  List? statusEnum, [
  List<enums.StatusEnum>? defaultValue,
]) {
  if (statusEnum == null) {
    return defaultValue ?? [];
  }

  return statusEnum.map((e) => statusEnumFromJson(e.toString())).toList();
}

List<enums.StatusEnum>? statusEnumNullableListFromJson(
  List? statusEnum, [
  List<enums.StatusEnum>? defaultValue,
]) {
  if (statusEnum == null) {
    return defaultValue;
  }

  return statusEnum.map((e) => statusEnumFromJson(e.toString())).toList();
}

String? targetGenderEnumNullableToJson(
  enums.TargetGenderEnum? targetGenderEnum,
) {
  return targetGenderEnum?.value;
}

String? targetGenderEnumToJson(enums.TargetGenderEnum targetGenderEnum) {
  return targetGenderEnum.value;
}

enums.TargetGenderEnum targetGenderEnumFromJson(
  Object? targetGenderEnum, [
  enums.TargetGenderEnum? defaultValue,
]) {
  return enums.TargetGenderEnum.values.firstWhereOrNull(
        (e) => e.value == targetGenderEnum,
      ) ??
      defaultValue ??
      enums.TargetGenderEnum.swaggerGeneratedUnknown;
}

enums.TargetGenderEnum? targetGenderEnumNullableFromJson(
  Object? targetGenderEnum, [
  enums.TargetGenderEnum? defaultValue,
]) {
  if (targetGenderEnum == null) {
    return null;
  }
  return enums.TargetGenderEnum.values.firstWhereOrNull(
        (e) => e.value == targetGenderEnum,
      ) ??
      defaultValue;
}

String targetGenderEnumExplodedListToJson(
  List<enums.TargetGenderEnum>? targetGenderEnum,
) {
  return targetGenderEnum?.map((e) => e.value!).join(',') ?? '';
}

List<String> targetGenderEnumListToJson(
  List<enums.TargetGenderEnum>? targetGenderEnum,
) {
  if (targetGenderEnum == null) {
    return [];
  }

  return targetGenderEnum.map((e) => e.value!).toList();
}

List<enums.TargetGenderEnum> targetGenderEnumListFromJson(
  List? targetGenderEnum, [
  List<enums.TargetGenderEnum>? defaultValue,
]) {
  if (targetGenderEnum == null) {
    return defaultValue ?? [];
  }

  return targetGenderEnum
      .map((e) => targetGenderEnumFromJson(e.toString()))
      .toList();
}

List<enums.TargetGenderEnum>? targetGenderEnumNullableListFromJson(
  List? targetGenderEnum, [
  List<enums.TargetGenderEnum>? defaultValue,
]) {
  if (targetGenderEnum == null) {
    return defaultValue;
  }

  return targetGenderEnum
      .map((e) => targetGenderEnumFromJson(e.toString()))
      .toList();
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
    chopper.Response response,
  ) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
        body:
            DateTime.parse((response.body as String).replaceAll('"', ''))
                as ResultType,
      );
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
      body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType,
    );
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
