import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// 사용자 정보를 나타내는 모델 클래스입니다.
/// API 명세의 UserInfo 스키마를 기반으로 하며, 'role' 필드가 추가되었습니다.
@freezed
class UserModel with _$UserModel {
  /// UserModel 생성자
  ///
  /// [id] 사용자 고유 식별자 (readOnly)
  /// [username] 사용자 이름 (150자 이하, 문자, 숫자, @/./+/-/_ 만 가능)
  /// [email] 이메일 주소
  /// [role] 사용자 역할 (기본값: 'user')
  const factory UserModel({
    required int id,
    required String username,
    @Default('') String email, // API 명세상 email이 필수 항목이 아닐 수 있음을 고려 (필수라면 @Default 제거)
    @Default('user') String role,
  }) = _UserModel;

  /// JSON으로부터 UserModel 객체를 생성합니다.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

