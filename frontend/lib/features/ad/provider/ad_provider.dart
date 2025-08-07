import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/ad_repository.dart';
import '../../../generated/api_generated/SeeAD_API.swagger.dart';

final adListProvider = FutureProvider<List<Ad>>((ref) async {
  final adRepository = ref.watch(adRepositoryProvider);
  return adRepository.getAds();
});
