//
//  SIGAI_App.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 14/03/2025.
//

import SwiftUI
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth
import FirebaseRemoteConfigInternal
import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct SIGAI_v3App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    init() {
        MobileAds.shared.start(completionHandler: nil)
        // Ensure Firebase is initialized before fetching API key
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            SIGAI_v3App.fetchAPIKey()
        }
    }

    static func authenticateUser(completion: @escaping (Bool) -> Void) {
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error {
                print("❌ Anonymous Authentication failed: \(error.localizedDescription)")
                completion(false)
                return
            }
            print("✅ Anonymous Authentication successful!")
            completion(true)
        }
    }
    
    static func fetchAPIKey() {
        authenticateUser { success in
            guard success else { return }

            let remoteConfig = RemoteConfig.remoteConfig()
            let settings = RemoteConfigSettings()
            settings.minimumFetchInterval = 0 // Fetch instantly for testing
            remoteConfig.configSettings = settings

            remoteConfig.fetchAndActivate { status, error in
                if error != nil {
                    print("❌ Failed to fetch API Key: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                let apiKey = remoteConfig.configValue(forKey: "API_KEY").stringValue
                if apiKey.isEmpty {
                    print("⚠️ API Key is missing in Remote Config.")
                } else {
                    APISecurity.saveAPIKey(apiKey)
                    print("✅ API Key fetched securely from Remote Config: \(apiKey)")
                }
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

