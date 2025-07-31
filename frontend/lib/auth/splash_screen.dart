import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/provider/providers.dart';
import '../user/home/user_home_screen.dart';
import '../advertiser/dashboard/advertiser_dashboard_screen.dart';
import 'login_screen.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  Future<void> _checkAuth(WidgetRef ref, BuildContext context) async {
    final authRepo = ref.read(authRepositoryProvider);
    final user = await authRepo.getUserInfo();

    if (user != null) {
      ref.read(userProvider.notifier).state = user;
      if (user['member_type'] == 'advertiser') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AdvertiserDashboardScreen()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const UserHomeScreen()));
      }
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _checkAuth(ref, context);
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}