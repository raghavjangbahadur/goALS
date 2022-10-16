//
//  ResetPasswordView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 9/13/22.
//

import Foundation
import Firebase
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class ResetPasswordModel: ObservableObject {
    @Published var email: String = ""
    @Published var completed = false
    @Published var errorMessage: String = ""
    
    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error{
                self.errorMessage = error.localizedDescription
                return
            }
            self.completed = true
            
        }
    }
}

struct ResetPasswordView: View {
    
    @ObservedObject var model = ResetPasswordModel()
    
    var body: some View {
        VStack {
            Text("Enter your email below and we'll send you an email to reset your password!")
                .padding(.all, 8)
                .padding(.bottom, 20)
                .padding(.vertical)
            TextField("Email", text: self.$model.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .autocapitalization(.none)
                .padding(.bottom, 40)
                .disableAutocorrection(true)
            Button(action: resetAction) {
                ZStack {
                    Rectangle()
                        .fill(Color("DeepRed"))
                        .frame(width: 370, height: 45)
                    Text("Reset password")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
            }
                .padding(.bottom, 10)
            if(model.completed == true) {
                Text("Email has been sent to reset password!")
            }
            else {
                Text(model.errorMessage)
                    .foregroundColor(.red)
            }
            Spacer()
        }
        .navigationBarTitle("Reset Password")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarColor(.white)
        
    }
    
    func resetAction() {
        if(model.email == "") {
            model.errorMessage = "Please enter your email"
        }
        else {
            model.resetPassword()
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
