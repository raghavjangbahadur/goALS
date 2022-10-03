//
//  goalsView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/2/22.


import SwiftUI

struct goalsView: View {
    @ObservedObject var model = PatientInfoModel()
    var body: some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink(destination: accountView()) {
                    ZStack {
                        RoundedRectangle(cornerRadius:15)
                            .frame(width: 110, height: 30)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.5), radius: 5)
                            .padding(.all, 15)
                        HStack {
                            Text("Account")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(Color("DarkGrey"))
                            Image(systemName: "person.fill")
                                .font(.system(size: 16))
                                .foregroundColor(Color("DarkGrey"))
                        }
                    }
                }
                .padding(.bottom, 20)
            }
            Text("Hi " + model.user.firstName + "!")
                .foregroundColor(.white)
                .padding(.bottom, 50)
            NavigationLink(destination: vitalsView()) {
                ZStack {
                    RoundedRectangle(cornerRadius:15)
                        .frame(width: 125, height: 125)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.6), radius: 20)
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
                        .shadow(color: .black.opacity(0.6), radius: 20)
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
                        .shadow(color: .black.opacity(0.6), radius: 20)
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
            Spacer()
            
        }.onAppear {
                model.getSingleData()
        }
        .padding(.bottom, 100)
        .background(Color("DeepRed"))
        
    }
}

struct goalsView_Previews: PreviewProvider {
    static var previews: some View {
        goalsView()
    }
}
