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
            Image("goals_logo_white")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
                .padding(.all, 40)
            Text("Enter Caregiver (your) first and last name")
                .fontWeight(.bold)
            TextField("First and last name", text: self.$model.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 10)
                .autocapitalization(.none)
                .padding(.bottom)
            Text("ALS Patient Name")
                .fontWeight(.bold)
            TextField("Patient Name", text: self.$model.patientName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 10)
                .autocapitalization(.none)
                .padding(.bottom)
            Text("Set user ID (email)")
                .fontWeight(.bold)
            TextField("Email", text: self.$model.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .autocapitalization(.none)
                .padding(.bottom)
            Text("Set password (minimum 6 characters)")
                .fontWeight(.bold)
            TextField("Password", text: self.$model.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 10)
                .autocapitalization(.none)
                .padding(.bottom, 25)
            
            Divider()
            Spacer()
            
            Button("Register", action: registerAction)
                .padding(.bottom, 35)
            NavigationLink(
                destination: ContentView(),
                isActive: $model.registered,
                label: {}
            )
        }
        .background(Color.red)
    
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
