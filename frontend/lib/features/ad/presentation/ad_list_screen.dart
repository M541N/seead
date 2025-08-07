import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/ad_provider.dart';

class AdListScreen extends ConsumerWidget {
  const AdListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adList = ref.watch(adListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('광고 목록')),
      body: adList.when(
        data: (ads) => ListView.builder(
          itemCount: ads.length,
          itemBuilder: (context, index) {
            final ad = ads[index];
            return ListTile(
              title: Text(ad.title),
              subtitle: Text(ad.description ?? ''),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }
}
