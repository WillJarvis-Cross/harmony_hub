//
//  HarmonyHubApp.swift
//  HarmonyHub
//
//  Created by Namashi Sivaram on 2023-07-03.
//

import SwiftUI
import FirebaseCore
import Firebase
import CoreLocation
class AppDelegate: NSObject, UIApplicationDelegate, CLLocationManagerDelegate{
    
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
    @StateObject private var firestoreManager = FirestoreManager()
    @StateObject private var locationManager = LocationManager()
  var body: some Scene {
      
    WindowGroup {
        ContentView().environmentObject(locationManager)
      
    }
  }
}
