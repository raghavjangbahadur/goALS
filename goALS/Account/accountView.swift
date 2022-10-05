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
    @Published var signedOut = false
    
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
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            signedOut = false
            return
        }
        signedOut = true
    }
}

struct accountView: View {
    
    @ObservedObject var model = accountViewModel()
    @ObservedObject var loginModel = LoginModel()
    @State var shouldShowLogOutOptions = false
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    
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
                NavigationLink {
                    CircleView()
                } label: {
                    HStack {
                        Text("Patient Circle")
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
                Button {
                    shouldShowLogOutOptions.toggle()
                } label: {
                    HStack {
                        Text("Sign out")
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
                
            }
            NavigationLink("", isActive: $model.signedOut) {
                LoginView(model: LoginModel())
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
            }
        }.actionSheet(isPresented: $shouldShowLogOutOptions) {
            .init(title: Text("Sign out"), message: Text("Are you sure you want to sign out?"), buttons: [
                .destructive(Text("Sign out"), action: {
                    loginModel.logoutCall()
                    self.rootPresentationMode.wrappedValue.dismiss()
                }),
                .cancel()
            ])
        }
    }
}

struct accountView_Previews: PreviewProvider {
    static var previews: some View {
        accountView()
    }
}
