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

    enum AuthenticationStatus {
        case authenticated
        case unauthenticated
        case inProgress
    }
    
    @Published var email: String
    @Published var password: String
    @Published var errorMessage: String = ""
    @Published var authStatus: AuthenticationStatus = .inProgress

    init() {
        email = keychain.value(forKey: "username") as? String ?? ""
        password = keychain.value(forKey: "password") as? String ?? ""
        if email.isEmpty || password.isEmpty {
            authStatus = .unauthenticated
        }
    }
    
    @Published var loading: Bool = false
    @Published var loggedIn: Bool = false
    
    func loginCall() {
        guard !email.isEmpty || !password.isEmpty else {
            return
        }
        authStatus = .inProgress
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            guard let _ = authResult else {
                strongSelf.loggedIn = false
                strongSelf.authStatus = .unauthenticated
                if let error {
                    strongSelf.errorMessage = error.localizedDescription
                }
                return
            }
            strongSelf.errorMessage = ""
            strongSelf.loggedIn = true
            strongSelf.authStatus = .authenticated
            strongSelf.saveCredentials()
        }
    }
    
    func logoutCall() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            errorMessage = signOutError.localizedDescription
            print("Error signing out: %@", signOutError)
            return
        }
        email = ""
        password = ""
        loggedIn = false
        authStatus = .unauthenticated
        clearCredentials()
    }

    func createUser() {
        guard !email.isEmpty || !password.isEmpty else {
            return
        }

        authStatus = .inProgress
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
            strongSelf.authStatus = .authenticated
            strongSelf.saveCredentials()
        }
    }

    func saveCredentials() {
        let _ = keychain.save(email, forKey: "username")
        let _ = keychain.save(password, forKey: "password")
    }

    func clearCredentials() {
        let _ = keychain.save("", forKey: "username")
        let _ = keychain.save("", forKey: "password")
    }
}
