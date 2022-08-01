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
                .padding(.bottom)
            
            //going to add more text fields for additional information
            
            Divider()
            Spacer()
            Button("Register", action: registerAction)
                .padding(.bottom, 25)
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
