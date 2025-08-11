import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/ad_service.dart';
import '../domain/ad_model.dart';

// 광고 목록을 제공하는 FutureProvider
final adsProvider = FutureProvider<List<AdModel>>((ref) async {
  final adService = ref.watch(adServiceProvider);
  return adService.getAds();
});

// 특정 광고의 상세 정보를 제공하는 FutureProvider.family
// .family를 사용하면 프로바이더에 파라미터를 전달할 수 있습니다 (여기서는 adId).
final adDetailProvider = FutureProvider.family<AdModel, int>((ref, adId) async {
  final adService = ref.watch(adServiceProvider);
  return adService.getAdById(adId);
});


// 향후 페이지네이션, 필터링 등 복잡한 상태 관리가 필요하다면
// StateNotifierProvider와 StateNotifier를 사용하는 것을 고려할 수 있습니다.
// 예시:
/*
final paginatedAdsProvider = StateNotifierProvider<AdsNotifier, AsyncValue<List<AdModel>>>((ref) {
  return AdsNotifier(ref);
});

class AdsNotifier extends StateNotifier<AsyncValue<List<AdModel>>> {
  AdsNotifier(this.ref) : super(const AsyncValue.loading()) {
    _fetchInitialAds();
  }

  final Ref ref;
  int _currentPage = 1;
  final int _pageSize = 10; // 예시 페이지 크기
  bool _isLoadingMore = false;
  bool _hasMoreData = true;

  Future<void> _fetchInitialAds() async {
    state = const AsyncValue.loading();
    try {
      final ads = await ref.read(adServiceProvider).getAds(page: _currentPage, pageSize: _pageSize);
      if (ads.length < _pageSize) {
        _hasMoreData = false;
      }
      state = AsyncValue.data(ads);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> fetchMoreAds() async {
    if (_isLoadingMore || !_hasMoreData) return;

    _isLoadingMore = true;
    _currentPage++;

    try {
      final newAds = await ref.read(adServiceProvider).getAds(page: _currentPage, pageSize: _pageSize);
      if (newAds.isEmpty || newAds.length < _pageSize) {
        _hasMoreData = false;
      }
      state = AsyncValue.data([...state.value ?? [], ...newAds]);
    } catch (e, s) {
      // 오류 처리: 이전 상태를 유지하거나, 오류 상태를 사용자에게 알릴 수 있음
      _currentPage--; // 페이지 복원
      print('Error fetching more ads: $e');
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> refresh() async {
    _currentPage = 1;
    _hasMoreData = true;
    _isLoadingMore = false;
    await _fetchInitialAds();
  }
}
*/