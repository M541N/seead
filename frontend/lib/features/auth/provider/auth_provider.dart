/// auth_provider.dart
///
/// 사용자의 인증 상태를 관리하고, 로그인/로그아웃 로직을 처리하는 Provider입니다.

import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../repository/auth_repository.dart'; // auth_repository.dart 파일이 생성될 예정입니다.
// import '../../../core/storage/secure_storage.dart'; // secure_storage.dart 파일이 생성될 예정입니다.
// import '../domain/user_model.dart'; // user_model.dart 파일이 생성될 예정입니다.

/// 인증 상태를 나타내는 클래스입니다.
/// 로딩 중, 에러 발생, 데이터 존재 여부 등을 관리합니다.
/// 실제 프로젝트에서는 freezed를 사용하여 더 간결하게 정의할 수 있습니다.
class AuthState {
  final bool isLoading;
  final String? error;
  // final UserModel? user; // 로그인 성공 시 사용자 정보 저장

  const AuthState({
    this.isLoading = false,
    this.error,
    // this.user,
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
    // UserModel? user,
    bool clearError = false, // 에러 메시지를 명시적으로 null로 설정할지 여부
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
      // user: user ?? this.user,
    );
  }
}

/// AuthNotifier는 인증 관련 비즈니스 로직을 처리하고 상태를 관리합니다.
class AuthNotifier extends StateNotifier<AuthState> {
  // final AuthRepository _authRepository;
  // final SecureStorage _secureStorage;

  AuthNotifier(
      // this._authRepository, this._secureStorage
      )
      : super(const AuthState());

  /// 이메일과 비밀번호를 사용하여 로그인을 시도합니다.
  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      // TODO: auth_repository를 사용하여 실제 로그인 API 호출
      // final loginResponse = await _authRepository.postLogin(email, password);

      // TODO: secure_storage를 사용하여 JWT 토큰 저장
      // await _secureStorage.write(key: 'accessToken', value: loginResponse.accessToken);
      // await _secureStorage.write(key: 'refreshToken', value: loginResponse.refreshToken);

      // TODO: 사용자 정보 요청 및 상태 업데이트 (필요 시)
      // final userInfo = await _authRepository.getUserInfo();
      // state = state.copyWith(isLoading: false, user: userInfo, error: null);

      // 임시 성공 처리 (실제 구현 시 위 로직으로 대체)
      await Future.delayed(const Duration(seconds: 1)); // 네트워크 요청 시뮬레이션
      if (email == "test@example.com" && password == "password") {
        state = state.copyWith(isLoading: false, error: null /* user: UserModel(id: '1', email: email, name: 'Test User') */);
        // 로그인 성공 후 라우팅은 router.dart의 redirect 로직 또는 UI 콜백에서 처리합니다.
      } else {
        throw Exception('이메일 또는 비밀번호가 일치하지 않습니다.');
      }

    } catch (e) {
      // TODO: network_error_handler.dart를 사용하여 에러 메시지 가공
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// 로그아웃을 처리합니다.
  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    // TODO: secure_storage에서 토큰 삭제
    // await _secureStorage.deleteAll();
    // state = const AuthState(); // 초기 상태로 리셋
    
    // 임시 로그아웃 처리
    await Future.delayed(const Duration(seconds: 1));
    state = const AuthState();
  }

  /// 앱 시작 시 자동 로그인을 시도합니다.
  Future<void> checkAuthStatus() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: secure_storage에서 토큰 확인
      // final accessToken = await _secureStorage.read(key: 'accessToken');
      // if (accessToken != null) {
        // TODO: 토큰 유효성 검사 및 사용자 정보 로드
        // final userInfo = await _authRepository.getUserInfo(); // 또는 토큰만으로 인증 상태 간주
        // state = state.copyWith(isLoading: false, user: userInfo);
      // } else {
      //   state = state.copyWith(isLoading: false); // 토큰 없음
      // }

      // 임시 자동 로그인 실패 처리 (실제 구현 시 위 로직으로 대체)
      await Future.delayed(const Duration(milliseconds: 500));
      state = state.copyWith(isLoading: false);

    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      // 토큰이 유효하지 않거나 사용자 정보를 가져오는 데 실패한 경우 로그아웃 처리
      // await logout(); 
    }
  }
}

/// authProvider는 AuthNotifier의 인스턴스를 제공하는 StateNotifierProvider입니다.
/// UI에서 이 Provider를 통해 AuthNotifier의 상태를 읽고 메소드를 호출할 수 있습니다.
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  // final authRepository = ref.watch(authRepositoryProvider); // 의존성 주입
  // final secureStorage = ref.watch(secureStorageProvider); // 의존성 주입
  // return AuthNotifier(authRepository, secureStorage);
  return AuthNotifier(); // 우선 의존성 없이 생성
});
