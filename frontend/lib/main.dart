import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/notifications/fcm_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FCMService.initializeFCM(); // FCM 초기화
  runApp(const ProviderScope(child: SeeAdApp()));
}

class SeeAdApp extends StatelessWidget {
  const SeeAdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'seeAD',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}