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

struct LinkPresenter<Content: View>: View {
    let content: () -> Content

    @State private var invlidated = false
    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }
    var body: some View {
        Group {
            if self.invlidated {
                EmptyView()
            } else {
                content()
            }
        }
        .onDisappear { self.invlidated = true }
    }
}

struct MainMessagesView: View {
    
    @State var shouldShowExitOptions = false
    @State var shouldShowNewMessageScreen = false
    @State var shouldNavigateToChatLogView = false
    @State var exit = false
    @State var user: User? {
        didSet {
            self.chatModel.user = user
        }
    }

    @ObservedObject var model = MainMessagesViewModel()
    var chatModel = ChatViewModel()
    
    var body: some View {
        VStack {
            messagesView
                .padding(.top, 5)
            Spacer()
            NavigationLink(destination: LinkPresenter { ChatView(model: chatModel) }, isActive: $shouldNavigateToChatLogView) {
                EmptyView()
            }
            NavigationLink(
                destination: tribalsView(),
                isActive: $exit,
                label: {}
            )
        }
        .navigationTitle("Messages")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarColor(.white)
        .overlay(
            newMessageButton, alignment: .bottom
        )
    }
    
    private var messagesView: some View {
        ScrollView {
            ForEach(model.recentMessages) { recentMessage in
                VStack {
                    Button {
                        model.fetchUser(msg: recentMessage) { user in
                            self.user = user
                            self.shouldNavigateToChatLogView.toggle()
                        }
                    } label: {
                        HStack(spacing: 16) {
                            Image(systemName: "person.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.black)
                                .padding(8)
                                .overlay(RoundedRectangle(cornerRadius: 44)
                                    .stroke(Color(.label), lineWidth: 1)
                                )
                            
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(recentMessage.firstName + " " + recentMessage.lastName)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                                Text(recentMessage.text)
                                    .lineLimit(1)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color("DarkGrey"))
                                    .multilineTextAlignment(.leading)
                                
                            }
                            Spacer()
                            
                            if recentMessage.timeAgo.contains("sec") {
                                Text("Now")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                            }
                            else {
                                Text(recentMessage.timeAgo)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                            }
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
                self.user = user
                print(user.email)
                self.shouldNavigateToChatLogView.toggle()
            })
        }
    }
}


struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
    }
}
