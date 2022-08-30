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
   // @Published var user = User(id: "", firstName: "", lastName: "",  patientID: "", patientName: "", email: "")
    /*var user: User?
    init(user: User?) {
        self.user = user
        fetchChat()
    }
    */
    
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
                let docRef2 = db.collection("groupMessages").document(patientId).collection(patientId).document()
                let groupMessage = ["fromId" : userID, "text" : self.text, "timestamp" : Timestamp()] as [String : Any]
                docRef2.setData(groupMessage) { error in
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    //self.persistRecentMessage()
                    
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
                db.collection("groupMessages").document(patientId).collection(patientId).order(by: "timestamp").addSnapshotListener { querySnapshot, error in
                    if let error = error {
                        print(error)
                        return
                    }
                    querySnapshot?.documentChanges.forEach({ change in
                        if change.type == .added {
                            let data = change.document.data()
                            self.messages.append(.init(documentId: change.document.documentID, data: data))
                        }
                    })
                    
                    DispatchQueue.main.async {
                        self.count += 1
                    }
                }
                
            } else {
                print("Document does not exist here")
            }
        }
        
    }
    /*
    func persistRecentMessage() {
        guard let user = user else { return }
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            print("could not find user id")
            return
        }
        let toId = user.id
        let docRef = db.collection("recent_messages").document(userID).collection("messages").document(toId)
        
        let data = [
            "timestamp": Timestamp(),
            "text": self.text,
            "fromId": userID,
            "toId" : toId,
            "firstName" : user.firstName
        ] as [String : Any]
        
        docRef.setData(data) { error in
            if let error = error {
                print(error)
                return
            }
        }
    }
    */
}
