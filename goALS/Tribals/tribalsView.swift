//
//  tribalsView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/2/22.
//

import SwiftUI

struct tribalsView: View {
    
    @State var showPublic = false
    
    @ObservedObject var GroupModel = GroupChatModel()
    
    @Environment(\.presentationMode) var present
    
    var body: some View {
        VStack {
            ZStack{
                HStack{
                    Button {
                        present.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "house.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30, alignment: .leading)
                            .foregroundColor(.white)
                            .padding(.leading)
                    }
                    Spacer()
                }
                HStack{
                    Image("tribals_logo_white2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 120, alignment: .center)
                        .offset(y: 5)
                }
            }
            .background(Color("DarkGrey"))
            NavigationLink(destination: MainMessagesView()) {
                ZStack {
                    RoundedRectangle(cornerRadius:15)
                        .frame(width: 320, height: 45)
                        .foregroundColor(Color("LightGrey"))
                        .shadow(color: Color.black.opacity(0.4), radius: 4)
                    Text("Individual Messaging")
                        .foregroundColor(Color("DarkGrey"))
                        .fontWeight(.bold)
                }
                .padding(.top, 30)
            }
            .padding(.bottom, 30)
            
            NavigationLink(destination: GroupChatView(model: GroupModel)) {
                ZStack {
                    RoundedRectangle(cornerRadius:15)
                        .frame(width: 320, height: 45)
                        .foregroundColor(Color("LightGrey"))
                        .shadow(color: Color.black.opacity(0.4), radius: 4)
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
                    .shadow(color: Color.black.opacity(0.4), radius: 4)
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
        })        .navigationBarHidden(true)

    }
}

struct tribalsView_Previews: PreviewProvider {
    static var previews: some View {
        tribalsView()
    }
}
