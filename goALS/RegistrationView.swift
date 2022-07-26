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
            padding()
            Text("Set user ID (email)")
            TextField("Email", text: self.$model.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .autocapitalization(.none)
            Text("Set password")
            TextField("Password", text: self.$model.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 10)
                .autocapitalization(.none)
            Button("Register", action: registerAction)
            NavigationLink(
                destination: ContentView(),
                label: {}
            )
        }
    
    }
    
    func registerAction() {
        model.registerCall()
    }
}

//struct RegistrationView_Previews: PreviewProvider {
    //static var previews: some View {
        //RegistrationView()
    //}
//}
