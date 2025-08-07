/// auth_repository.dart
///
/// 인증 관련 API 호출을 담당하는 저장소입니다.
/// 실제 네트워크 요청은 여기서 처리됩니다.

import 'package:dio/dio.dart'; // dio 패키지 임포트
import '../../../core/network/network_error_handler.dart'; // 네트워크 에러 핸들러
import '../../user/domain/user_model.dart'; // 사용자 모델 (회원가입, 로그인 응답 처리용)
import '../domain/register_request_model.dart'; // 회원가입 요청 모델
// import '../../../core/api/api_client.dart'; // API 클라이언트 (Dio 인스턴스 포함) - 실제 프로젝트에서 사용

// LoginResponse 클래스는 postLogin 메소드가 반환할 타입을 위해 남겨두거나,
// 로그인 응답이 UserModel만 반환한다면 수정될 수 있습니다.
// 여기서는 LoginScreen과 직접적인 관련이 없으므로 일단 그대로 둡니다.
class LoginResponse {
  final String accessToken;
  final String refreshToken;
  // final UserModel user;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    // required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      // user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class AuthRepository {
  final Dio _dio; // Dio 인스턴스 직접 사용 또는 ApiClient를 통해 주입

  // 실제 프로젝트에서는 Dio 인스턴스를 외부에서 주입받는 것이 좋습니다.
  // 예: AuthRepository(this._dio);
  // 우선은 내부에서 간단히 생성하여 사용하겠습니다.
  AuthRepository() : _dio = Dio(BaseOptions(baseUrl: 'YOUR_API_BASE_URL')); // TODO: 실제 API Base URL로 교체

  /// 사용자를 회원가입시킵니다.
  ///
  /// 성공 시 `UserModel` 객체를 반환합니다.
  /// 실패 시 예외를 발생시킵니다.
  Future<UserModel> register(RegisterRequestModel registerRequest) async {
    try {
      final response = await _dio.post(
        '/auth/register/', // API 엔드포인트
        data: registerRequest.toJson(),
      );

      if (response.statusCode == 201 && response.data != null) {
        // API 명세에 따라 회원가입 성공 시 UserInfo (UserModel) 반환
        return UserModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        // 이 경우는 DioError로 처리될 가능성이 높지만, 만약을 위해 남겨둡니다.
        throw NetworkErrorHandler.handleError(response);
      }
    } on DioException catch (e) {
      // DioError를 NetworkErrorHandler로 처리
      throw NetworkErrorHandler.handleError(e);
    } catch (e) {
      // 기타 예외 처리
      throw NetworkErrorHandler.handleError(e);
    }
  }

  /// 이메일과 비밀번호를 사용하여 서버에 로그인을 요청합니다.
  ///
  /// 성공 시 `LoginResponse` 객체를 반환합니다. (API 명세에 따라 수정 필요)
  /// 실패 시 예외를 발생시킵니다.
  Future<LoginResponse> postLogin(String email, String password) async {
    try {
      // TODO: ApiClient 및 실제 API 호출 구현 (/auth/login/ 엔드포인트 사용)
      // API 명세의 로그인 응답을 확인하고 LoginResponse 또는 UserModel을 반환하도록 수정해야 합니다.
      // final response = await _dio.post(
      //   '/auth/login/',
      //   data: {
      //     'email': email, // 또는 API 명세에 따른 필드명 (예: username)
      //     'password': password,
      //   },
      // );

      // if (response.statusCode == 200 && response.data != null) {
      //   // 로그인 성공 시 토큰과 사용자 정보를 포함하는 LoginResponse 또는 UserModel 반환
      //   // 예: return LoginResponse.fromJson(response.data as Map<String, dynamic>);
      //   // 또는 UserModel user = UserModel.fromJson(response.data['user']);
      //   // secureStorage.saveTokens(accessToken: response.data['access'], refreshToken: response.data['refresh']);
      //   // return user; // 또는 LoginResponse
      // } else {
      //   throw NetworkErrorHandler.handleError(response);
      // }

      // --- 임시 응답 (실제 구현 시 위 로직으로 대체) ---
      await Future.delayed(const Duration(milliseconds: 500));
      if (email == "test@example.com" && password == "password") {
        return LoginResponse(
          accessToken: "fake_access_token",
          refreshToken: "fake_refresh_token",
        );
      } else {
        throw NetworkErrorHandler.handleError(Exception('API 호출 실패: 자격 증명 불일치 (시뮬레이션)'));
      }
      // --- 임시 응답 끝 ---

    } on DioException catch (e) {
      throw NetworkErrorHandler.handleError(e);
    } catch (e) {
      throw NetworkErrorHandler.handleError(e);
    }
  }

  /// (선택 사항) 사용자 정보를 가져오는 API 호출
  // Future<UserModel> getUserInfo() async {
  //   try {
  //     // final response = await _dio.get('/auth/user/'); // 사용자 정보 엔드포인트 (API 명세 확인 필요)
  //     // _dio.options.headers['Authorization'] = 'Bearer YOUR_ACCESS_TOKEN'; // 실제 토큰 사용
  //     // if (response.statusCode == 200 && response.data != null) {
  //     //   return UserModel.fromJson(response.data as Map<String, dynamic>);
  //     // } else {
  //     //   throw NetworkErrorHandler.handleError(response);
  //     // }

  //     // --- 임시 응답 ---
      //     await Future.delayed(const Duration(milliseconds: 300));
      //     return UserModel(id: 1, username: "testuser", email: "test@example.com", role: "user");
      // --- 임시 응답 끝 ---
  //   } on DioException catch (e) {
  //     throw NetworkErrorHandler.handleError(e);
  //   } catch (e) {
  //     throw NetworkErrorHandler.handleError(e);
  //   }
  // }
}

// Riverpod Provider (선택적)
// final authRepositoryProvider = Provider<AuthRepository>((ref) {
//   // final dio = ref.watch(dioProvider); // 실제 Dio 인스턴스를 제공하는 Provider (예시)
//   // return AuthRepository(dio);
//   return AuthRepository(); // 임시로 직접 생성
// });
