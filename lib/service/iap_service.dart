import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class IAPService {
  static final InAppPurchase _iap = InAppPurchase.instance;
  static const String subscriptionId = 'premium_monthly';

  static bool isPremium = false;

  static Future<void> init() async {
    await _iap.isAvailable();
    _iap.purchaseStream.listen(_listenToPurchaseUpdated);
    await _checkFirestoreSubscription();
  }

  static Future<ProductDetails?> getSubscriptionProduct() async {
    const Set<String> ids = {subscriptionId};
    final response = await _iap.queryProductDetails(ids);
    if (response.productDetails.isNotEmpty) {
      return response.productDetails.first;
    }
    return null;
  }

  static Future<void> buySubscription(ProductDetails product) async {
    final PurchaseParam param = PurchaseParam(productDetails: product);
    await _iap.buyNonConsumable(purchaseParam: param);
  }

  static void _listenToPurchaseUpdated(List<PurchaseDetails> purchases) {
    for (final purchase in purchases) {
      if (purchase.productID == subscriptionId &&
          purchase.status == PurchaseStatus.purchased) {
        _saveSubscriptionToFirestore();
      }
    }
  }

  static Future<void> _saveSubscriptionToFirestore() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await FirebaseFirestore.instance.collection('subscriptions').doc(userId).set({
        'isPremium': true,
        'updatedAt': Timestamp.now(),
      });
      isPremium = true;
    }
  }

  static Future<void> _checkFirestoreSubscription() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final doc = await FirebaseFirestore.instance.collection('subscriptions').doc(userId).get();
      isPremium = doc.exists && (doc.data()?['isPremium'] ?? false);
    }
  }
}
