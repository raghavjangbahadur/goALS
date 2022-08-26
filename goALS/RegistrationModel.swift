//
//  RegistrationModel.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/25/22.
//
import Foundation
import Firebase
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
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var patientGender: String = ""
    @Published var patientAge: Int = 0
    @Published var stage: String = ""
    @Published var feedingTube: String = ""
    @Published var hands: String = ""
    @Published var speech: String = ""
    @Published var muscles: String = ""
    @Published var walking: String = ""
    @Published var legs: String = ""
    @Published var breathing: String = ""
    @Published var generatedId: String = ""
    
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
            db.collection("users").document(userID).setData(["patient uuid" : patientId, "patientName" : self.patientName, "firstName" : self.firstName, "lastName" : self.lastName, "email" : self.email])
            self.createPatient(patientId, self.patientName)
            self.registered = true
            createPatient(patientId, self.patientName)
        }
    }
    
    func registerSecondary() {
        let db = Firestore.firestore()
        if (generatedId == "" || patientName == ""){
            return
        }
        let docRef = db.collection("patients").document(generatedId)
        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                let name = docData!["patientName"] as? String ?? ""
                if name != self.patientName {
                    return
                }
                Auth.auth().createUser(withEmail: self.email, password: self.password) { [self] authResult, error in
                    guard let _ = authResult else {
                        print("Failed registering")
                        return
                    }
                    let db = Firestore.firestore()
                    guard let userID = Auth.auth().currentUser?.uid else {
                        return
                    }
                    let patientId = UUID().uuidString
                    db.collection("users").document(userID).setData(["patient uuid" : patientId, "patientName" : self.patientName, "firstName" : self.firstName, "lastName" : self.lastName, "email" : self.email])
                    self.registered = true
                }
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func createPatient(_ id : String, _ name : String) {
        let dbs = Firestore.firestore()
        dbs.collection("patients").document(id).setData(["patientName" : name, "patient uuid" : id, "patientGender" : self.patientGender, "patientAge" : self.patientAge, "stage" : self.stage, "feedingTube" : self.feedingTube, "hands" : self.hands, "speech" : self.speech, "muscles" : self.muscles, "walking" : self.walking, "legs" : self.legs, "breathing" : self.breathing])
    }
}
