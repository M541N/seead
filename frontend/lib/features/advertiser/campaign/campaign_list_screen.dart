import 'package:flutter/material.dart';

class CampaignListScreen extends StatelessWidget {
  const CampaignListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('캠페인 관리')),
      body: ListView.builder(
        itemCount: 5, // 더미 데이터
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('캠페인 $index'),
            subtitle: const Text('예산: 5000 Seed / 상태: 운영중'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {},
          );
        },
      ),
    );
  }
}