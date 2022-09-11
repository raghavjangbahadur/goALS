//
//  tribalsView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/2/22.
//

import SwiftUI

struct tribalsView: View {
    var body: some View {
        VStack {
            Image("goals_logo_white")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
                .padding(.all)
            NavigationLink(destination: MainMessagesView()) {
                ZStack {
                    RoundedRectangle(cornerRadius:15)
                        .frame(width: 320, height: 45)
                        .foregroundColor(.gray)
                    Text("Individual Messaging")
                        .foregroundColor(.white)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .padding(.bottom, 20)
            
            NavigationLink(destination: GroupChatView()) {
                ZStack {
                    RoundedRectangle(cornerRadius:15)
                        .frame(width: 320, height: 45)
                        .foregroundColor(.gray)
                    Text("Circle Messaging")
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom, 20)
            
            Divider()
            Spacer()
        }
        .background(Color.red)
    }
}

struct tribalsView_Previews: PreviewProvider {
    static var previews: some View {
        tribalsView()
    }
}
