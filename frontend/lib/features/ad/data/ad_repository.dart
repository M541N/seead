import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/dio_client.dart';
import '../../../core/api_generated/SeeAD_API.swagger.dart';

class AdRepository {
  final SeeADAPI _api;

  AdRepository(this._api);

  Future<List<Ad>> getAds() async {
    try {
      final response = await _api.apiAdListGet(); // <--- 오류 발생 지점
      if (response.isSuccessful && response.body != null) {
        return response.body!;
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}

final adRepositoryProvider = Provider<AdRepository>((ref) {
  final api = ref.watch(seeAdApiProvider);
  return AdRepository(api);
});