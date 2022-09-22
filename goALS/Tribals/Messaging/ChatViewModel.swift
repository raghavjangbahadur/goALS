import Foundation
import Foundation
import Firebase
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class ChatViewModel: ObservableObject {
    @Published var text = ""
    @Published var count = 0
    @Published var messages = [Message]()
    @Published var userFirstName = ""
    var messageIds:Set<String> = Set<String>()

    let user: User?
    init(user: User?) {
        self.user = user
        guard let userID = Auth.auth().currentUser?.uid else {
            print("could not find user id")
            return
        }
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(userID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                self.userFirstName = docData!["firstName"] as? String ?? ""
            }
        }
        fetchChat()
    }
    
    func send() {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            print("could not find user id")
            return
        }
        guard let toId = user?.id, !toId.isEmpty else {
            print("toId is empty")
            return
        }
        let docRef = db.collection("messages").document(userID).collection(toId).document()
        let message = ["fromId" : userID, "toId" : toId, "text" : self.text, "timestamp" : Timestamp()] as [String : Any]
        docRef.setData(message) { error in
            if let error = error {
                print(error)
                return
            }
            
            self.persistRecentMessage()
            
            self.text = ""
            self.count += 1
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
        guard let toId = user?.id, !toId.isEmpty else {
            print("toId is empty")
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
                    let documentID = change.document.documentID
                    if !self.messageIds.contains(documentID) {
                        self.messageIds.insert(documentID)
                        self.messages.append(.init(documentId: documentID, data: data))
                    }
                }
            })

            DispatchQueue.main.async {
                self.count += 1
            }
        }
    }
    
    func persistRecentMessage() {
        guard let user = user else { return }
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            print("could not find user id")
            return
        }
        /*let docRef = db.collection("users").document(userID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                userFirstName = docData!["firstName"] as? String ?? ""
            }
        }*/
        let toId = user.id
        let docRef3 = db.collection("recent_messages").document(userID).collection("messages").document(toId)
        let docRef2 = db.collection("recent_messages").document(toId).collection("messages").document(userID)
        let data = [
            "timestamp": NSDate(),
            "text": self.text,
            "fromId": userID,
            "toId" : toId,
            "firstName" : user.firstName
        ] as [String : Any]
        
        let data2 = [
            "timestamp": NSDate(),
            "text": self.text,
            "fromId": toId,
            "toId" : userID,
            "firstName" : userFirstName
        ] as [String : Any]
        docRef2.setData(data2) { error in
            if let error = error {
                print(error)
                return
            }
        }
        docRef3.setData(data) { error in
            if let error = error {
                print(error)
                return
            }
        }
    }
}