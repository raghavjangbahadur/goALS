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
    @Published var text = ""
    @Published var messages = [Message]()
    
    let toUser: User?
    
    init(toUser: User?) {
        self.toUser = toUser
        fetchChat()
    }
    
    func send() {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            print("could not find user id")
            return
        }
        guard let toId = toUser?.uuid else {
            print("could not find recipient id")
            return
        }
        let docRef = db.collection("messages").document(userID).collection(toId).document()
        let message = ["fromId" : userID, "toId" : toId, "text" : self.text, "timestamp" : Timestamp()] as [String : Any]
        docRef.setData(message) { error in
            if let error = error {
                print(error)
                return
            }
            self.text = ""
        }
        let docRefRec = db.collection("messages").document(toId).collection(userID).document()
        docRefRec.setData(message) { error in
            if let error = error {
                print(error)
                return
            }
        }
    }
    
    func fetchChat() {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            print("could not find user id")
            return
        }
        guard let toId = toUser?.uuid else {
            print("could not find recipient id")
            return
        }
        db.collection("messages").document(userID).collection(toId).order(by: "timestamp").addSnapshotListener { querySnapshot, error in
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
        }
    }
}
