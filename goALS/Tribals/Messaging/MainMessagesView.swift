//
//  MainMessagesView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/23/22.
//

import Foundation
import Firebase
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct MainMessagesView: View {
    
    @State var shouldShowExitOptions = false
    @State var shouldShowNewMessageScreen = false
    @State var shouldNavigateToChatLogView = false
    @State var user: User?
    @State var exit = false
    
    @ObservedObject var model = MainMessagesViewModel()

    private var customNavBar: some View {
        HStack(spacing: 16) {
            
            Image(systemName: "person.fill")
                .font(.system(size: 34, weight: .heavy))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(model.user.firstName)")
                    .font(.system(size: 24, weight: .bold))
                
                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                    Text("online")
                        .font(.system(size: 12))
                        .foregroundColor(Color("DarkGrey"))
                }
                
            }
            
            Spacer()
            /*Button {
                shouldShowExitOptions.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(.label))
            }*/
        }
        .padding()
        .actionSheet(isPresented: $shouldShowExitOptions) {
            .init(title: Text("Exit Messaging") , buttons: [
                .destructive(Text("Exit"), action: {
                    exit.toggle()
                    print("handle exit")
                }),
                .cancel()
            ])
        }
    }
    
    var body: some View {
        VStack {
            customNavBar
            messagesView
            
            NavigationLink("", isActive: $shouldNavigateToChatLogView) {
                ChatView(user: self.user)
            }
            NavigationLink(
                destination: tribalsView(),
                isActive: $exit,
                label: {}
            )
        } .onAppear {
            model.fetchRecentMessages()
        }
        .overlay(
            newMessageButton, alignment: .bottom)
    }
    
    private var messagesView: some View {
        ScrollView {
            ForEach(model.recentMessages) { recentMessage in
                VStack {
                    Button {
                        model.fetchUser(msg: recentMessage) { user in
                            self.user = user
                        }
                        self.shouldNavigateToChatLogView.toggle()
                        
                    } label: {
                        HStack(spacing: 16) {
                            Image(systemName: "person.fill")
                                .font(.system(size: 32))
                                .accentColor(.black)
                                .padding(8)
                                .overlay(RoundedRectangle(cornerRadius: 44)
                                    .stroke(Color(.label), lineWidth: 1)
                                )
                            
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(recentMessage.firstName)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                                Text(recentMessage.text)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color("DarkGrey"))
                                    .multilineTextAlignment(.leading)
                                
                            }
                            Spacer()
                            
                            Text(recentMessage.timeAgo)
                                .font(.system(size: 14, weight: .semibold))
                                .accentColor(.black)
                        }
                        Divider()
                            .padding(.vertical, 8)
                    }
                }.padding(.horizontal)
                
            }.padding(.bottom, 50)
        }
    }
    
    private var newMessageButton: some View {
        Button {
            shouldShowNewMessageScreen.toggle()
        } label: {
            HStack {
                Spacer()
                Text("+ New Message")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.vertical)
            .background(Color("DeepRed"))
            .cornerRadius(32)
            .padding(.horizontal)
            .shadow(radius: 15)
        }
        .padding(.bottom)
        .fullScreenCover(isPresented: $shouldShowNewMessageScreen){
            NewMessageView(didSelectNewUser: { user in
                print(user.email)
                self.shouldNavigateToChatLogView.toggle()
                self.user = user
            })
            .accentColor(Color("DeepRed"))
        }
    }
}


struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
    }
}
