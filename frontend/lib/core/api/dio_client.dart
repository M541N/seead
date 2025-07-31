import 'package:dio/dio.dart';
import '../storage_service.dart';
import 'auth_repository.dart';

class DioClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://localhost:8000/api",
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ));

  static Dio get client {
    _dio.interceptors.clear();

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await StorageService.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          // Access Token 만료 시 Refresh 시도
          final refreshToken = await StorageService.getRefreshToken();
          if (refreshToken != null) {
            final newAccess = await AuthRepository().refreshToken(refreshToken);

            if (newAccess != null) {
              e.requestOptions.headers['Authorization'] = 'Bearer $newAccess';
              final cloneReq = await _dio.fetch(e.requestOptions);
              return handler.resolve(cloneReq);
            }
          }
        }
        return handler.next(e);
      },
    ));
    return _dio;
  }
}