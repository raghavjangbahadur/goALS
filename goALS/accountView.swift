//
//  accountView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/15/22.
//

import Foundation
import Firebase
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class accountViewModel: ObservableObject {
    @Published var primary = false
    
    init() {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        let docRef = db.collection("users").document(userID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                let type = docData!["account"] as? String ?? ""
                if type == "primary" {
                    self.primary = true
                }
            } else {
                print("Document does not exist")
            }
        }
    }
}

struct accountView: View {
    
    @ObservedObject var model = accountViewModel()
    
    var body: some View {
        VStack {
            Text("Account Settings")
            List {
                NavigationLink {
                    ResetPasswordView()
                } label: {
                    HStack {
                        Text("Reset password")
                        Spacer()
                    }
                }
                if(model.primary) {
                    NavigationLink {
                        AddNewUserView()
                    } label: {
                        HStack {
                            Text("Add User to Circle")
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

struct accountView_Previews: PreviewProvider {
    static var previews: some View {
        accountView()
    }
}
