//
//  tribalsView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/2/22.
//

import SwiftUI

struct tribalsView: View {
    
    @State var showPublic = false
    
    var body: some View {
        VStack {
            VStack {
                HStack{
                    Spacer()
                    Image("goals_logo_white")
                         .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                    Text("> > >")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    Image("tribals_logo_white2")
                         .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 125)
                    Spacer()
                }
                Divider()
            }
            .background(Color("DarkGrey"))
            NavigationLink(destination: MainMessagesView()) {
                ZStack {
                    RoundedRectangle(cornerRadius:15)
                        .frame(width: 320, height: 45)
                        .foregroundColor(Color("LightGrey"))
                        .shadow(color: Color.black.opacity(0.5), radius: 10)
                    Text("Individual Messaging")
                        .foregroundColor(Color("DarkGrey"))
                        .fontWeight(.bold)
                }
                .padding(.top, 30)
            }
            .padding(.bottom, 30)
            
            NavigationLink(destination: GroupChatView()) {
                ZStack {
                    RoundedRectangle(cornerRadius:15)
                        .frame(width: 320, height: 45)
                        .foregroundColor(Color("LightGrey"))
                        .shadow(color: Color.black.opacity(0.5), radius: 10)
                    Text("Circle Messaging")
                        .foregroundColor(Color("DarkGrey"))
                        .fontWeight(.bold)
                }
            }
            .padding(.bottom, 30)
            ZStack {
                RoundedRectangle(cornerRadius:15)
                    .frame(width: 320, height: 45)
                    .foregroundColor(Color("LightGrey"))
                    .shadow(color: Color.black.opacity(0.5), radius: 10)
                Text("Public Community")
                    .foregroundColor(Color("DarkGrey"))
                    .fontWeight(.bold)
            }
            .padding(.bottom, 30)
            .onTapGesture(perform: {
                showPublic.toggle()
            })
            Spacer()
        }
        .background(Color.white)
        .sheet(isPresented: $showPublic, content: {
            CommunityView()
        })
    }
}

struct tribalsView_Previews: PreviewProvider {
    static var previews: some View {
        tribalsView()
    }
}
