// lib/core/storage/secure_storage.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// SecureStorageService
///
/// JWT 토큰 및 기타 민감한 정보를 안전하게 저장하고 로드하는 서비스입니다.
/// flutter_secure_storage 패키지를 사용합니다.
class SecureStorageService {
  final FlutterSecureStorage _storage;

  // 기본 생성자 또는 테스트용 생성자
  SecureStorageService({FlutterSecureStorage? storage}) : _storage = storage ?? const FlutterSecureStorage();

  static const String _accessTokenKey = 'ACCESS_TOKEN';
  static const String _refreshTokenKey = 'REFRESH_TOKEN';

  /// 액세스 토큰을 안전하게 저장합니다.
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  /// 저장된 액세스 토큰을 불러옵니다.
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  /// 리프레시 토큰을 안전하게 저장합니다.
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  /// 저장된 리프레시 토큰을 불러옵니다.
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  /// 액세스 토큰과 리프레시 토큰을 함께 저장합니다.
  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await saveAccessToken(accessToken);
    await saveRefreshToken(refreshToken);
  }

  /// 저장된 모든 토큰 (액세스, 리프레시)을 삭제합니다.
  Future<void> deleteTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  /// 저장된 모든 데이터를 삭제합니다. (주의해서 사용)
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}

/// SecureStorageService를 제공하는 Riverpod Provider
final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

