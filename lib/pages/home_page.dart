import 'package:flutter/material.dart';
import '../model/prediction_model.dart';
import '../service/api_service.dart';
import '../service/ads_service.dart';
import '../service/firestore_service.dart';
import '../service/iap_service.dart';
import 'result_page.dart';
import 'subscription_page.dart';
import 'history_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double freqWeight = 1.0;
  double sleepWeight = 1.0;
  int outputCount = 5;

  final AdsService adsService = AdsService();

  @override
  void initState() {
    super.initState();
    adsService.loadAd();
  }

  void _executePrediction() async {
    var request = PredictionRequest(
      ngNumbers: [],
      freqWeight: freqWeight,
      sleepWeight: sleepWeight,
      excludeLatest: true,
      outputCount: outputCount,
    );

    var result = await ApiService.fetchPrediction(request);
    
    await FirestoreService.savePrediction(predictionData: {
      'ngNumbers': [],
      'freqWeight': freqWeight,
      'sleepWeight': sleepWeight,
      'excludeLatest': true,
      'outputCount': outputCount,
      'result': result.predictions
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(result.predictions),
      ),
    );
  }

  void _startPrediction() {
    if (IAPService.isPremium) {
      _executePrediction();
    } else {
      if (adsService.isLoaded) {
        adsService.showAd(() {
          _executePrediction();
        });
      } else {
        _executePrediction();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ロト6予測商用版"), actions: [
        IconButton(
          icon: const Icon(Icons.star),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SubscriptionPage())),
        ),
        IconButton(
          icon: const Icon(Icons.history),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryPage())),
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage())),
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text("頻度重み", style: const TextStyle(fontSize: 18)),
            Slider(value: freqWeight, min: 0.1, max: 5, onChanged: (v) => setState(() => freqWeight = v)),
            Text("休眠重み", style: const TextStyle(fontSize: 18)),
            Slider(value: sleepWeight, min: 0.1, max: 5, onChanged: (v) => setState(() => sleepWeight = v)),
            Text("出力セット数", style: const TextStyle(fontSize: 18)),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (v) => setState(() => outputCount = int.tryParse(v) ?? 5),
              decoration: const InputDecoration(hintText: "例: 5"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startPrediction, 
              child: const Text("予測開始")
            ),
          ],
        ),
      ),
    );
  }
}
