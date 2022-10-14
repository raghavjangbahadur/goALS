//
//  LoginView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/28/22.
//
import SwiftUI
struct LoginView: View {
    @ObservedObject var model: LoginModel = LoginModel()

    var body: some View {
        NavigationView {
            VStack {
                Image("goals_logo_white")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)
                    .padding(.bottom, 50)
                VStack{
                    TextField("Email", text: self.$model.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 20)
                        .autocapitalization(.none)
                        .padding(.bottom, 20)
                        .padding(.top, 20)
                        .disableAutocorrection(true)
                    SecureField("Password", text: self.$model.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 20)
                        .autocapitalization(.none)
                        .padding(.bottom, 20)
                        .disableAutocorrection(true)
                    Button(action: loginAction) {
                        ZStack {
                            Rectangle()
                                .fill(Color("DarkGrey"))
                                .frame(width: 150, height: 45)
                            Text("Log in")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                    }
                    .padding(.bottom, 10)
                    Text(model.errorMessage)
                        .foregroundColor(.red)
                        .padding(5)
                        .padding(.horizontal, 5)
                    NavigationLink("Forgot Password") {
                        ResetPasswordView()
                    }
                    .padding(.bottom, 2)
                    NavigationLink("Don't have an account? Register now!") {
                        RegistrationSelection()
                    }
                    .padding(.bottom, 5)
                }
                .padding(.bottom, 10)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color("LightGrey"))
                        .shadow(color: Color.black.opacity(0.3), radius: 15)
                )
                .padding(.horizontal, 15)
                Spacer()
                NavigationLink("Hidden nav link", isActive: self.$model.loggedIn) {
                    ContentView()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                }
                .hidden()
            }.onAppear {
                primaryLoginAction()
            }
            .background(Color("DeepRed"))
        }
        .environment(\.rootPresentationMode, self.$model.loggedIn)
        .environmentObject(self.model)
    }

    func loginAction() {
        if (model.email == "") {
            model.errorMessage = "Please enter your email"
        }
        else if (model.password == "") {
            model.errorMessage = "Please enter your password"
        }
        else {
            model.loginCall()
        }
    }
    
    func primaryLoginAction() {
        model.loginCall()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
