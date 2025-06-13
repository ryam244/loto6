import 'package:flutter/material.dart';
import '../service/iap_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("設定")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("アプリ情報"),
              subtitle: Text("ロト6予測商用版 v1.0"),
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text("プレミアム会員状態"),
              subtitle: Text(IAPService.isPremium ? "プレミアム利用中" : "無料プラン利用中"),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Text("※ 今後ここに NG数字登録、通知設定、アカウント連携など追加可能"),
          ],
        ),
      ),
    );
  }
}
