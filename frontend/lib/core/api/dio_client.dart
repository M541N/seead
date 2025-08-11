import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:dio/dio.dart' as dio_package;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../generated/api_generated/SeeAD_API.swagger.dart';

// --- 새로운 Chopper 8.0.0 스타일 인터셉터 클래스 정의 ---
class AuthInterceptor implements Interceptor {
  const AuthInterceptor();

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>( // 반환 타입 FutureOr로 변경
      Chain<BodyType> chain,
      // Request request, // 이 매개변수 제거
      ) async {
    final request = chain.request; // 체인에서 요청 객체 가져오기

    // 요청 수정 로직
    const storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: 'access_token');

    final Map<String, String> updatedHeaders = Map.from(request.headers);
    if (accessToken != null) {
      updatedHeaders['Authorization'] = 'Bearer $accessToken';
    }
    if (!updatedHeaders.containsKey('Content-Type')) {
      updatedHeaders['Content-Type'] = 'application/json';
    }

    final modifiedRequest = request.copyWith(headers: updatedHeaders);

    // 수정된 요청으로 체인을 계속 진행하고 응답을 받음
    final response = await chain.proceed(modifiedRequest);

    // 응답 수정 로직 (필요한 경우)
    return response;
  }
}
// --- 인터셉터 클래스 정의 끝 ---

final dioProvider = Provider((ref) {
  final dio = dio_package.Dio(
    dio_package.BaseOptions(
      baseUrl: "http://localhost:8000/api",
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  dio.interceptors.add(dio_package.InterceptorsWrapper(
    onRequest: (options, handler) async {
      const storage = FlutterSecureStorage();
      final accessToken = await storage.read(key: 'access_token');
      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
      return handler.next(options);
    },
  ));

  return dio;
});

final seeAdApiProvider = Provider<SeeADAPI>((ref) {
  final chopperClient = ChopperClient(
    baseUrl: Uri.parse("http://localhost:8000/api"),
    interceptors: [
      const AuthInterceptor(), // 정의한 클래스의 인스턴스 사용
      // HttpLoggingInterceptor(), // 필요시 로깅 인터셉터 추가
    ],
    converter: JsonConverter(),
    // errorConverter: JsonConverter(),
  );

  return SeeADAPI.create(
    baseUrl: Uri.parse("http://localhost:8000/api"),
    client: chopperClient,
  );
});

