import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod import 추가
// import '../api/dio_client.dart'; // 기존 DioClient import 제거 또는 수정
import 'dio_client.dart'; // dioProvider를 가져오기 위해 수정
import 'package:frontend/features/notification/data/model/notification_model.dart';

// NotificationRepository를 제공하는 Riverpod 프로바이더
final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final dio = ref.watch(dioProvider); // dioProvider로부터 Dio 인스턴스를 가져옴
  return NotificationRepository(dio);
});

class NotificationRepository {
  final Dio _dio; // Dio 인스턴스를 저장할 멤버 변수

  // 생성자를 통해 Dio 인스턴스를 주입받음
  NotificationRepository(this._dio);

  Future<List<NotificationModel>> fetchNotifications() async {
    final response = await _dio.get('/notifications/');
    final data = response.data as List;
    return data.map((n) => NotificationModel.fromJson(n)).toList();
  }

  Future<void> markAsRead(int id) async {
    await _dio.post('/notifications/$id/read/');
  }

  Future<void> markAllAsRead() async {
    await _dio.post('/notifications/read-all/');
  }
}