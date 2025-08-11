import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/dio_client.dart'; // dioProvider가 있는 파일
import '../domain/ad_model.dart';

final adServiceProvider = Provider<AdService>((ref) {
  final dio = ref.watch(dioProvider); // 수정된 코드
  return AdService(dio);
});

class AdService {
  final Dio _dio;

  AdService(this._dio);

  Future<List<AdModel>> getAds({int? page, int? pageSize}) async {
    try {
      final Map<String, dynamic> queryParameters = {};
      if (page != null) queryParameters['page'] = page;
      if (pageSize != null) queryParameters['page_size'] = pageSize;

      final response = await _dio.get(
        '/api/ads/',
        queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> adListJson = response.data as List<dynamic>;
        return adListJson
            .map((json) => AdModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to load ads: Status code ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print('Error fetching ads: $e');
      rethrow;
    } catch (e) {
      print('Unexpected error in getAds: $e');
      rethrow;
    }
  }

  /// 특정 ID의 광고 상세 정보를 가져옵니다.
  /// API 명세: GET /api/ads/{id}/ (가정)
  Future<AdModel> getAdById(int id) async {
    try {
      final response = await _dio.get('/api/ads/$id/'); // 예: /api/ads/123/

      if (response.statusCode == 200 && response.data != null) {
        // API 응답이 단일 AdModel 객체를 직접 반환한다고 가정
        return AdModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to load ad details: Status code ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print('Error fetching ad by ID $id: $e');
      rethrow;
    } catch (e) {
      print('Unexpected error in getAdById for ID $id: $e');
      rethrow;
    }
  }

// TODO: 광고 생성, 수정, 삭제 등의 메소드 추가 (필요시)
}
