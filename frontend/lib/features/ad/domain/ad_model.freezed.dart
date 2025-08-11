// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ad_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdModel {

 int get id; String get title;// 광고 제목
// API 응답에서 'advertiser' 객체 내에 'brand_name'이 있다면 아래와 같이 사용 가능
// @JsonKey(name: 'advertiser.brand_name', defaultValue: '알 수 없는 브랜드') String brandName,
// 또는 광고주 ID만 받고, 브랜드명은 다른 곳에서 가져온다면 일반 필드로 선언
 String get brandName;// 브랜드명 (실제 API 응답 구조에 따라 @JsonKey 수정 필요)
@JsonKey(name: 'thumbnail') String? get thumbnailUrl;// 썸네일 이미지 URL
@JsonKey(name: 'total_likes', defaultValue: 0) int get likesCount;// 좋아요 수
@JsonKey(name: 'video_url') String? get videoUrl;// 비디오 URL
 String? get description;// 광고 설명
// API 명세의 'advertiser' 필드 (광고주 ID)
 int? get advertiser;
/// Create a copy of AdModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdModelCopyWith<AdModel> get copyWith => _$AdModelCopyWithImpl<AdModel>(this as AdModel, _$identity);

  /// Serializes this AdModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.advertiser, advertiser) || other.advertiser == advertiser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,brandName,thumbnailUrl,likesCount,videoUrl,description,advertiser);

@override
String toString() {
  return 'AdModel(id: $id, title: $title, brandName: $brandName, thumbnailUrl: $thumbnailUrl, likesCount: $likesCount, videoUrl: $videoUrl, description: $description, advertiser: $advertiser)';
}


}

/// @nodoc
abstract mixin class $AdModelCopyWith<$Res>  {
  factory $AdModelCopyWith(AdModel value, $Res Function(AdModel) _then) = _$AdModelCopyWithImpl;
@useResult
$Res call({
 int id, String title, String brandName,@JsonKey(name: 'thumbnail') String? thumbnailUrl,@JsonKey(name: 'total_likes', defaultValue: 0) int likesCount,@JsonKey(name: 'video_url') String? videoUrl, String? description, int? advertiser
});




}
/// @nodoc
class _$AdModelCopyWithImpl<$Res>
    implements $AdModelCopyWith<$Res> {
  _$AdModelCopyWithImpl(this._self, this._then);

  final AdModel _self;
  final $Res Function(AdModel) _then;

/// Create a copy of AdModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? brandName = null,Object? thumbnailUrl = freezed,Object? likesCount = null,Object? videoUrl = freezed,Object? description = freezed,Object? advertiser = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,advertiser: freezed == advertiser ? _self.advertiser : advertiser // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AdModel].
extension AdModelPatterns on AdModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdModel value)  $default,){
final _that = this;
switch (_that) {
case _AdModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdModel value)?  $default,){
final _that = this;
switch (_that) {
case _AdModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String brandName, @JsonKey(name: 'thumbnail')  String? thumbnailUrl, @JsonKey(name: 'total_likes', defaultValue: 0)  int likesCount, @JsonKey(name: 'video_url')  String? videoUrl,  String? description,  int? advertiser)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdModel() when $default != null:
return $default(_that.id,_that.title,_that.brandName,_that.thumbnailUrl,_that.likesCount,_that.videoUrl,_that.description,_that.advertiser);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String brandName, @JsonKey(name: 'thumbnail')  String? thumbnailUrl, @JsonKey(name: 'total_likes', defaultValue: 0)  int likesCount, @JsonKey(name: 'video_url')  String? videoUrl,  String? description,  int? advertiser)  $default,) {final _that = this;
switch (_that) {
case _AdModel():
return $default(_that.id,_that.title,_that.brandName,_that.thumbnailUrl,_that.likesCount,_that.videoUrl,_that.description,_that.advertiser);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String brandName, @JsonKey(name: 'thumbnail')  String? thumbnailUrl, @JsonKey(name: 'total_likes', defaultValue: 0)  int likesCount, @JsonKey(name: 'video_url')  String? videoUrl,  String? description,  int? advertiser)?  $default,) {final _that = this;
switch (_that) {
case _AdModel() when $default != null:
return $default(_that.id,_that.title,_that.brandName,_that.thumbnailUrl,_that.likesCount,_that.videoUrl,_that.description,_that.advertiser);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdModel implements AdModel {
  const _AdModel({required this.id, required this.title, this.brandName = '정보 없음', @JsonKey(name: 'thumbnail') this.thumbnailUrl, @JsonKey(name: 'total_likes', defaultValue: 0) this.likesCount = 0, @JsonKey(name: 'video_url') this.videoUrl, this.description, this.advertiser});
  factory _AdModel.fromJson(Map<String, dynamic> json) => _$AdModelFromJson(json);

@override final  int id;
@override final  String title;
// 광고 제목
// API 응답에서 'advertiser' 객체 내에 'brand_name'이 있다면 아래와 같이 사용 가능
// @JsonKey(name: 'advertiser.brand_name', defaultValue: '알 수 없는 브랜드') String brandName,
// 또는 광고주 ID만 받고, 브랜드명은 다른 곳에서 가져온다면 일반 필드로 선언
@override@JsonKey() final  String brandName;
// 브랜드명 (실제 API 응답 구조에 따라 @JsonKey 수정 필요)
@override@JsonKey(name: 'thumbnail') final  String? thumbnailUrl;
// 썸네일 이미지 URL
@override@JsonKey(name: 'total_likes', defaultValue: 0) final  int likesCount;
// 좋아요 수
@override@JsonKey(name: 'video_url') final  String? videoUrl;
// 비디오 URL
@override final  String? description;
// 광고 설명
// API 명세의 'advertiser' 필드 (광고주 ID)
@override final  int? advertiser;

/// Create a copy of AdModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdModelCopyWith<_AdModel> get copyWith => __$AdModelCopyWithImpl<_AdModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.advertiser, advertiser) || other.advertiser == advertiser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,brandName,thumbnailUrl,likesCount,videoUrl,description,advertiser);

@override
String toString() {
  return 'AdModel(id: $id, title: $title, brandName: $brandName, thumbnailUrl: $thumbnailUrl, likesCount: $likesCount, videoUrl: $videoUrl, description: $description, advertiser: $advertiser)';
}


}

/// @nodoc
abstract mixin class _$AdModelCopyWith<$Res> implements $AdModelCopyWith<$Res> {
  factory _$AdModelCopyWith(_AdModel value, $Res Function(_AdModel) _then) = __$AdModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String brandName,@JsonKey(name: 'thumbnail') String? thumbnailUrl,@JsonKey(name: 'total_likes', defaultValue: 0) int likesCount,@JsonKey(name: 'video_url') String? videoUrl, String? description, int? advertiser
});




}
/// @nodoc
class __$AdModelCopyWithImpl<$Res>
    implements _$AdModelCopyWith<$Res> {
  __$AdModelCopyWithImpl(this._self, this._then);

  final _AdModel _self;
  final $Res Function(_AdModel) _then;

/// Create a copy of AdModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? brandName = null,Object? thumbnailUrl = freezed,Object? likesCount = null,Object? videoUrl = freezed,Object? description = freezed,Object? advertiser = freezed,}) {
  return _then(_AdModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,advertiser: freezed == advertiser ? _self.advertiser : advertiser // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
