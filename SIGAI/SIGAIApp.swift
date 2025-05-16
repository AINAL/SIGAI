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
import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        MobileAds.shared.start(completionHandler: nil)
        return true
    }
}

@main
struct SIGAI_v3App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var appReady = false

    init() {
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
    

    var body: some Scene {
        WindowGroup {
            if appReady {
                ContentView()
            } else {
                Color.clear
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            appReady = true
                        }
                    }
            }
        }
    }
}
