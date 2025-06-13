import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsService {
  static const String rewardedAdUnitId = 'ca-app-pub-3940256099942544/5224354917'; // AdMobのテストID

  RewardedAd? _rewardedAd;
  bool isLoaded = false;

  void loadAd() {
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          isLoaded = true;
        },
        onAdFailedToLoad: (error) {
          _rewardedAd = null;
          isLoaded = false;
        },
      ),
    );
  }

  void showAd(Function onRewardEarned) {
    if (_rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          onRewardEarned();
        },
      );
      _rewardedAd = null;
      isLoaded = false;
      loadAd();
    }
  }
}
