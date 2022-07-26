//
//  RegistrationModel.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/25/22.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class RegistrationModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var loading: Bool = false
    @Published var login: Bool = false
    
    func registerCall() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
          
        }
    }
}
