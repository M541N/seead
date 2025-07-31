import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/provider/providers.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('알림'),
        actions: [
          IconButton(
            icon: const Icon(Icons.mark_email_read),
            onPressed: () => ref.read(notificationsProvider.notifier).markAllAsRead(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(notificationsProvider.notifier).loadNotifications();
        },
        child: notifications.isEmpty
            ? const Center(child: Text('알림이 없습니다.'))
            : ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final noti = notifications[index];
            return ListTile(
              title: Text(
                noti.message,
                style: TextStyle(
                  fontWeight: noti.isRead ? FontWeight.normal : FontWeight.bold,
                ),
              ),
              subtitle: Text(
                noti.type,
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: Text(
                '${noti.createdAt.hour}:${noti.createdAt.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              onTap: () => ref.read(notificationsProvider.notifier).markAsRead(noti.id),
            );
          },
        ),
      ),
    );
  }
}