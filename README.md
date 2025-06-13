# ロト6予測商用版 Flutterプロジェクト

---

## ✅ 概要

- ロト6予測アプリ完全版（商用化可能設計）
- Flutter 3.x 対応
- Firestore（匿名認証＋履歴保存）
- AdMob（リワード広告）
- In-App Purchase（サブスクリプション）
- FastAPI連携（AI予測API）

---

## ✅ 開発環境

- Flutter SDK 3.x
- Dart SDK
- Firebase プロジェクト
- Google AdMob アカウント
- Google Play Console / App Store Connect

---

## ✅ セットアップ手順

### ① Flutter 環境構築

- Flutter SDK導入
- `flutter --version` で正常確認

### ② Firebase連携

- Firebaseプロジェクト作成
- 匿名認証を有効化
- Firestoreを有効化

#### Android
- `google-services.json` を `/android/app/` に配置

#### iOS
- `GoogleService-Info.plist` を `/ios/Runner/` に配置

### ③ AdMob設定

- AdMobアカウント作成
- リワード広告ユニットID発行
- `ads_service.dart` 内の `rewardedAdUnitId` に反映

### ④ In-App Purchase設定

- Google Play Console / App Store Connect で商品登録
- 商品ID: `premium_monthly` を使用
- `iap_service.dart` に既定で組み込み済

### ⑤ FastAPI API連携

- あなたのAPIサーバーURLを `app_constants.dart` に反映

```dart
static const String apiUrl = 'https://your-api-server.com/predict';
