

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAdManager {
  late RewardedAd _rewardedAd;
  bool _isAdLoaded = false;

  void loadAd(VoidCallback onAdLoaded) {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-5767874163080300/8844884452',
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          _isAdLoaded = true;
          print('Rewarded Ad loaded.');
          onAdLoaded();
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Failed to load rewarded ad: $error');
        },
      ),
    );
  }

  void showAd(VoidCallback onEarnedReward) {
    if (_isAdLoaded) {
      _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) => print('Ad shown.'),
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          print('Ad dismissed.');
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          print('Ad failed to show: $error');
        },
      );

      _rewardedAd.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('User earned reward: ${reward.amount}');
          onEarnedReward();
        },
      );
    } else {
      print('Ad is not loaded yet.');
    }
  }
}