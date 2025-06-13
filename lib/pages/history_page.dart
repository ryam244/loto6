import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../service/firestore_service.dart';
import '../widgets/result_card.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("予測履歴")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreService.getPredictionHistory(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("履歴読み込みエラー"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text("履歴がありません"));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final List<dynamic> result = data['result'];
              final timestamp = (data['timestamp'] as Timestamp).toDate();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text("${timestamp.toLocal()}",
                        style: const TextStyle(fontSize: 14, color: Colors.grey)),
                  ),
                  ...result.map((numbers) => ResultCard(List<int>.from(numbers))),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
