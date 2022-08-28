//
//  RegistrationSecondaryView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/25/22.
//

import SwiftUI

struct RegistrationSecondaryView: View {
    @ObservedObject var model: RegistrationModel
    
    init(model: RegistrationModel) {
        self.model = model
    }
    
    var body: some View {
        VStack {
            Image("goals_logo_white")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 50)
                .padding(.all)
            Group {
                TextField("Enter Caregiver (your) first name", text: self.$model.firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom)
                    .disableAutocorrection(true)
                TextField("Enter Caregiver (your) last name", text: self.$model.lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom)
                    .disableAutocorrection(true)
                Text("ALS Patient Name")
                  .fontWeight(.bold)
                TextField("Patient Name", text: self.$model.patientName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .autocapitalization(.none)
                    .padding(.bottom, 15)
                    .disableAutocorrection(true)
                Text("Set user ID (email)")
                    .fontWeight(.bold)
                TextField("Email", text: self.$model.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .autocapitalization(.none)
                    .padding(.bottom, 15)
                    .disableAutocorrection(true)
                Text("Set password (minimum 6 characters)")
                    .fontWeight(.bold)
                TextField("Password", text: self.$model.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom, 15)
                    .disableAutocorrection(true)
                Text("Enter unique patient ID from Primary Caregiver")
                    .fontWeight(.bold)
                TextField("Unique Patient ID", text: self.$model.generatedId)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom, 15)
                    .disableAutocorrection(true)
            }
            
            Divider()
            Spacer()
            
            Button("Register", action: registerAction)
                .padding(.bottom, 35)
            NavigationLink(
                destination: ContentView(),
                isActive: $model.registered,
                label: {}
            )
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        
        .background(Color.red)
    }
    
    
    func registerAction() {
        model.registerSecondary()
    }
    
}

struct RegistrationSecondaryView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationSecondaryView(model: RegistrationModel())
    }
}
