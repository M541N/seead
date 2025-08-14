// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdModelImpl _$$AdModelImplFromJson(Map<String, dynamic> json) =>
    _$AdModelImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      brandName: json['brandName'] as String? ?? '정보 없음',
      thumbnailUrl: json['thumbnailUrl'] as String?,
      likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
      videoUrl: json['videoUrl'] as String?,
      description: json['description'] as String?,
      advertiser: (json['advertiser'] as num?)?.toInt(),
      landingUrl: json['landingUrl'] as String?,
      adType: json['adType'] as String?,
      targetMinAge: (json['targetMinAge'] as num?)?.toInt(),
      targetMaxAge: (json['targetMaxAge'] as num?)?.toInt(),
      targetGender: json['targetGender'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$$AdModelImplToJson(_$AdModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'brandName': instance.brandName,
      'thumbnailUrl': instance.thumbnailUrl,
      'likesCount': instance.likesCount,
      'videoUrl': instance.videoUrl,
      'description': instance.description,
      'advertiser': instance.advertiser,
      'landingUrl': instance.landingUrl,
      'adType': instance.adType,
      'targetMinAge': instance.targetMinAge,
      'targetMaxAge': instance.targetMaxAge,
      'targetGender': instance.targetGender,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };
