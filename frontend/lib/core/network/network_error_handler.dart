// lib/core/network/network_error_handler.dart
import 'package:dio/dio.dart';

// 사용자 정의 예외 클래스 (선택 사항이지만 권장)
class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic error; // 원래 에러 객체

  NetworkException({
    required this.message,
    this.statusCode,
    this.error,
  });

  @override
  String toString() {
    return 'NetworkException: $message (StatusCode: $statusCode)';
  }
}

class ApiError {
  final String message;
  final int? statusCode;
  // 상세 오류 정보를 담을 수 있는 필드 추가 가능
  // final Map<String, dynamic>? details;

  ApiError({required this.message, this.statusCode});

  factory ApiError.fromDioError(DioException dioError) {
    String message = "알 수 없는 오류가 발생했습니다.";
    int? statusCode = dioError.response?.statusCode;

    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        message = "서버 연결 시간이 초과되었습니다.";
        break;
      case DioExceptionType.sendTimeout:
        message = "요청 전송 시간이 초과되었습니다.";
        break;
      case DioExceptionType.receiveTimeout:
        message = "응답 수신 시간이 초과되었습니다.";
        break;
      case DioExceptionType.badResponse:
        // 서버 응답이 있지만, 상태 코드가 2xx가 아닌 경우
        if (dioError.response != null && dioError.response!.data != null) {
          // 서버에서 내려주는 오류 메시지 파싱 시도
          // 예: { "detail": "Invalid credentials" } 또는 { "message": "..." }
          var responseData = dioError.response!.data;
          if (responseData is Map<String, dynamic>) {
            if (responseData.containsKey('detail')) {
              message = responseData['detail'].toString();
            } else if (responseData.containsKey('message')) {
              message = responseData['message'].toString();
            } else if (responseData.containsKey('error')) {
              message = responseData['error'].toString();
            } else {
              // 특정 필드가 없을 경우, 응답 전체를 문자열로 변환 (너무 길 수 있으니 주의)
              // message = responseData.toString();
              message = _extractMeaningfulError(responseData, statusCode);
            }
          } else if (responseData is String && responseData.isNotEmpty) {
            message = responseData;
          } else {
            message = "서버로부터 유효하지 않은 응답을 받았습니다. (코드: $statusCode)";
          }
        } else {
           message = "서버 응답 오류입니다. (코드: $statusCode)";
        }
        break;
      case DioExceptionType.cancel:
        message = "요청이 취소되었습니다.";
        break;
      case DioExceptionType.connectionError:
         message = "인터넷 연결을 확인해주세요.";
        break;
      case DioExceptionType.unknown:
      default:
        // dio 4.x.x 에서는 SocketException이 connectionError로 처리될 수 있음.
        // dio 5.x.x 에서는 별도 타입이거나 unknown 아래 error 객체 확인 필요.
        // if (dioError.error is SocketException) { // dio 버전에 따라 확인
        //   message = "인터넷 연결을 확인해주세요.";
        // } else {
        message = "네트워크 요청 중 알 수 없는 오류가 발생했습니다.";
        // }
        break;
    }
    return ApiError(message: message, statusCode: statusCode);
  }

  static String _extractMeaningfulError(Map<String, dynamic> responseData, int? statusCode) {
    // 일반적인 오류 메시지 필드들을 찾아봅니다.
    const commonErrorKeys = ['detail', 'message', 'error', 'errors', 'non_field_errors'];
    for (var key in commonErrorKeys) {
        if (responseData.containsKey(key)) {
            var errorValue = responseData[key];
            if (errorValue is List && errorValue.isNotEmpty) {
                return errorValue.join(", "); // 리스트면 합쳐서 보여줌
            }
            return errorValue.toString();
        }
    }
    // 상태 코드에 따른 기본 메시지
    switch (statusCode) {
        case 400: return "잘못된 요청입니다.";
        case 401: return "인증되지 않은 사용자입니다. 다시 로그인해주세요.";
        case 403: return "접근 권한이 없습니다.";
        case 404: return "요청한 정보를 찾을 수 없습니다.";
        case 500: return "서버 내부 오류가 발생했습니다. 잠시 후 다시 시도해주세요.";
        default: return "서버 오류 (코드: $statusCode)";
    }
  }
}

// 이 클래스 또는 함수를 AuthRepository에서 사용하게 됩니다.
// 예시: AuthRepository에서 try-catch로 DioException을 잡고,
// NetworkErrorHandler.handleError(e) 또는 ApiError.fromDioError(e)를 호출
class NetworkErrorHandler {
  // 정적 메소드로 어디서든 쉽게 사용 가능
  static ApiError handleError(dynamic error) {
    if (error is DioException) {
      return ApiError.fromDioError(error);
    } else if (error is NetworkException) {
      // 사용자 정의 NetworkException을 사용하는 경우
      return ApiError(message: error.message, statusCode: error.statusCode);
    } else {
      // 기타 예외 처리
      return ApiError(message: "알 수 없는 오류가 발생했습니다: ${error.toString()}");
    }
  }

  // 또는, NetworkException을 throw 하도록 할 수도 있습니다.
  static Never throwAsNetworkException(dynamic error) {
    if (error is DioException) {
      final apiError = ApiError.fromDioError(error);
      throw NetworkException(
        message: apiError.message,
        statusCode: apiError.statusCode,
        error: error,
      );
    } else if (error is NetworkException) {
      throw error;
    } else {
      throw NetworkException(
        message: "알 수 없는 오류가 발생했습니다: ${error.toString()}",
        error: error,
      );
    }
  }
}
