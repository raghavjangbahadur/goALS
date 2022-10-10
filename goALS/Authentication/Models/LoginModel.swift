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
    
    @Published var errorMessage: String = ""
    
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
        email = keychain.value(forKey: "username") as? String ?? ""
        password = keychain.value(forKey: "password") as? String ?? ""
    }
    
    @Published var loading: Bool = false
    @Published var loggedIn: Bool = false
    
    func loginCall() {
        guard !loggedIn else {
            return
        }

        let email = keychain.value(forKey: "username") as? String ?? ""
        let password = keychain.value(forKey: "password") as? String ?? ""
        guard !email.isEmpty || !password.isEmpty else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            guard let _ = authResult else {
                strongSelf.loggedIn = false
                if let error {
                    strongSelf.errorMessage = error.localizedDescription
                }
                return
            }
            strongSelf.errorMessage = ""
            strongSelf.loggedIn = true
        }
    }
    
    func logoutCall() {
        guard loggedIn else {
            return
        }
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            errorMessage = signOutError.localizedDescription
            print("Error signing out: %@", signOutError)
            return
        }
        self.email = ""
        self.password = ""
        self.loggedIn = false
    }

    func createUser() {
        guard !loggedIn else {
            return
        }

        let email = keychain.value(forKey: "username") as? String ?? ""
        let password = keychain.value(forKey: "password") as? String ?? ""
        guard !email.isEmpty || !password.isEmpty else {
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            guard let _ = authResult else {
                strongSelf.loggedIn = false
                if let error {
                    strongSelf.errorMessage = error.localizedDescription
                }
                return
            }
            strongSelf.errorMessage = ""
            strongSelf.loggedIn = true
        }

    }
}
