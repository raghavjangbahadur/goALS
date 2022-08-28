//
//  RegistrationSelection.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/25/22.
//

import SwiftUI

struct RegistrationSelection: View {
    var body: some View {
        VStack {
            Spacer()
            NavigationLink(destination: RegistrationView(model: RegistrationModel())) {
                ZStack {
                    RoundedRectangle(cornerRadius:15)
                        .frame(width: 150, height: 150)
                        .foregroundColor(.white)
                        .padding(.all, 15)
                    Text("Primary Account")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                        .font(.title2)
                        .frame(width: 100)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .padding(.bottom, 50)
            
            NavigationLink(destination: RegistrationSecondaryView(model: RegistrationModel())) {
                ZStack {
                    RoundedRectangle(cornerRadius:15)
                        .frame(width: 150, height: 150)
                        .foregroundColor(.white)
                        .padding(.all, 15)
                    Text("Secondary Account")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                        .font(.title2)
                        .frame(width: 120)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            Divider()
            Spacer()
        }
        .background(Color.red)
    }
}

struct RegistrationSelection_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationSelection()
    }
}
