//
//  GroupChatModel.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/29/22.
//

import Foundation
import Firebase
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class GroupChatModel: ObservableObject {
    @Published var text = ""
    @Published var count = 0
    @Published var messages = [GroupMessage]()
    @Published var patientName = ""
    var messageIDs = Set<String>()

    func send() {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            print("could not find user id")
            return
        }
        let docRef = db.collection("users").document(userID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                let patientId = docData!["patient uuid"] as? String ?? ""
                let firstName = docData!["firstName"] as? String ?? ""
                let lastName = docData!["lastName"] as? String ?? ""
                let docRef2 = db.collection("groupMessages").document(patientId).collection(patientId).document()
                let groupMessage = ["firstName" : firstName, "lastName" : lastName, "fromId" : userID, "text" : self.text, "timestamp" : Timestamp()] as [String : Any]
                docRef2.setData(groupMessage) { error in
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    self.text = ""
                    self.count += 1
                }
                
            } else {
                print("Document does not exist here")
            }
        }
    }
    
    func fetchChat() {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            print("could not find user id")
            return
        }
        let docRef = db.collection("users").document(userID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                let patientId = docData!["patient uuid"] as? String ?? ""
                self.patientName = docData!["patientName"] as? String ?? ""
                db.collection("groupMessages").document(patientId).collection(patientId).order(by: "timestamp").addSnapshotListener { querySnapshot, error in
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    var messages = self.messages
                    querySnapshot?.documentChanges.forEach({ change in
                        if change.type == .added {
                            let document = change.document
                            let documentID = document.documentID
                            guard !self.messageIDs.contains(documentID) else {
                                return
                            }
                            let data = document.data()
                            self.messageIDs.insert(documentID)
                            let stamp = data["timestamp"] as? Timestamp ?? Timestamp()
                            messages.append(.init(documentId: documentID, data: document.data(), stamp: stamp))
                        }
                    })
                    
                    self.messages = messages
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.count = messages.count
                    }
                }
                
            } else {
                print("Document does not exist here")
            }
        }
        
    }
}
