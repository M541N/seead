import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum AdCampaignTargetGender {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('male')
  male('male'),
  @JsonValue('female')
  female('female'),
  @JsonValue('all')
  all('all');

  final String? value;

  const AdCampaignTargetGender(this.value);
}

enum AdCampaignRequestTargetGender {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('male')
  male('male'),
  @JsonValue('female')
  female('female'),
  @JsonValue('all')
  all('all');

  final String? value;

  const AdCampaignRequestTargetGender(this.value);
}

enum BlankEnum {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('')
  $null('');

  final String? value;

  const BlankEnum(this.value);
}

enum EventTypeEnum {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('view')
  view('view'),
  @JsonValue('click')
  click('click'),
  @JsonValue('conversion')
  conversion('conversion');

  final String? value;

  const EventTypeEnum(this.value);
}

enum PatchedAdCampaignRequestTargetGender {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('male')
  male('male'),
  @JsonValue('female')
  female('female'),
  @JsonValue('all')
  all('all');

  final String? value;

  const PatchedAdCampaignRequestTargetGender(this.value);
}

enum StatusEnum {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('DRAFT')
  draft('DRAFT'),
  @JsonValue('PENDING_REVIEW')
  pendingReview('PENDING_REVIEW'),
  @JsonValue('SCHEDULED')
  scheduled('SCHEDULED'),
  @JsonValue('OPERATING')
  operating('OPERATING'),
  @JsonValue('PAUSED')
  paused('PAUSED'),
  @JsonValue('ENDED')
  ended('ENDED'),
  @JsonValue('COMPLETED')
  completed('COMPLETED'),
  @JsonValue('REJECTED')
  rejected('REJECTED');

  final String? value;

  const StatusEnum(this.value);
}

enum TargetGenderEnum {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Male')
  male('Male'),
  @JsonValue('Female')
  female('Female');

  final String? value;

  const TargetGenderEnum(this.value);
}
