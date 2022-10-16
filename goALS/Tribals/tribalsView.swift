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
            VStack {
                HStack{
                    Spacer()
                    Button {
                        present.wrappedValue.dismiss()
                    } label: {
                        HStack{
                            Image(systemName: "house.fill")
                                .foregroundColor(.white)
                                .offset(x: 20)
                            Image("goals_logo_white")
                                 .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 100)
                            
                        }
                    }
                    .offset(x:10)
                    Text("> > >")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    Image("tribals_logo_white2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 115)
                        .offset(x:-10)
                    Spacer()
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
        })
        .navigationBarTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)

    }
}

struct tribalsView_Previews: PreviewProvider {
    static var previews: some View {
        tribalsView()
    }
}
