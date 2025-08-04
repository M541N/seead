import 'package:dio/dio.dart';
import 'dio_client.dart';
import '../storage_service.dart';

class AuthRepository {
  final Dio _dio = DioClient.client;

  Future<bool> login(String username, String password) async {
    try {
      final response = await _dio.post('/auth/login/', data: {
        "username": username,
        "password": password,
        "fcm_token": fcmToken,
      });

      final access = response.data['access'];
      final refresh = response.data['refresh'];
      if (access != null && refresh != null) {
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
      final response = await Dio().post(
        "http://localhost:8000/api/auth/token/refresh/",
        data: {"refresh": refreshToken},
      );
      final newAccess = response.data['access'];
      if (newAccess != null) {
        await StorageService.saveTokens(newAccess, refreshToken);
        return newAccess;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserInfo() async {
    try {
      final response = await _dio.get('/auth/me/');
      return response.data['user'];
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    await StorageService.deleteTokens();
  }
}