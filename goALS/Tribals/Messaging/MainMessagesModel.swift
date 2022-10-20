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
    
    @Published var user = User(id: "", firstName: "", lastName: "",  patientID: "", patientName: "", email: "", account: "")
    @Published var toUser = User(id: "", firstName: "", lastName: "", patientID : "", patientName: "", email: "", account: "")
    
    init() {
        fetchCurrentUser()
        
        fetchRecentMessages()
    }
    
    @Published var recentMessages = [RecentMessage]()
    
    func fetchRecentMessages() {
        self.recentMessages.removeAll()
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        db.collection("recent_messages").document(userID).collection("messages").order(by: "timestamp").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print(error)
                return
            }
            querySnapshot?.documentChanges.forEach({ change in
                let docId = change.document.documentID
                if let index = self.recentMessages.firstIndex(where: { rm in
                    return rm.documentId == docId
                }) {
                    self.recentMessages.remove(at: index)
                }
                
                self.recentMessages.insert(.init(documentId: docId, data: change.document.data()), at: 0)
            })
        }
    }
    struct RecentMessage: Identifiable {
        var id: String { documentId }
        let documentId: String
        let text, fromId, toId, firstName, lastName: String
        let timestamp: Date
        //var timeAgo: String
        
        init(documentId: String, data: [String: Any]) {
            self.documentId = documentId
            self.fromId = data["fromId"] as? String ?? ""
            self.toId = data["toId"] as? String ?? ""
            self.text = data["text"] as? String ?? ""
            self.firstName = data["firstName"] as? String ?? ""
            self.lastName = data["lastName"] as? String ?? ""
            self.timestamp = (data["timestamp"] as? Timestamp)?.dateValue() ?? Date()
        }
        
        var timeAgo: String {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .abbreviated
            return formatter.localizedString(for: timestamp, relativeTo: Date())
        }
    }
    
    func fetchUser(msg: RecentMessage, completion:@escaping (User?)-> Void) {
        let db = Firestore.firestore()
        if msg.fromId != Auth.auth().currentUser?.uid {
            let docRef = db.collection("users").document(msg.fromId)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let docData = document.data()
                    completion(User(id: msg.fromId, firstName: docData!["firstName"] as? String ?? "",
                                    lastName: docData!["lastName"] as? String ?? "",
                                    patientID: docData!["patient uuid"] as? String ?? "",
                                    patientName: docData!["patientName"] as? String ?? "",
                                    email: docData!["email"] as? String ?? "",
                                    account: docData!["account"] as? String ?? ""))
                } else {
                    print("Document does not exist here")
                    completion(nil)
                }
            }
        }
        else {
            let docRef = db.collection("users").document(msg.toId)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let docData = document.data()
                    completion((User(id: msg.toId, firstName: docData!["firstName"] as? String ?? "",
                                     lastName: docData!["lastName"] as? String ?? "",
                                     patientID: docData!["patient uuid"] as? String ?? "",
                                     patientName: docData!["patientName"] as? String ?? "",
                                     email: docData!["email"] as? String ?? "",
                                     account: docData!["account"] as? String ?? "")))
                } else {
                    print("Document does not exist here")
                    completion(nil)
                }
            }
        }
        
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
                                 email: docData!["email"] as? String ?? "",
                                 account: docData!["account"] as? String ?? "")
            } else {
                print("Document does not exist here")
            }
        }
    }
}
