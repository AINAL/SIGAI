//
//  ads.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 22/04/2025.
//

import SwiftUI
import GoogleMobileAds

class RewardedAdManager: NSObject, FullScreenContentDelegate, ObservableObject {
    @Published var adDidReward: Bool = false
    private var rewardedAd: RewardedAd?

    var isAdReady: Bool {
        return rewardedAd != nil
    }
    
    func loadAd() {
        #if DEBUG
        let adUnitID = "ca-app-pub-3940256099942544/1712485313"
        #else
        let adUnitID = "ca-app-pub-5767874163080300/4775134744"
        #endif
        let request = Request()
        RewardedAd.load(with: adUnitID, request: request) { ad, error in
            if let error = error {
                print("❌ Failed to load rewarded ad: \(error.localizedDescription)")
                return
            }
            self.rewardedAd = ad
            self.rewardedAd?.fullScreenContentDelegate = self
            print("✅ Rewarded ad loaded.")
        }
    }

    func showAd(from rootViewController: UIViewController) {
        guard let ad = rewardedAd else {
            print("❌ Ad not ready. Please try again later.")
            return
        }
        ad.present(from: rootViewController) {
            let reward = ad.adReward
            print("✅ Ad watched. You are rewarded with: \(reward.amount)")
            self.adDidReward = true
        }
    }

    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("Rewarded ad dismissed")
        self.rewardedAd = nil
    }
}
