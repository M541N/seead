import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/auth_repository.dart';
import '../api/notification_repository.dart';
import '../models/notification_model.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());
final userProvider = StateProvider<Map<String, dynamic>?>((ref) => null);
final tokenProvider = StateProvider<String?>((ref) => null);

final notificationRepositoryProvider = Provider((ref) => NotificationRepository());

final notificationsProvider = StateNotifierProvider<NotificationsNotifier, List<NotificationModel>>((ref) {
  return NotificationsNotifier(ref.read(notificationRepositoryProvider));
});

class NotificationsNotifier extends StateNotifier<List<NotificationModel>> {
  final NotificationRepository _repo;
  NotificationsNotifier(this._repo) : super([]);

  Future<void> loadNotifications() async {
    final notis = await _repo.fetchNotifications();
    state = notis;
  }

  Future<void> markAsRead(int id) async {
    await _repo.markAsRead(id);
    state = [
      for (final n in state)
        if (n.id == id) NotificationModel(
          id: n.id,
          message: n.message,
          isRead: true,
          type: n.type,
          createdAt: n.createdAt,
        ) else n
    ];
  }

  Future<void> markAllAsRead() async {
    await _repo.markAllAsRead();
    state = [
      for (final n in state)
        NotificationModel(
          id: n.id,
          message: n.message,
          isRead: true,
          type: n.type,
          createdAt: n.createdAt,
        )
    ];
  }
}

final unreadNotificationCountProvider = Provider<int>((ref) {
  final notifications = ref.watch(notificationsProvider);
  return notifications.where((n) => !n.isRead).length;
});