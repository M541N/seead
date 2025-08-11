// lib/features/auth/presentation/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/auth_provider.dart';
import 'login_screen.dart'; // LoginScreen import

// import '../advertiser/dashboard/advertiser_dashboard_screen.dart'; // 제거됨
// import '../user/home/user_home_screen.dart'; // 제거됨

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _performAutoLoginCheck();
  }

  Future<void> _performAutoLoginCheck() async {
    // --- 임시 조치: getUserInfo 및 userProvider 오류 해결 전까지 ---
    // 자동 로그인 로직은 주석 처리하고, SplashScreen은 잠시 후 LoginScreen으로 이동하도록 합니다.
    // 이는 AuthProvider 및 AuthRepository의 관련 메소드들이 수정될 때까지의 임시 방편입니다.
    await Future.delayed(const Duration(milliseconds: 500)); // 최소 스플래시 시간
    if (mounted) {
      // GoRouter의 initialLocation이 LoginScreen.routeName으로 설정되어 있고,
      // 인증 상태에 따라 redirect 로직이 작동하므로,
      // SplashScreen에서는 특정 화면으로 강제 이동할 필요가 없을 수 있습니다.
      // 다른 로직이 안정화되기 전까지는 명시적으로 LoginScreen으로 보내는 것이 안전할 수 있습니다.
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
