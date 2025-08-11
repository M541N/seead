// lib/features/ad/presentation/ad_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart'; // GoRouter import 추가

import '../provider/ad_provider.dart';
import '../domain/ad_model.dart';
import 'ad_detail_screen.dart'; // AdDetailScreen import (라우트 이름 사용 목적)

class AdListScreen extends ConsumerWidget {
  static const String routeName = '/ads'; // 라우트 이름 정의

  const AdListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adsAsyncValue = ref.watch(adsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('광고 목록'),
      ),
      body: adsAsyncValue.when(
        data: (ads) {
          if (ads.isEmpty) {
            return const Center(
              child: Text('표시할 광고가 없습니다.'),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              ref.refresh(adsProvider);
            },
            child: ListView.builder(
              itemCount: ads.length,
              itemBuilder: (context, index) {
                final AdModel ad = ads[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    leading: ad.thumbnailUrl != null && ad.thumbnailUrl!.isNotEmpty
                        ? SizedBox(
                            width: 80,
                            height: 80,
                            child: CachedNetworkImage(
                              imageUrl: ad.thumbnailUrl!,
                              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 40),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const SizedBox(
                            width: 80,
                            height: 80,
                            child: Icon(Icons.campaign, size: 40),
                          ),
                    title: Text(ad.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(ad.brandName),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // GoRouter를 사용하여 AdDetailScreen으로 이동
                      context.push('${AdListScreen.routeName}/${AdDetailScreen.routeName}/${ad.id}');
                    },
                  ),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          print('Error loading ads: $error');
          print(stackTrace);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('광고를 불러오는 중 오류가 발생했습니다.\nError: ${error.toString()}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref.refresh(adsProvider);
                  },
                  child: const Text('다시 시도'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
