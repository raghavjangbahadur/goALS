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
                VStack{
                    ZStack {
                        RoundedRectangle(cornerRadius:15)
                            .frame(width: 300, height: 100)
                            .foregroundColor(Color("DarkGrey"))
                            .padding(.all, 15)
                        Text("Primary Caregiver")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.title2)
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                    Text("You are the main caregiver for your ALS patient")
                        .foregroundColor(Color("DarkGrey"))
                        .fontWeight(.bold)
                        .frame(width: 300)
                        .padding(.bottom)
                }
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color.white)
                        .shadow(color: Color.black.opacity(0.3), radius: 30)
                )
            }
            .padding(.bottom, 50)
            
            NavigationLink(destination: RegistrationSecondaryView(model: RegistrationModel())) {
                VStack{
                    ZStack {
                        RoundedRectangle(cornerRadius:15)
                            .frame(width: 300, height: 100)
                            .foregroundColor(Color("DarkGrey"))
                            .padding(.all, 15)
                        Text("Secondary Caregiver")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.title2)
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                    Text("You are supporting the Primary Caregiver in providing care to your ALS patient, and have been sent a code and patient full name to sign up for this app")
                        .foregroundColor(Color("DarkGrey"))
                        .fontWeight(.bold)
                        .frame(width: 300)
                        .padding(.bottom)
                }
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color.white)
                        .shadow(color: Color.black.opacity(0.3), radius: 30)
                )
            }
            Spacer()
        }
        .background(Color.white)
    }
}

struct RegistrationSelection_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationSelection()
    }
}
