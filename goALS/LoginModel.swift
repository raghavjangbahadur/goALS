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

class LoginModel: ObservableObject {
    @Published var email: String {
        didSet {
            UserDefaults.standard.set(email, forKey: "username")
        }
    }
    
    @Published var password: String {
        didSet {
            UserDefaults.standard.set(password, forKey: "password")
        }
    }
    
    init() {
        self.email = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        self.password = UserDefaults.standard.object(forKey: "password") as? String ?? ""
    }
    @Published var loading: Bool = false
    @Published var loggedIn: Bool = false

    func loginCall() {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else {
              print("Failed signing in")
              return
          }
          strongSelf.loggedIn = true
        }
    }
}
