import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  static late final String userId;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> initAuth() async {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      final userCredential = await auth.signInAnonymously();
      userId = userCredential.user!.uid;
    } else {
      userId = auth.currentUser!.uid;
    }
  }

  static Future<void> savePrediction({
    required Map<String, dynamic> predictionData,
  }) async {
    await _firestore.collection('predictions').add({
      'userId': userId,
      'timestamp': Timestamp.now(),
      ...predictionData,
    });
  }

  static Stream<QuerySnapshot> getPredictionHistory() {
    return _firestore
        .collection('predictions')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
