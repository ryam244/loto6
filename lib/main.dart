import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'pages/home_page.dart';
import 'service/firestore_service.dart';
import 'service/ads_service.dart';
import 'service/iap_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirestoreService.initAuth(); // 匿名ログイン
  MobileAds.instance.initialize();
  await IAPService.init(); // 課金初期化

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ロト6予測',
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}
