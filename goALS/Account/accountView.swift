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
}

struct accountView: View {
    @ObservedObject var model = accountViewModel()
    @State var shouldShowMenuOptions = false
    @State var optionsMenu = ""
    @EnvironmentObject var loginModel: LoginModel
    
    var body: some View {
        VStack{
            List {
                Section("Circle") {
                    NavigationLink {
                        CircleView()
                    } label: {
                        Text("Patient Circle")
                    }
                    if(model.primary) {
                        NavigationLink {
                            AddNewUserView()
                        } label: {
                            Text("Add User to Circle")
                        }
                    }
                }
                Section("Account") {
                    NavigationLink {
                        ResetPasswordView()
                    } label: {
                        Text("Reset password")
                    }
                    Button {
                        optionsMenu = "sign"
                        shouldShowMenuOptions.toggle()
                    } label: {
                        Text("Sign out")
                            .foregroundColor(.red)
                    }
                    Button {
                        optionsMenu = "delete"
                        shouldShowMenuOptions.toggle()
                    } label: {
                        Text("Delete account")
                            .foregroundColor(.red)
                    }
                }
            }
            Spacer()
            /*NavigationLink("", isActive: self.$loginModel.loggedIn.not) {
                LoginView(model: loginModel)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
            }
            .hidden()*/
        }.actionSheet(isPresented: $shouldShowMenuOptions) {
            if(optionsMenu=="sign") {
                return ActionSheet(title: Text("Sign out"), message: Text("Are you sure you want to sign out?"), buttons: [
                    .destructive(Text("Sign out"), action: {
                        loginModel.logoutCall()
                    }),
                    .cancel()
                ])
            }
            else {
                return ActionSheet(title: Text("Delete Account"), message: Text("Are you sure you want to delete your account?"), buttons: [
                    .destructive(Text("Delete"), action: {
                        loginModel.deleteCall()
                    }),
                    .cancel()
                ])
            }
        }
        .navigationBarTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarColor(.white)
        .background(Color("ListBG"))
    }
}

struct accountView_Previews: PreviewProvider {
    static var previews: some View {
        accountView()
    }
}
