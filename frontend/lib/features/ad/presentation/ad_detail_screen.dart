// lib/features/ad/presentation/ad_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../provider/ad_provider.dart';
import '../domain/ad_model.dart';

class AdDetailScreen extends ConsumerWidget {
  final int adId; // 라우터로부터 전달받을 광고 ID
  static const String routeName = 'detail'; // AdListScreen의 하위 경로로 사용될 이름
                                         // 예: /ads/detail/:adId -> 실제 경로는 router.dart에서 구성

  const AdDetailScreen({super.key, required this.adId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // adDetailProvider에 adId를 전달하여 특정 광고의 상태를 가져옵니다.
    final adDetailAsyncValue = ref.watch(adDetailProvider(adId));

    return Scaffold(
      appBar: AppBar(
        title: adDetailAsyncValue.when(
          data: (ad) => Text(ad.title),
          loading: () => const Text('로딩 중...'),
          error: (_, __) => const Text('광고 정보'),
        ),
      ),
      body: adDetailAsyncValue.when(
        data: (AdModel ad) {
          // 광고 상세 정보를 표시하는 UI 구성
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (ad.thumbnailUrl != null && ad.thumbnailUrl!.isNotEmpty)
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: ad.thumbnailUrl!,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 100),
                      fit: BoxFit.contain, // 이미지가 잘리지 않고 전체가 보이도록
                    ),
                  )
                else if (ad.thumbnailUrl != null && ad.thumbnailUrl!.isNotEmpty)
                  Center( // imageUrl이 없으면 썸네일이라도 보여주기
                    child: CachedNetworkImage(
                      imageUrl: ad.thumbnailUrl!,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 100),
                      fit: BoxFit.contain,
                    ),
                  )
                else
                  const Center(child: Icon(Icons.campaign, size: 100)), // 기본 아이콘

                const SizedBox(height: 20),
                Text(
                  ad.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  '브랜드: ${ad.brandName}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                if (ad.description != null && ad.description!.isNotEmpty)
                  Text(
                    '설명: ${ad.description}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                const SizedBox(height: 8),
                Text(
                  '랜딩 URL: ${ad.landingUrl}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blue),
                  // TODO: onTap: () => _launchURL(ad.landingUrl), // url_launcher 사용하여 URL 열기
                ),
                const SizedBox(height: 8),
                Text('광고 유형: ${ad.adType}'),
                Text('노출 시작일: ${ad.startDate ?? 'N/A'}'), // 날짜 형식화 필요시 intl 패키지 사용
                Text('노출 종료일: ${ad.endDate ?? 'N/A'}'),
                const SizedBox(height: 16),
                // TODO: 기타 필요한 정보 추가 (예: 타겟팅 정보, 통계 등)
                // if (ad.targetGender != null) Text('타겟 성별: ${ad.targetGender}'),
                // if (ad.targetMinAge != null) Text('타겟 최소 연령: ${ad.targetMinAge}'),
                // if (ad.targetMaxAge != null) Text('타겟 최대 연령: ${ad.targetMaxAge}'),

                // 예시: 수정/삭제 버튼 (광고주인 경우 등 특정 조건에서만 보이도록)
                // if (isCurrentUserAdOwner(ad.advertiserId)) // 가상의 함수
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       IconButton(icon: Icon(Icons.edit), onPressed: () { /* 수정 화면으로 이동 */ }),
                //       IconButton(icon: Icon(Icons.delete), onPressed: () { /* 삭제 로직 실행 */ }),
                //     ],
                //   )
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          print('Error loading ad detail for ID $adId: $error');
          print(stackTrace);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('광고 상세 정보를 불러오는 중 오류가 발생했습니다.\nError: ${error.toString()}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref.refresh(adDetailProvider(adId));
                  },
                  child: const Text('다시 시도'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
