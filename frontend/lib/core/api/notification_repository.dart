import 'package:dio/dio.dart';
import '../api/dio_client.dart';
import '../models/notification_model.dart';

class NotificationRepository {
  final Dio _dio = DioClient.client;

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