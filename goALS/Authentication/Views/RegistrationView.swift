//
//  RegistrationView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/25/22.
//

import SwiftUI
import FirebaseFirestore

struct RegistrationView: View {
    @ObservedObject var model: RegistrationModel
    
    init(model: RegistrationModel) {
        self.model = model
    }
    
    var body: some View {
        ScrollView{
            HStack {
                Spacer()
                Image("goals_logo_white")
                     .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .padding(10)
                Spacer()
            }
            .background(Color("DeepRed"))
            Group {
                Text("Enter Caregiver (your) first name")
                    .fontWeight(.bold)
                    .foregroundColor(Color("DarkGrey"))
                    .padding(.top)
                TextField("First name", text: self.$model.firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom)
                    .disableAutocorrection(true)
                Text("Enter Caregiver (your) last name")
                    .fontWeight(.bold)
                    .foregroundColor(Color("DarkGrey"))
                TextField("Last name", text: self.$model.lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom)
                    .disableAutocorrection(true)
                Text("ALS Patient Name")
                    .fontWeight(.bold)
                    .foregroundColor(Color("DarkGrey"))
                TextField("ALS Patient Name", text: self.$model.patientName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom)
                    .disableAutocorrection(true)
                Text("Set user ID (email)")
                    .fontWeight(.bold)
                    .foregroundColor(Color("DarkGrey"))
                TextField("Email", text: self.$model.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .autocapitalization(.none)
                    .padding(.bottom)
                    .disableAutocorrection(true)
                Text("Set password (minimum 6 characters)")
                    .fontWeight(.bold)
                    .foregroundColor(Color("DarkGrey"))
                TextField("Password", text: self.$model.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom, 25)
                    .disableAutocorrection(true)
            }
            Button(action: registerAction) {
                Text("Register now")
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color("DeepRed"))
                    )
            }
            .padding(.bottom, 10)
            Text(model.errorMessage)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.red)
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
            NavigationLink(
                destination:
                    ContentView()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true),
                isActive: $model.registered,
                label: {}
            )
        }
        .navigationTitle("Primary Registration")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarColor(.white)
    
    }
    
    func registerAction() {
        if(model.firstName == "") {
            model.errorMessage = "Please enter your first name"
        }
        else if(model.lastName == "") {
            model.errorMessage = "Please enter your last name"
        }
        else if (model.patientName == "") {
            model.errorMessage = "Please enter patient's name"
        }
        else if (model.email == "") {
            model.errorMessage = "Please enter your email"
        }
        else if (model.password == "") {
            model.errorMessage = "Please enter your password"
        }
        else {
            model.registerPrimary()
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(model: RegistrationModel(loginModel: LoginModel()))
    }
}
