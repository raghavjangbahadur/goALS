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
                Image("goals_logo_white")
                     .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 80)
                    .padding(.horizontal)
                Spacer()
                NavigationLink(destination: accountView()) {
                    HStack {
                        Text("Settings")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        Image(systemName: "person.fill")
                            .font(.system(size: 16))
                            .foregroundColor(Color.white)
                    }
                    .padding(6)
                }
                .padding(.bottom, 20)
                .padding(.horizontal)
                .padding(.vertical)
            }
            Text("Hi " + model.user.firstName + "!")
                .foregroundColor(.white)
                .font(.system(size: 25))
                .fontWeight(.bold)
                .padding(.bottom, 20)
            Text("Welcome to the goALS App!")
                .foregroundColor(.white)
                .padding(.bottom, 30)
            
            NavigationLink(destination: vitalsView()) {
                HStack{
                    ZStack {
                        RoundedRectangle(cornerRadius:15)
                            .frame(width: 125, height: 125)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.5), radius: 5)
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
            }

            NavigationLink(destination: tribalsView()) {
                HStack{
                    ZStack {
                        RoundedRectangle(cornerRadius:15)
                            .frame(width: 125, height: 125)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.5), radius: 5)
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
            }
            
            NavigationLink(destination: verbalsView()) {
                HStack{
                    ZStack {
                        RoundedRectangle(cornerRadius:15)
                            .frame(width: 125, height: 125)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.5), radius: 5)
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
            }
            Spacer()
            
        }.onAppear {
            model.getSingleData()
            
        }
        .background(Color("DeepRed"))
    }
}

struct goalsView_Previews: PreviewProvider {
    static var previews: some View {
        goalsView()
    }
}
