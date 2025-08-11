/// auth_provider.dart
///
/// 인증 상태 및 관련 비즈니스 로직을 관리하는 Riverpod Provider입니다.
/// (로그인, 로그아웃, 회원가입, 인증 상태 확인 등)

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/auth_repository.dart'; // AuthRepository 임포트
import '../../user/domain/user_model.dart'; // UserModel 임포트
import '../domain/register_request_model.dart'; // RegisterRequestModel 임포트
import '../../../core/storage/secure_storage.dart'; // SecureStorageService 임포트

// --- 상태 정의 ---

/// 인증 상태를 나타내는 클래스.
/// `AsyncValue`를 사용하여 로딩, 데이터, 에러 상태를 쉽게 관리합니다.
typedef AuthState = AsyncValue<UserModel?>;

// --- StateNotifier 정의 ---

/// 인증 로직을 처리하고 상태를 관리하는 StateNotifier.
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final SecureStorageService _secureStorageService;

  AuthNotifier(this._authRepository, this._secureStorageService) : super(const AsyncValue.data(null)) {
    // 앱 시작 시 자동 로그인 시도 (옵션)
    // checkAuthStatus();
  }

  /// 사용자 회원가입을 시도합니다.
  ///
  /// 성공 시, 상태는 회원가입된 사용자 정보(`UserModel`)를 포함하는 `AsyncData`가 됩니다.
  /// (추가적으로 자동 로그인을 수행할 수도 있습니다)
  /// 실패 시, 상태는 에러 정보를 포함하는 `AsyncError`가 됩니다.
  Future<void> register(String username, String email, String password) async {
    state = const AsyncValue.loading(); // 로딩 상태로 변경
    try {
      final registerRequest = RegisterRequestModel(
        username: username,
        email: email,
        password: password,
      );
      final user = await _authRepository.register(registerRequest);
      // 회원가입 성공 시, 바로 로그인 상태로 만들거나 사용자 정보를 별도로 저장할 수 있습니다.
      // 여기서는 성공적으로 UserModel을 받았음을 의미하는 상태로 업데이트합니다.
      // 필요하다면, 이 UserModel로 토큰을 요청하고 로그인 상태로 전환하는 로직을 추가할 수 있습니다.
      // 예를 들어, 회원가입 후 바로 로그인 처리를 원한다면:
      // await login(email, password); // 또는 username, password
      // 또는
      // state = AsyncValue.data(user); // 단순 성공 알림
      // 여기서는 회원가입 성공 후 받은 사용자 정보를 상태로 설정합니다.
      // 이후 UI에서 이 정보를 바탕으로 로그인 화면으로 안내하거나, 자동 로그인 처리를 할 수 있습니다.
      state = AsyncValue.data(user);
      // TODO: 회원가입 성공 후 자동 로그인 정책에 따라 추가 로직 구현 (토큰 저장, 상태 변경 등)
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// 이메일과 비밀번호를 사용하여 로그인을 시도합니다.
  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      // TODO: AuthRepository의 postLogin 호출
      // final loginResponse = await _authRepository.postLogin(email, password);
      // await _secureStorageService.saveTokens(
      //   accessToken: loginResponse.accessToken,
      //   refreshToken: loginResponse.refreshToken,
      // );

      // TODO: 로그인 성공 후 사용자 정보 가져오기 (API 명세에 따라)
      // final user = await _authRepository.getUserInfo(); // 또는 loginResponse에 사용자 정보가 포함되어 있다면 그것을 사용
      // state = AsyncValue.data(user);

      // --- 임시 로그인 성공 처리 (실제 구현 시 위 로직으로 대체) ---
      await Future.delayed(const Duration(seconds: 1)); // 네트워크 지연 시뮬레이션
      if (email == "test@example.com" && password == "password") {
        final tempUser = UserModel(id: 1, username: "테스트유저", email: email, role: "user");
        await _secureStorageService.saveTokens(accessToken: "fake_access_token", refreshToken: "fake_refresh_token");
        state = AsyncValue.data(tempUser);
      } else {
        throw Exception("이메일 또는 비밀번호가 잘못되었습니다.");
      }
      // --- 임시 로그인 성공 처리 끝 ---

    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// 로그아웃을 처리합니다.
  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await _secureStorageService.deleteTokens(); // 저장된 토큰 삭제
      state = const AsyncValue.data(null); // 로그아웃 상태로 변경
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// 앱 시작 시 또는 필요할 때 인증 상태를 확인합니다.
  /// (예: 저장된 토큰 유효성 검사 후 자동 로그인)
  Future<void> checkAuthStatus() async {
    state = const AsyncValue.loading();
    try {
      final accessToken = await _secureStorageService.getAccessToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        // TODO: 토큰 유효성 검사 API 호출 또는 사용자 정보 직접 가져오기
        // 여기서는 임시로 토큰이 있으면 로그인된 것으로 간주하고 임시 사용자 정보를 불러옵니다.
        // final user = await _authRepository.getUserInfo(); // 실제로는 API를 통해 사용자 정보 조회
        await Future.delayed(const Duration(milliseconds: 500)); // 네트워크 지연 시뮬레이션
        final tempUser = UserModel(id: 1, username: "자동로그인유저", email: "auto@example.com", role: "user");
        state = AsyncValue.data(tempUser);
      } else {
        state = const AsyncValue.data(null); // 토큰이 없으면 로그아웃 상태
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

// --- Provider 정의 ---

/// AuthRepository를 제공하는 Provider.
/// 실제 앱에서는 ApiClient(Dio 인스턴스 포함)를 주입받아 생성합니다.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  // TODO: 실제 Dio 인스턴스 또는 ApiClient를 주입하도록 수정
  // 예: final dio = ref.watch(dioProvider);
  // return AuthRepository(dio);
  return AuthRepository(); // 현재는 내부에서 Dio 인스턴스 생성
});

/// SecureStorageService를 제공하는 Provider.
/// 이전에 secure_storage.dart에서 이미 정의했지만, auth_provider.dart 내부에서
/// 명시적으로 참조하기 위해 또는 테스트 용이성을 위해 여기서 다시 정의할 수 있습니다.
/// 일반적으로는 secure_storage.dart에 있는 것을 직접 임포트하여 사용합니다.
/// 여기서는 중복 정의보다는 secure_storage.dart의 것을 사용한다고 가정하고 주석 처리합니다.
// final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
//   return SecureStorageService();
// });

/// AuthNotifier를 제공하는 StateNotifierProvider.
/// UI에서 이 Provider를 watch하여 인증 상태 변경을 감지하고, 메소드를 호출하여 인증 액션을 수행합니다.
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final secureStorageService = ref.watch(secureStorageServiceProvider); // secure_storage.dart의 provider 사용
  return AuthNotifier(authRepository, secureStorageService);
});

