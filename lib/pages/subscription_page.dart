import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../service/iap_service.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  ProductDetails? _product;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    final product = await IAPService.getSubscriptionProduct();
    setState(() {
      _product = product;
      _loading = false;
    });
  }

  void _purchase() async {
    if (_product != null) {
      await IAPService.buySubscription(_product!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("購入処理を完了しました")),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_product == null) {
      return const Scaffold(body: Center(child: Text("プランが見つかりません")));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("プレミアム登録")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Text("プレミアム会員", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text("・広告なしで予測可能\n・高精度AI予測（将来機能）\n・履歴保存無制限", textAlign: TextAlign.center),
            const SizedBox(height: 40),
            Text("${_product!.price}/月", style: const TextStyle(fontSize: 26, color: Colors.blue)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _purchase,
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16)),
              child: const Text("登録する", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
