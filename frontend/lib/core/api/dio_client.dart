import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../generated/api_generated/SeeAD_API.swagger.dart';

final dioProvider = Provider((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: "http://localhost:8000/api",
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  dio.interceptors.add(InterceptorsWrapper(
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
  final dio = ref.watch(dioProvider);
  return SeeADAPI.create(baseUrl: Uri.parse("http://localhost:8000/api"), client: ChopperClient(client: dio));
});
