import 'package:flutter/material.dart';
import '../widgets/result_card.dart';

class ResultPage extends StatelessWidget {
  final List<List<int>> predictions;

  const ResultPage(this.predictions, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("予測結果")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: predictions.length,
          itemBuilder: (context, index) {
            return ResultCard(predictions[index]);
          },
        ),
      ),
    );
  }
}
