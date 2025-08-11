import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// 사용자 정보를 나타내는 모델 클래스입니다.
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String username,

    // email을 non-null + 기본값 '' 로 유지
    @Default('') @JsonKey(defaultValue: '') String email,

    // role 기본값 'user'
    @Default('user') @JsonKey(defaultValue: 'user') String role,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}