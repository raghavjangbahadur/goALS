//
//  MainMessagesModel.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/23/22.
//

import Foundation
import Foundation
import Firebase
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class MainMessagesViewModel: ObservableObject {
    
    @Published var user = User(id: "", firstName: "", lastName: "",  patientID: "", patientName: "", email: "")
    
    init() {
        fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        let docRef = db.collection("users").document(userID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                self.user = User(id: userID, firstName: docData!["firstName"] as? String ?? "",
                                 lastName: docData!["lastName"] as? String ?? "",
                                 patientID: docData!["patient uuid"] as? String ?? "",
                                 patientName: docData!["patientName"] as? String ?? "",
                                 email: docData!["email"] as? String ?? "")
            } else {
                print("Document does not exist here")
            }
        }
    }
}
