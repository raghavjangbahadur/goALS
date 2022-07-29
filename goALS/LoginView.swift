//
//  LoginView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/28/22.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var model: LoginModel
    
    var body: some View {
        NavigationView {
            VStack {
                Image("goals_logo_white")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)
                    .padding(50)
                TextField("Email", text: self.$model.email)
                    .foregroundColor(.white)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                    .autocapitalization(.none)
                    .padding(.bottom, 30)
                TextField("Password", text: self.$model.password)
                    .foregroundColor(.white)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                    .autocapitalization(.none)
                    .padding(.bottom, 20)
                Button("Log in", action: loginAction)
                Divider()
                Spacer()

                /* need to add a button to go to registration view if user does not have an account, and a button to go to the home page view*/

                NavigationLink("Hidden nav link", isActive: self.$model.loggedIn) {
                    ContentView()
                        .navigationTitle("")
                        .navigationBarBackButtonHidden(true)
                }
                .hidden()
                
                NavigationLink("Don't have an account? Register now!") {
                    RegistrationView(model: RegistrationModel())
                        .navigationTitle("Register now!")
                        .navigationBarBackButtonHidden(true)
                        .padding(.bottom, 30)
                }
            }
            .background(Color.red)
        }
    }

    func loginAction() {
        model.loginCall()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(model: LoginModel())
    }
}
