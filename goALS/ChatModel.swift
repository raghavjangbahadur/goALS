//
//  ChatModel.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/22/22.
//
import Foundation
import Foundation
import Firebase
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class ChatModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        fetchUsers()
    }
    
    
    func fetchUsers() {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            print("could not find user id")
            return
        }
        let docRef = db.collection("users").document(userID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                let key = docData!["patient uuid"] as? String ?? ""
                db.collection("users").whereField("patient uuid", isEqualTo: key)
                  .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        if let querySnapshot = querySnapshot {
                            DispatchQueue.main.async {
                                self.users = querySnapshot.documents.map { d in
                                    return User(id: d.documentID, firstName: d["firstName"] as? String ?? "", lastName: d["lastName"] as? String ?? "", patientID: d["patient uuid"] as? String ?? "", patientName: d["patientName"] as? String ?? "", email: d["email"] as? String ?? "")
                                }
                            }
                        }
                        else {
                            print("No document")
                        }
                    }
                }
                
            } else {
                print("Document does not exist")
            }
        }
    }
}
