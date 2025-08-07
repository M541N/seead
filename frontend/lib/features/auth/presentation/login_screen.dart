/// login_screen.dart
///
/// 사용자 로그인 화면을 정의합니다.
/// 이메일과 비밀번호를 입력받아 로그인을 시도하고,
/// 성공 시 홈 화면으로 이동합니다.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/auth_provider.dart'; // auth_provider.dart 파일이 생성될 예정입니다.
// import '../../user/home/user_home_screen.dart'; // 홈 화면 경로에 맞게 수정 필요
// import '../../../app/router.dart'; // 라우터 참조, go_router 사용 시 필요

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // isLoading 상태는 authProvider를 통해 관리될 수 있습니다.
  // bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// 로그인 시도 함수
  Future<void> _attemptLogin() async {
    // 키보드 숨기기
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      // _isLoading = true; // 상태는 authProvider에서 관리
      // setState(() {});

      final email = _emailController.text;
      final password = _passwordController.text;

      // authProvider의 login 메소드 호출
      // login 메소드는 내부적으로 성공 시 라우팅, 실패 시 에러 상태 업데이트를 담당합니다.
      await ref.read(authProvider.notifier).login(email, password);

      // _isLoading = false; // 상태는 authProvider에서 관리
      // if (mounted) {
      //   setState(() {});
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    // authProvider의 상태를 watch하여 UI를 업데이트 (예: 에러 메시지, 로딩 상태)
    // ref.watch(authProvider) 등을 사용하여 상태 변경에 따라 반응합니다.

    // 로그인 실패 시 SnackBar를 보여주기 위한 리스너 설정
    ref.listen<AsyncValue<void>>(authProvider, (_, state) {
      state.whenOrNull(
        error: (error, stackTrace) {
          // network_error_handler.dart 를 사용하여 에러 메시지를 가공할 수 있습니다.
          // 여기서는 간단히 에러 메시지를 표시합니다.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()), // 실제 에러 메시지 포맷은 조정 필요
              backgroundColor: Colors.red,
            ),
          );
        },
        // data가 null이 아니고, 로딩이 끝났으며, 에러가 없다면 성공으로 간주하고
        // 라우터가 authState 변경을 감지하여 홈으로 이동시킬 것입니다.
        // authProvider 내부에서 로그인 성공 시 authState를 업데이트해야 합니다.
      );
    });

    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // 앱 로고 (예시)
                const FlutterLogo(size: 80),
                const SizedBox(height: 48.0),

                // 이메일 입력 필드
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: '이메일',
                    hintText: 'user@example.com',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이메일을 입력해주세요.';
                    }
                    if (!value.contains('@')) { // 간단한 이메일 형식 검사
                      return '유효한 이메일을 입력해주세요.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // 비밀번호 입력 필드
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: '비밀번호',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '비밀번호를 입력해주세요.';
                    }
                    // 비밀번호 정책에 따른 검증 로직 추가 가능
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),

                // 로그인 버튼
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    textStyle: const TextStyle(fontSize: 16.0),
                  ),
                  onPressed: authState.isLoading ? null : _attemptLogin,
                  child: authState.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('로그인'),
                ),
                const SizedBox(height: 16.0),

                // 회원가입 페이지로 이동 링크 (예시)
                TextButton(
                  onPressed: () {
                    // TODO: 회원가입 페이지로 네비게이션
                    // 예: context.go('/signup'); 또는 Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text('계정이 없으신가요? 회원가입'),
                ),

                // 비밀번호 찾기 링크 (예시)
                TextButton(
                  onPressed: () {
                    // TODO: 비밀번호 찾기 페이지로 네비게이션
                  },
                  child: const Text('비밀번호를 잊으셨나요?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
