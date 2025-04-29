//
//  ads.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 22/04/2025.
//

import SwiftUI
import GoogleMobileAds


struct BannerAdView: UIViewRepresentable {
    let adUnitID: String
    
    func makeUIView(context: Context) -> BannerView {
        let banner = BannerView(adSize: AdSizeBanner)
        banner.adUnitID = adUnitID
        banner.rootViewController = UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow?.rootViewController }
            .first
        banner.load(Request())
        return banner
    }
    
    func updateUIView(_ uiView: BannerView, context: Context) {}
}

class RewardedAdManager: NSObject, FullScreenContentDelegate, ObservableObject {
    @Published var adDidReward: Bool = false
    private var rewardedAd: RewardedAd?

    var isAdReady: Bool {
        return rewardedAd != nil
    }
    
    func loadAd(adUnitID: String) {
        let request = Request()
        RewardedAd.load(with: adUnitID, request: request) { ad, error in
            if let error = error {
                print("Failed to load rewarded ad: \(error.localizedDescription)")
                return
            }
            self.rewardedAd = ad
            self.rewardedAd?.fullScreenContentDelegate = self
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
