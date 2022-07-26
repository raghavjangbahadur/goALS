//
//  goALSApp.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 6/28/22.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    let email = "gyanendrasnh@gmail.com"
    let password = "Cymbalrush@123"
    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        guard let authResult = authResult else {
            print("Failed registering")
            return
        }

        print(authResult)
    }
    return true
    }
}

@main
struct goALSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
