//
//  HarmonyHubApp.swift
//  HarmonyHub
//
//  Created by Namashi Sivaram on 2023-07-03.
//

import SwiftUI
import FirebaseCore
import Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct HarmonyHubApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
      
    WindowGroup {
        ContentView()
      
    }
  }
}
