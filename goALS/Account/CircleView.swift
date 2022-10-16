//
//  CircleView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 10/3/22.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class CircleViewModel: ObservableObject {
    
    @Published var users = [User]()
    @Published var patientName = ""
    
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
                self.patientName = docData!["patientName"] as? String ?? ""
                let key = docData!["patient uuid"] as? String ?? ""
                db.collection("users").whereField("patient uuid", isEqualTo: key)
                  .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        if let querySnapshot = querySnapshot {
                            DispatchQueue.main.async {
                                self.users = querySnapshot.documents.map { d in
                                    return User(id: d.documentID, firstName: d["firstName"] as? String ?? "", lastName: d["lastName"] as? String ?? "", patientID: d["patient uuid"] as? String ?? "", patientName: d["patientName"] as? String ?? "", email: d["email"] as? String ?? "", account: docData!["account"] as? String ?? "")
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
struct CircleView: View {
    
    @ObservedObject var model = CircleViewModel()
    
    var body: some View {
        List{
            Section(model.patientName + "'s Circle") {
                ForEach(model.users) { user in
                    Text(user.firstName + " " + user.lastName)
                }
            }
        }
        .navigationBarTitle("Circle")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarColor(.white)
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView()
    }
}
