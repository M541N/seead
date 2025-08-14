import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/dio_client.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/api_generated/SeeAD_API.swagger.dart';

class AuthRepository {
  final SeeADAPI _api;

  AuthRepository(this._api);

  Future<bool> login(String username, String password) async {
    try {
      final response = await _api.apiAuthLoginPost(
        body: LoginRequest(username: username, password: password, fcmToken: 'fcmToken'),
      );

      if (response.isSuccessful && response.body != null) {
        final access = response.body!.access;
        final refresh = response.body!.refresh;
        await StorageService.saveTokens(access, refresh);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<String?> refreshToken(String refreshToken) async {
    try {
      final response = await _api.apiAuthTokenRefreshPost(
        body: TokenRefreshRequest(refresh: refreshToken),
      );
      if (response.isSuccessful && response.body != null) {
        final newAccess = response.body!.access;
        await StorageService.saveTokens(newAccess!, refreshToken);
        return newAccess;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserInfo() async {
    try {
      final response = await _api.apiAuthMeGet();
      if (response.isSuccessful && response.body != null) {
        return response.body!.toJson();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    await StorageService.deleteTokens();
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final api = ref.watch(seeAdApiProvider);
  return AuthRepository(api);
});
