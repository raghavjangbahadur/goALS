//
//  goalsView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/2/22.


import SwiftUI

struct goalsView: View {
    @ObservedObject var model = PatientInfoModel()
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: accountView()) {
                    Text("Account")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                }
                Text("Hi " + model.user.firstName + "!")
                    .foregroundColor(.white)
                NavigationLink(destination: vitalsView()) {
                    ZStack {
                        RoundedRectangle(cornerRadius:15)
                            .frame(width: 125, height: 125)
                            .foregroundColor(.white)
                            .padding(.all, 15)
                        Image("vitals_logo_grey")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 24)
                    }
                    Text("Find and update vital information about ALS and your patient")
                        .foregroundColor(.white)
                        .frame(maxWidth: 200)
                }
                .navigationBarBackButtonHidden(true)
                
                NavigationLink(destination: tribalsView()) {
                    ZStack {
                        RoundedRectangle(cornerRadius:15)
                            .frame(width: 125, height: 125)
                            .foregroundColor(.white)
                            .padding(.all, 15)
                        Image("tribals_logo_grey")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 24)
                    }
                    Text("Find and access your public and private community")
                        .foregroundColor(.white)
                        .frame(maxWidth: 200)
                    
                }
                .navigationBarBackButtonHidden(true)
                
                NavigationLink(destination: verbalsView()) {
                    ZStack {
                        RoundedRectangle(cornerRadius:15)
                            .frame(width: 125, height: 125)
                            .foregroundColor(.white)
                            .padding(.all, 15)
                        Image("verbals_logo_grey")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 24)
                    }
                    Text("Communicate with your ALS patient")
                        .foregroundColor(.white)
                        .frame(maxWidth: 200)
                }
                .navigationBarBackButtonHidden(true)
                Divider()
                Spacer()
                
            }
            .padding(.bottom, 100)
            .background(Color.red)
        }.onAppear {
            model.getSingleData()
        }
        
    }
}

struct goalsView_Previews: PreviewProvider {
    static var previews: some View {
        goalsView()
    }
}
