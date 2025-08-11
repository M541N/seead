import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async'; // For StreamSubscription and ChangeNotifier

import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/signup_screen.dart';
import '../features/auth/provider/auth_provider.dart';
import '../features/ad/presentation/ad_list_screen.dart';
import '../features/ad/presentation/ad_detail_screen.dart'; // AdDetailScreen import 활성화

// import '../features/auth/presentation/splash_screen.dart';


final routerProvider = Provider<GoRouter>((ref) {
  final authStream = ref.watch(authProvider.notifier).stream;

  return GoRouter(
    initialLocation: LoginScreen.routeName,
    refreshListenable: GoRouterRefreshStream(authStream),
    routes: <RouteBase>[
      GoRoute(
        path: LoginScreen.routeName, // '/login'
        name: LoginScreen.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: SignupScreen.routeName, // '/signup'
        name: SignupScreen.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const SignupScreen();
        },
      ),
      GoRoute(
        path: AdListScreen.routeName, // '/ads'
        name: AdListScreen.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const AdListScreen();
        },
        // AdDetailScreen 라우트를 하위 경로로 정의
        routes: <RouteBase>[
          GoRoute(
            // AdDetailScreen.routeName ('detail')을 사용하고, adId를 경로 파라미터로 받음
            // 예: /ads/detail/123
            path: '${AdDetailScreen.routeName}/:adId',
            name: AdDetailScreen.routeName, // 라우트 이름 (AdListScreen에서 사용)
            builder: (context, state) {
              // 경로 파라미터에서 adId를 추출
              final adIdString = state.pathParameters['adId'];
              if (adIdString == null) {
                // adId가 없는 경우 오류 페이지 또는 다른 처리
                return Scaffold(
                  appBar: AppBar(title: const Text('Error')),
                  body: const Center(child: Text('Ad ID is missing')),
                );
              }
              try {
                final adId = int.parse(adIdString);
                return AdDetailScreen(adId: adId);
              } catch (e) {
                // adId 파싱 오류 처리
                return Scaffold(
                  appBar: AppBar(title: const Text('Error')),
                  body: Center(child: Text('Invalid Ad ID format: $adIdString')),
                );
              }
            },
          ),
        ],
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final authState = ref.watch(authProvider);
      final isAuthenticated = authState.asData?.value != null;

      final loggingIn = state.matchedLocation == LoginScreen.routeName;
      final signingUp = state.matchedLocation == SignupScreen.routeName;

      if (!isAuthenticated && !loggingIn && !signingUp) {
        return LoginScreen.routeName;
      }

      if (isAuthenticated && (loggingIn || signingUp)) {
        return AdListScreen.routeName;
      }
      return null;
    },
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(child: Text('Error: ${state.error}')),
    ),
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

