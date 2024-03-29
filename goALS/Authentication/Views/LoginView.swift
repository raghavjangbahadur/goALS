//
//  LoginView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/28/22.
//
import SwiftUI

struct NavigationBarModifier: ViewModifier {

    var backgroundColor: UIColor?
    
    init( backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .systemBlue

    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
}

struct LoginView: View {
    @ObservedObject var model: LoginModel
    
    init(model: LoginModel? = nil) {
        if let model {
            self.model = model
        } else {
            self.model = LoginModel()
        }
    }

    var loginView: some View {
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
                    .fixedSize(horizontal: false, vertical: true)
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
                goalsView()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
            }
            .hidden()
        }
        .background(Color("DeepRed"))
        .navigationBarHidden(true)
    }

    var progressView: some View {
        VStack(alignment: .leading) {
            Image("goals_logo_white")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
                .padding(.bottom, 50)
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                Spacer()
            }
            Spacer() // VStack bottom spacer
        }
        .frame(maxWidth: .infinity)
        .background(Color("DeepRed"))
        .navigationBarHidden(true)
    }
    
    var body: some View {
        NavigationView {
            switch model.authStatus {
            case .inProgress:
                progressView
            case .unauthenticated:
                loginView
            case .authenticated:
                goalsView()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
            }
        }.onAppear {
            authenticate()
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
            authenticate()
        }
    }
    
    func authenticate() {
        model.loginCall()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
