// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ad_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AdModel _$AdModelFromJson(Map<String, dynamic> json) {
  return _AdModel.fromJson(json);
}

/// @nodoc
mixin _$AdModel {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError; // 광고 제목
  // API 응답에서 'advertiser' 객체 내에 'brand_name'이 있다면 아래와 같이 사용 가능
  // @JsonKey(name: 'advertiser.brand_name', defaultValue: '알 수 없는 브랜드') String brandName,
  // 또는 광고주 ID만 받고, 브랜드명은 다른 곳에서 가져온다면 일반 필드로 선언
  String get brandName =>
      throw _privateConstructorUsedError; // 브랜드명 (실제 API 응답 구조에 따라 @JsonKey 수정 필요)
  String? get thumbnailUrl => throw _privateConstructorUsedError; // 썸네일 이미지 URL
  int get likesCount => throw _privateConstructorUsedError; // 좋아요 수
  String? get videoUrl => throw _privateConstructorUsedError; // 비디오 URL
  String? get description => throw _privateConstructorUsedError; // 광고 설명
  // API 명세의 'advertiser' 필드 (광고주 ID)
  int? get advertiser => throw _privateConstructorUsedError;
  String? get landingUrl => throw _privateConstructorUsedError; // 랜딩 URL
  String? get adType => throw _privateConstructorUsedError; // 광고 유형
  int? get targetMinAge => throw _privateConstructorUsedError; // 타겟 최소 연령
  int? get targetMaxAge => throw _privateConstructorUsedError; // 타겟 최대 연령
  String? get targetGender => throw _privateConstructorUsedError; // 타겟 성별
  DateTime? get startDate => throw _privateConstructorUsedError; // 노출 시작일
  DateTime? get endDate => throw _privateConstructorUsedError;

  /// Serializes this AdModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdModelCopyWith<AdModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdModelCopyWith<$Res> {
  factory $AdModelCopyWith(AdModel value, $Res Function(AdModel) then) =
      _$AdModelCopyWithImpl<$Res, AdModel>;
  @useResult
  $Res call({
    int id,
    String title,
    String brandName,
    String? thumbnailUrl,
    int likesCount,
    String? videoUrl,
    String? description,
    int? advertiser,
    String? landingUrl,
    String? adType,
    int? targetMinAge,
    int? targetMaxAge,
    String? targetGender,
    DateTime? startDate,
    DateTime? endDate,
  });
}

/// @nodoc
class _$AdModelCopyWithImpl<$Res, $Val extends AdModel>
    implements $AdModelCopyWith<$Res> {
  _$AdModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? brandName = null,
    Object? thumbnailUrl = freezed,
    Object? likesCount = null,
    Object? videoUrl = freezed,
    Object? description = freezed,
    Object? advertiser = freezed,
    Object? landingUrl = freezed,
    Object? adType = freezed,
    Object? targetMinAge = freezed,
    Object? targetMaxAge = freezed,
    Object? targetGender = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            brandName: null == brandName
                ? _value.brandName
                : brandName // ignore: cast_nullable_to_non_nullable
                      as String,
            thumbnailUrl: freezed == thumbnailUrl
                ? _value.thumbnailUrl
                : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            likesCount: null == likesCount
                ? _value.likesCount
                : likesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            videoUrl: freezed == videoUrl
                ? _value.videoUrl
                : videoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            advertiser: freezed == advertiser
                ? _value.advertiser
                : advertiser // ignore: cast_nullable_to_non_nullable
                      as int?,
            landingUrl: freezed == landingUrl
                ? _value.landingUrl
                : landingUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            adType: freezed == adType
                ? _value.adType
                : adType // ignore: cast_nullable_to_non_nullable
                      as String?,
            targetMinAge: freezed == targetMinAge
                ? _value.targetMinAge
                : targetMinAge // ignore: cast_nullable_to_non_nullable
                      as int?,
            targetMaxAge: freezed == targetMaxAge
                ? _value.targetMaxAge
                : targetMaxAge // ignore: cast_nullable_to_non_nullable
                      as int?,
            targetGender: freezed == targetGender
                ? _value.targetGender
                : targetGender // ignore: cast_nullable_to_non_nullable
                      as String?,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AdModelImplCopyWith<$Res> implements $AdModelCopyWith<$Res> {
  factory _$$AdModelImplCopyWith(
    _$AdModelImpl value,
    $Res Function(_$AdModelImpl) then,
  ) = __$$AdModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String title,
    String brandName,
    String? thumbnailUrl,
    int likesCount,
    String? videoUrl,
    String? description,
    int? advertiser,
    String? landingUrl,
    String? adType,
    int? targetMinAge,
    int? targetMaxAge,
    String? targetGender,
    DateTime? startDate,
    DateTime? endDate,
  });
}

/// @nodoc
class __$$AdModelImplCopyWithImpl<$Res>
    extends _$AdModelCopyWithImpl<$Res, _$AdModelImpl>
    implements _$$AdModelImplCopyWith<$Res> {
  __$$AdModelImplCopyWithImpl(
    _$AdModelImpl _value,
    $Res Function(_$AdModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? brandName = null,
    Object? thumbnailUrl = freezed,
    Object? likesCount = null,
    Object? videoUrl = freezed,
    Object? description = freezed,
    Object? advertiser = freezed,
    Object? landingUrl = freezed,
    Object? adType = freezed,
    Object? targetMinAge = freezed,
    Object? targetMaxAge = freezed,
    Object? targetGender = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
  }) {
    return _then(
      _$AdModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        brandName: null == brandName
            ? _value.brandName
            : brandName // ignore: cast_nullable_to_non_nullable
                  as String,
        thumbnailUrl: freezed == thumbnailUrl
            ? _value.thumbnailUrl
            : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        likesCount: null == likesCount
            ? _value.likesCount
            : likesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        videoUrl: freezed == videoUrl
            ? _value.videoUrl
            : videoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        advertiser: freezed == advertiser
            ? _value.advertiser
            : advertiser // ignore: cast_nullable_to_non_nullable
                  as int?,
        landingUrl: freezed == landingUrl
            ? _value.landingUrl
            : landingUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        adType: freezed == adType
            ? _value.adType
            : adType // ignore: cast_nullable_to_non_nullable
                  as String?,
        targetMinAge: freezed == targetMinAge
            ? _value.targetMinAge
            : targetMinAge // ignore: cast_nullable_to_non_nullable
                  as int?,
        targetMaxAge: freezed == targetMaxAge
            ? _value.targetMaxAge
            : targetMaxAge // ignore: cast_nullable_to_non_nullable
                  as int?,
        targetGender: freezed == targetGender
            ? _value.targetGender
            : targetGender // ignore: cast_nullable_to_non_nullable
                  as String?,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AdModelImpl implements _AdModel {
  const _$AdModelImpl({
    required this.id,
    required this.title,
    this.brandName = '정보 없음',
    this.thumbnailUrl,
    this.likesCount = 0,
    this.videoUrl,
    this.description,
    this.advertiser,
    this.landingUrl,
    this.adType,
    this.targetMinAge,
    this.targetMaxAge,
    this.targetGender,
    this.startDate,
    this.endDate,
  });

  factory _$AdModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdModelImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  // 광고 제목
  // API 응답에서 'advertiser' 객체 내에 'brand_name'이 있다면 아래와 같이 사용 가능
  // @JsonKey(name: 'advertiser.brand_name', defaultValue: '알 수 없는 브랜드') String brandName,
  // 또는 광고주 ID만 받고, 브랜드명은 다른 곳에서 가져온다면 일반 필드로 선언
  @override
  @JsonKey()
  final String brandName;
  // 브랜드명 (실제 API 응답 구조에 따라 @JsonKey 수정 필요)
  @override
  final String? thumbnailUrl;
  // 썸네일 이미지 URL
  @override
  @JsonKey()
  final int likesCount;
  // 좋아요 수
  @override
  final String? videoUrl;
  // 비디오 URL
  @override
  final String? description;
  // 광고 설명
  // API 명세의 'advertiser' 필드 (광고주 ID)
  @override
  final int? advertiser;
  @override
  final String? landingUrl;
  // 랜딩 URL
  @override
  final String? adType;
  // 광고 유형
  @override
  final int? targetMinAge;
  // 타겟 최소 연령
  @override
  final int? targetMaxAge;
  // 타겟 최대 연령
  @override
  final String? targetGender;
  // 타겟 성별
  @override
  final DateTime? startDate;
  // 노출 시작일
  @override
  final DateTime? endDate;

  @override
  String toString() {
    return 'AdModel(id: $id, title: $title, brandName: $brandName, thumbnailUrl: $thumbnailUrl, likesCount: $likesCount, videoUrl: $videoUrl, description: $description, advertiser: $advertiser, landingUrl: $landingUrl, adType: $adType, targetMinAge: $targetMinAge, targetMaxAge: $targetMaxAge, targetGender: $targetGender, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.advertiser, advertiser) ||
                other.advertiser == advertiser) &&
            (identical(other.landingUrl, landingUrl) ||
                other.landingUrl == landingUrl) &&
            (identical(other.adType, adType) || other.adType == adType) &&
            (identical(other.targetMinAge, targetMinAge) ||
                other.targetMinAge == targetMinAge) &&
            (identical(other.targetMaxAge, targetMaxAge) ||
                other.targetMaxAge == targetMaxAge) &&
            (identical(other.targetGender, targetGender) ||
                other.targetGender == targetGender) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    brandName,
    thumbnailUrl,
    likesCount,
    videoUrl,
    description,
    advertiser,
    landingUrl,
    adType,
    targetMinAge,
    targetMaxAge,
    targetGender,
    startDate,
    endDate,
  );

  /// Create a copy of AdModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdModelImplCopyWith<_$AdModelImpl> get copyWith =>
      __$$AdModelImplCopyWithImpl<_$AdModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdModelImplToJson(this);
  }
}

abstract class _AdModel implements AdModel {
  const factory _AdModel({
    required final int id,
    required final String title,
    final String brandName,
    final String? thumbnailUrl,
    final int likesCount,
    final String? videoUrl,
    final String? description,
    final int? advertiser,
    final String? landingUrl,
    final String? adType,
    final int? targetMinAge,
    final int? targetMaxAge,
    final String? targetGender,
    final DateTime? startDate,
    final DateTime? endDate,
  }) = _$AdModelImpl;

  factory _AdModel.fromJson(Map<String, dynamic> json) = _$AdModelImpl.fromJson;

  @override
  int get id;
  @override
  String get title; // 광고 제목
  // API 응답에서 'advertiser' 객체 내에 'brand_name'이 있다면 아래와 같이 사용 가능
  // @JsonKey(name: 'advertiser.brand_name', defaultValue: '알 수 없는 브랜드') String brandName,
  // 또는 광고주 ID만 받고, 브랜드명은 다른 곳에서 가져온다면 일반 필드로 선언
  @override
  String get brandName; // 브랜드명 (실제 API 응답 구조에 따라 @JsonKey 수정 필요)
  @override
  String? get thumbnailUrl; // 썸네일 이미지 URL
  @override
  int get likesCount; // 좋아요 수
  @override
  String? get videoUrl; // 비디오 URL
  @override
  String? get description; // 광고 설명
  // API 명세의 'advertiser' 필드 (광고주 ID)
  @override
  int? get advertiser;
  @override
  String? get landingUrl; // 랜딩 URL
  @override
  String? get adType; // 광고 유형
  @override
  int? get targetMinAge; // 타겟 최소 연령
  @override
  int? get targetMaxAge; // 타겟 최대 연령
  @override
  String? get targetGender; // 타겟 성별
  @override
  DateTime? get startDate; // 노출 시작일
  @override
  DateTime? get endDate;

  /// Create a copy of AdModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdModelImplCopyWith<_$AdModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
