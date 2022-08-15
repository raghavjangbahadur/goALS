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
    @Published var patientGender: String = ""
    @Published var patientAge: Int = 0
    @Published var stage: String = ""
    
    func registerCall() {
        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            guard let _ = authResult else {
                print("Failed registering")
                return
            }
            let db = Firestore.firestore()
            guard let userID = Auth.auth().currentUser?.uid else {
                return
            }
            let patientId = UUID().uuidString
            db.collection("users").document(userID).setData(["patient uuid" : patientId, "patientName" : self.patientName, "name" : self.name], merge: true)
            self.createPatient(patientId, self.patientName)
            self.registered = true
            createPatient(patientId, self.patientName)
        }
    }
    
    func createPatient(_ id : String, _ name : String) {
        let dbs = Firestore.firestore()
        dbs.collection("patients").document(id).setData(["patientName" : name, "patient uuid" : id, "patientGender" : self.patientGender, "patientAge" : self.patientAge, "stage" : self.stage])
        
    }
}
