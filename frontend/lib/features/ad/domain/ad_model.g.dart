// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdModel _$AdModelFromJson(Map<String, dynamic> json) => _AdModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  brandName: json['brandName'] as String? ?? '정보 없음',
  thumbnailUrl: json['thumbnail'] as String?,
  likesCount: (json['total_likes'] as num?)?.toInt() ?? 0,
  videoUrl: json['video_url'] as String?,
  description: json['description'] as String?,
  advertiser: (json['advertiser'] as num?)?.toInt(),
);

Map<String, dynamic> _$AdModelToJson(_AdModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'brandName': instance.brandName,
  'thumbnail': instance.thumbnailUrl,
  'total_likes': instance.likesCount,
  'video_url': instance.videoUrl,
  'description': instance.description,
  'advertiser': instance.advertiser,
};
