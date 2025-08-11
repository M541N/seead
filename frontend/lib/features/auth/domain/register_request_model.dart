// lib/features/auth/domain/register_request_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request_model.freezed.dart';
part 'register_request_model.g.dart';

/// 회원가입 요청 시 사용되는 데이터 모델
@freezed
class RegisterRequestModel with _$RegisterRequestModel {
  const factory RegisterRequestModel({
    required String username,
    required String email,
    required String password,
  }) = _RegisterRequestModel;

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);
}

