// lib/features/ad/domain/ad_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad_model.freezed.dart';
part 'ad_model.g.dart';

/// 광고 정보를 나타내는 데이터 모델
///
/// API 명세의 AdList 스키마를 기반으로 합니다.
@freezed
class AdModel with _$AdModel {
  const factory AdModel({
    required int id,
    required String title, // 광고 제목
    // API 응답에서 'advertiser' 객체 내에 'brand_name'이 있다면 아래와 같이 사용 가능
    // @JsonKey(name: 'advertiser.brand_name', defaultValue: '알 수 없는 브랜드') String brandName,
    // 또는 광고주 ID만 받고, 브랜드명은 다른 곳에서 가져온다면 일반 필드로 선언
    @Default('정보 없음') String brandName, // 브랜드명 (실제 API 응답 구조에 따라 @JsonKey 수정 필요)
    @JsonKey(name: 'thumbnail') String? thumbnailUrl, // 썸네일 이미지 URL
    @Default(0) // Freezed를 위한 @Default 어노테이션 추가
    @JsonKey(name: 'total_likes', defaultValue: 0) int likesCount, // 좋아요 수
    @JsonKey(name: 'video_url') String? videoUrl, // 비디오 URL
    String? description, // 광고 설명
    // API 명세의 'advertiser' 필드 (광고주 ID)
    int? advertiser,
    // 필요한 경우 추가 필드 (예: status, created_at, is_liked_by_user 등)
    // final DateTime? createdAt,
    // final String? status,
    // @JsonKey(name: 'is_liked') bool? isLikedByUser,
  }) = _AdModel;

  /// JSON으로부터 AdModel 객체를 생성합니다.
  factory AdModel.fromJson(Map<String, dynamic> json) =>
      _$AdModelFromJson(json);
}
