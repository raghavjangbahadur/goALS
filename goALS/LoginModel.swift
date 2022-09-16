//
//  LoginModel.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/28/22.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Combine
import Keychain

class LoginModel: ObservableObject {
    private let keychain = Keychain()

    @Published var email: String {
        didSet {
            let _ = keychain.save(email, forKey: "username")
        }
    }
    
    @Published var password: String {
        didSet {
            let _ = keychain.save(password, forKey: "password")
        }
    }
    
    init() {
        self.email = keychain.value(forKey: "username") as? String ?? ""
        self.password = keychain.value(forKey: "password") as? String ?? ""
    }
    @Published var loading: Bool = false
    @Published var loggedIn: Bool = false

    func loginCall() {
        guard !self.email.isEmpty || !self.password.isEmpty else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else {
              print("Failed signing in")
              return
          }
          strongSelf.loggedIn = true
        }
    }
    
    func logoutCall() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            return
        }
        self.loggedIn = false
        self.email = ""
        self.password = ""
    }
}
