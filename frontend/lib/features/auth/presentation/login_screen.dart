/// login_screen.dart
///
/// 사용자 로그인을 위한 UI 화면입니다.
/// 이메일과 비밀번호를 입력받아 로그인을 시도합니다.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/auth_provider.dart'; // AuthProvider 임포트
// TODO: HomeScreen 생성 후 올바른 경로로 수정하고 주석 해제
// import '../../home/presentation/home_screen.dart'; // 로그인 성공 후 홈 화면 이동 시 필요
import 'signup_screen.dart'; // 회원가입 화면 이동

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;

  // 임시 HomeScreen routeName (실제 HomeScreen 생성 후 해당 파일에서 가져오도록 수정)
  static const String _tempHomeScreenRouteName = '/home';


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus(); // 키보드 숨기기

      final email = _emailController.text.trim();
      final password = _passwordController.text;

      // authProvider의 login 메소드 호출
      await ref.read(authProvider.notifier).login(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    // authProvider 상태를 listen하여 UI 업데이트 (에러, 로딩 등)
    ref.listen<AuthState>(authProvider, (previous, next) {
      next.whenOrNull(
        data: (user) {
          if (user != null && (previous is AsyncLoading || previous == null)) { // 로그인 성공
            // TODO: HomeScreen.routeName으로 변경
            Navigator.of(context).pushReplacementNamed(_tempHomeScreenRouteName);
          }
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('로그인 오류: ${error.toString()}')),
          );
        },
      );
    });

    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading; // AsyncValue의 isLoading 사용

    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
        // automaticallyImplyLeading: false, // 스플래시 -> 로그인 시 뒤로가기 버튼 없애기
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const FlutterLogo(size: 80, style: FlutterLogoStyle.stacked),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: '이메일',
                    hintText: 'test@example.com', // 임시 테스트 계정 힌트
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '이메일을 입력해주세요.';
                    }
                    // TODO: API 명세에 따른 이메일 유효성 검사 (UserInfo 스키마 email format)
                    final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                    if (!emailRegex.hasMatch(value.trim())) {
                      return '유효한 이메일 주소를 입력해주세요.';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    hintText: 'password', // 임시 테스트 계정 힌트
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                  obscureText: _isObscure,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '비밀번호를 입력해주세요.';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => isLoading ? null : _login(),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: 비밀번호 찾기 화면으로 이동
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('비밀번호 찾기 (구현 예정)')),
                      );
                    },
                    child: const Text('비밀번호를 잊으셨나요?'),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  child: isLoading
                      ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                      : const Text('로그인'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('계정이 없으신가요?'),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(SignupScreen.routeName);
                      },
                      child: const Text('회원가입'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}