//
//  ads.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 22/04/2025.
//

import SwiftUI
import GoogleMobileAds

//extension ContentView {
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
//}
