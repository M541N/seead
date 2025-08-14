// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SeeAD_API.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$SeeADAPI extends SeeADAPI {
  _$SeeADAPI([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = SeeADAPI;

  @override
  Future<Response<Ad>> _apiAdIdGet({required int? id}) {
    final Uri $url = Uri.parse('/api/ad/${id}/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Ad, Ad>($request);
  }

  @override
  Future<Response<ToggleLikeResponse>> _apiAdIdLikePost({
    required int? id,
    required AdRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/ad/${id}/like/');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<ToggleLikeResponse, ToggleLikeResponse>($request);
  }

  @override
  Future<Response<LikeCountResponse>> _apiAdIdLikesGet({required int? id}) {
    final Uri $url = Uri.parse('/api/ad/${id}/likes/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<LikeCountResponse, LikeCountResponse>($request);
  }

  @override
  Future<Response<AdCostSummaryResponse>> _apiAdCostSummaryGet() {
    final Uri $url = Uri.parse('/api/ad/cost-summary/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<AdCostSummaryResponse, AdCostSummaryResponse>($request);
  }

  @override
  Future<Response<EventRecordResponse>> _apiAdEventPost({
    required AdMetricEventRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/ad/event/');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<EventRecordResponse, EventRecordResponse>($request);
  }

  @override
  Future<Response<SuccessMessageResponse>> _apiAdExposePost({
    required AdExposeRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/ad/expose/');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<SuccessMessageResponse, SuccessMessageResponse>(
      $request,
    );
  }

  @override
  Future<Response<List<Ad>>> _apiAdListGet() {
    final Uri $url = Uri.parse('/api/ad/list/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<Ad>, Ad>($request);
  }

  @override
  Future<Response<List<AdRecommend>>> _apiAdRecommendGet() {
    final Uri $url = Uri.parse('/api/ad/recommend/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<AdRecommend>, AdRecommend>($request);
  }

  @override
  Future<Response<AdPerformanceSummaryResponse>> _apiAdSummaryGet() {
    final Uri $url = Uri.parse('/api/ad/summary/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client
        .send<AdPerformanceSummaryResponse, AdPerformanceSummaryResponse>(
          $request,
        );
  }

  @override
  Future<Response<List<AdLikeCount>>> _apiAdTopLikedGet() {
    final Uri $url = Uri.parse('/api/ad/top-liked/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<AdLikeCount>, AdLikeCount>($request);
  }

  @override
  Future<Response<AdUploadResponse>> _apiAdUploadPost({
    required AdUploadRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/ad/upload/');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<AdUploadResponse, AdUploadResponse>($request);
  }

  @override
  Future<Response<AdvertiserDetail>> _apiAdvertiserMeGet() {
    final Uri $url = Uri.parse('/api/advertiser/me/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<AdvertiserDetail, AdvertiserDetail>($request);
  }

  @override
  Future<Response<AdvertiserDetail>> _apiAdvertiserMeUpdatePut({
    required AdvertiserUpdateRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/advertiser/me/update/');
    final $body = body;
    final Request $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<AdvertiserDetail, AdvertiserDetail>($request);
  }

  @override
  Future<Response<LoginResponse>> _apiAuthLoginPost({
    required LoginRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/auth/login/');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<LoginResponse, LoginResponse>($request);
  }

  @override
  Future<Response<LogoutResponse>> _apiAuthLogoutPost({
    required LogoutRequestRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/auth/logout/');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<LogoutResponse, LogoutResponse>($request);
  }

  @override
  Future<Response<UserInfo>> _apiAuthMeGet() {
    final Uri $url = Uri.parse('/api/auth/me/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<UserInfo, UserInfo>($request);
  }

  @override
  Future<Response<SignupResponse>> _apiAuthSignupPost({
    required SignupRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/auth/signup/');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<SignupResponse, SignupResponse>($request);
  }

  @override
  Future<Response<TokenRefresh>> _apiAuthTokenRefreshPost({
    required TokenRefreshRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/auth/token/refresh/');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<TokenRefresh, TokenRefresh>($request);
  }

  @override
  Future<Response<List<AdCampaign>>> _apiCampaignGet() {
    final Uri $url = Uri.parse('/api/campaign/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<AdCampaign>, AdCampaign>($request);
  }

  @override
  Future<Response<AdCampaign>> _apiCampaignIdGet({required int? id}) {
    final Uri $url = Uri.parse('/api/campaign/${id}/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<AdCampaign, AdCampaign>($request);
  }

  @override
  Future<Response<dynamic>> _apiCampaignIdChargeBudgetPost({
    required int? id,
    required CampaignBudgetChargeRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/campaign/${id}/charge-budget/');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AdCampaign>> _apiCampaignIdEditGet({required int? id}) {
    final Uri $url = Uri.parse('/api/campaign/${id}/edit/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<AdCampaign, AdCampaign>($request);
  }

  @override
  Future<Response<AdCampaign>> _apiCampaignIdEditPut({
    required int? id,
    required AdCampaignRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/campaign/${id}/edit/');
    final $body = body;
    final Request $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<AdCampaign, AdCampaign>($request);
  }

  @override
  Future<Response<AdCampaign>> _apiCampaignIdEditPatch({
    required int? id,
    required PatchedAdCampaignRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/campaign/${id}/edit/');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AdCampaign, AdCampaign>($request);
  }

  @override
  Future<Response<dynamic>> _apiCampaignIdEditDelete({required int? id}) {
    final Uri $url = Uri.parse('/api/campaign/${id}/edit/');
    final Request $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiCampaignIdExtendDurationPost({
    required int? id,
    required CampaignDurationExtendRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/campaign/${id}/extend-duration/');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiCampaignIdLogsGet({required int? id}) {
    final Uri $url = Uri.parse('/api/campaign/${id}/logs/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AdCampaign>> _apiCampaignCreatePost({
    required AdCampaignRequest? body,
  }) {
    final Uri $url = Uri.parse('/api/campaign/create/');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<AdCampaign, AdCampaign>($request);
  }

  @override
  Future<Response<dynamic>> _apiNotificationsGet() {
    final Uri $url = Uri.parse('/api/notifications/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiProfileFcmUpdatePost({
    required String? fcmToken,
  }) {
    final Uri $url = Uri.parse('/api/profile/fcm/update/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'fcm_token': fcmToken,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiRewardClaimPost({
    required ApiRewardClaimPost$RequestBody? body,
  }) {
    final Uri $url = Uri.parse('/api/reward/claim/');
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<RewardHistory>>> _apiRewardHistoryGet() {
    final Uri $url = Uri.parse('/api/reward/history/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<RewardHistory>, RewardHistory>($request);
  }

  @override
  Future<Response<RewardStatus>> _apiRewardStatusGet() {
    final Uri $url = Uri.parse('/api/reward/status/');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<RewardStatus, RewardStatus>($request);
  }
}
