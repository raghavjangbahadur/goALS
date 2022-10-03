//
//  RegistrationView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/25/22.
//

import SwiftUI

struct RegistrationView: View {
    @ObservedObject var model: RegistrationModel
    
    init(model: RegistrationModel) {
        self.model = model
    }
    
    var body: some View {
        VStack {
            VStack {
                Image("goals_logo_white")
                     .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .padding(.all)
                Divider()
            }
            .background(Color("DeepRed"))
            Group {
                Text("Enter Caregiver (your) first name")
                    .fontWeight(.bold)
                    .padding(.top)
                TextField("First name", text: self.$model.firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom)
                    .disableAutocorrection(true)
                Text("Enter Caregiver (your) last name")
                    .fontWeight(.bold)
                TextField("Last name", text: self.$model.lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom)
                    .disableAutocorrection(true)
                Text("ALS Patient Name")
                    .fontWeight(.bold)
                TextField("Patient Name", text: self.$model.patientName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom)
                    .disableAutocorrection(true)
                Text("Set user ID (email)")
                    .fontWeight(.bold)
                TextField("Email", text: self.$model.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .autocapitalization(.none)
                    .padding(.bottom)
                    .disableAutocorrection(true)
                Text("Set password (minimum 6 characters)")
                    .fontWeight(.bold)
                TextField("Password", text: self.$model.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom, 25)
                    .disableAutocorrection(true)
            }
            Divider()
            Spacer()
            
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
            .padding(.bottom, 35)
            NavigationLink(
                destination: ContentView(),
                isActive: $model.registered,
                label: {}
            )
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .background(Color.white)
    
    }
    
    func registerAction() {
        model.registerCall()
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(model: RegistrationModel())
    }
}
