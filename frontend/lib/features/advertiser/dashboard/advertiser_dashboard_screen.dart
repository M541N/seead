import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/notification/provider/notification_provider.dart';
import '../../notification/presentation/notification_screen.dart';

class AdvertiserDashboardScreen extends ConsumerStatefulWidget {
  const AdvertiserDashboardScreen({super.key});

  @override
  ConsumerState<AdvertiserDashboardScreen> createState() => _AdvertiserDashboardScreenState();
}

class _AdvertiserDashboardScreenState extends ConsumerState<AdvertiserDashboardScreen> {
  int _currentIndex = 0;

  final screens = const [
    Center(child: Text("대시보드")),
    Center(child: Text("캠페인")),
    Center(child: Text("광고 관리")),
    Center(child: Text("리포트")),
    Center(child: Text("알림")), // 알림 탭 추가
  ];

  @override
  Widget build(BuildContext context) {
    final unreadCount = ref.watch(unreadNotificationCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("광고주 대시보드"),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications),
                if (unreadCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                      child: Text(
                        '$unreadCount',
                        style: const TextStyle(color: Colors.white, fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationScreen()),
              );
            },
          ),
        ],
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() {
            _currentIndex = i;
            // 알림 탭 클릭 시 알림 페이지 이동
            if (i == 4) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationScreen()),
              );
            }
          });
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: '대시보드'),
          const BottomNavigationBarItem(icon: Icon(Icons.campaign), label: '캠페인'),
          const BottomNavigationBarItem(icon: Icon(Icons.video_library), label: '광고 관리'),
          const BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: '리포트'),
          BottomNavigationBarItem(
            icon: badges.Badge(
              showBadge: unreadCount > 0,
              badgeContent: Text(
                '$unreadCount',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              position: badges.BadgePosition.topEnd(top: -10, end: -12),
              child: const Icon(Icons.notifications),
            ),
            label: '알림',
          ),
        ],
      ),
    );
  }
}