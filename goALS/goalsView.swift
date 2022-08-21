//
//  goalsView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/2/22.


import SwiftUI

struct goalsView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: accountView()) {
                    Text("Account")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                }
                Text("Hi Raghav")
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
                
                Spacer()
                
            }
            .padding(.bottom, 100)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.red.edgesIgnoringSafeArea(.all))
        }
        
    }
}

struct goalsView_Previews: PreviewProvider {
    static var previews: some View {
        goalsView()
    }
}
