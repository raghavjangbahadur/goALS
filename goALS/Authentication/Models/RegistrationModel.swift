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
import Combine

class RegistrationModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var account: String = ""
    @Published var loading: Bool = false
    @Published var registered: Bool = false
    @Published var loggedIn: Bool = false
    @Published var patientName: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var generatedId: String = ""
    @Published var errorMessage = ""
    /// login model
    let loginModel: LoginModel
    /// primary registration
    var primaryCancellable:AnyCancellable? = nil
    /// secondary registration
    var secondaryCancellable:AnyCancellable? = nil
    /// error
    var errorCancellable:AnyCancellable? = nil

    init(loginModel: LoginModel) {
        self.loginModel = loginModel
    }

    private func startObservingError() {
        errorCancellable = loginModel.$errorMessage.sink {errorMessage in
            if errorMessage != self.errorMessage {
                self.errorMessage = errorMessage
            }
        }
    }

    func registerPrimary() {
        /// cancel
        cancel()
        /// set email and password
        loginModel.email = email
        loginModel.password = password
        /// listen to object will change
        primaryCancellable = loginModel.$loggedIn.sink {loggedIn in
            let db = Firestore.firestore()
            guard let userID = Auth.auth().currentUser?.uid, loggedIn else {
                return
            }

            let patientId = UUID().uuidString
            db.collection("users")
                .document(userID)
                .setData(["patient uuid" : patientId,
                          "patientName" : self.patientName,
                          "firstName" : self.firstName,
                          "lastName" : self.lastName,
                          "email" : self.email,
                          "account" : "primary"])
            self.createPatient(patientId, self.patientName)
            self.errorMessage = ""
            self.registered = true
        }
        startObservingError()
        loginModel.createUser()
    }
    
    func registerSecondary() {
        let db = Firestore.firestore()
        guard !generatedId.isEmpty && !patientName.isEmpty else {
            return
        }
        /// cancel
        cancel()
        let docRef = db.collection("patients").document(generatedId)
        docRef.getDocument { (document, error) in
            guard let document = document, document.exists, let docData = document.data() else {
                self.errorMessage = "ID does not exist in record"
                return
            }

            let name = docData["patientName"] as? String ?? ""
            if name != self.patientName {
                self.errorMessage = "ID does not match patient name"
                return
            }
            /// set email and password
            self.loginModel.email = self.email
            self.loginModel.password = self.password
            /// listen to object will change
            self.secondaryCancellable = self.loginModel.$loggedIn.sink {loggedIn in
                guard let userID = Auth.auth().currentUser?.uid, loggedIn else {
                    return
                }
                db.collection("users")
                    .document(userID)
                    .setData(["patient uuid" : self.generatedId,
                              "patientName" : self.patientName,
                              "firstName" : self.firstName,
                              "lastName" : self.lastName,
                              "email" : self.email,
                              "account" : "secondary"])
                self.errorMessage = ""
                self.registered = true
            }
            self.startObservingError()
            self.loginModel.createUser()
        }
    }
    
    func createPatient(_ id : String, _ name : String) {
        let dbs = Firestore.firestore()
        dbs.collection("patients")
            .document(id)
            .setData(["patientName" : name,
                      "patient uuid" : id,
                      "patientGender" : "Other",
                      "patientAge" : 0,
                      "stage" : "Early",
                      "feedingTube" : "Low",
                      "hands" : "Low",
                      "speech" : "Low",
                      "muscles" : "Low",
                      "walking" : "Low",
                      "legs" : "Low",
                      "breathing" : "Low"])
    }

    func cancel() {
        primaryCancellable?.cancel()
        secondaryCancellable?.cancel()
        errorCancellable?.cancel()
    }
}
