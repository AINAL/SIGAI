//
//  adsBanner.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 18/05/2025.
//

import SwiftUI
import GoogleMobileAds

struct BannerAdView: UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func makeUIView(context: Context) -> BannerView {
        let banner = BannerView(adSize: AdSizeBanner)
        context.coordinator.banner = banner
        banner.adUnitID = "ca-app-pub-5767874163080300/8639376065"
        banner.rootViewController = UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow?.rootViewController }
            .first
        let request = Request()
        banner.load(request)
        banner.delegate = context.coordinator
        return banner
    }
    
    func updateUIView(_ uiView: BannerView, context: Context) {}

    class Coordinator: NSObject, BannerViewDelegate {
        weak var banner: BannerView?

        func bannerViewDidReceiveAd(_ bannerView: BannerView) {
            print("✅ Banner ad loaded successfully.")
        }
        
        func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
            print("❌ Failed to load banner ad: \(error.localizedDescription)")
            // fallback to test ad
            bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            bannerView.load(Request())
        }
    }
}
