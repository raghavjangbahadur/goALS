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
    @Published var registered: Bool = false
    @Published var loggedIn: Bool = false
    @Published var patientName: String = ""
    @Published var name: String = ""
    
    func registerCall() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let _ = authResult else {
                print("Failed registering")
                return
            }
            let db = Firestore.firestore()
            guard let userID = Auth.auth().currentUser?.uid else {
                return
            }
            db.collection("users").document(userID).setData(["patientName" : self.patientName, "name" : self.name], merge: true)
            self.registered = true
        }
    }
}
