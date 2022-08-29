//
//  ChatView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/23/22.
//


import Foundation
import Foundation
import Firebase
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct ChatView: View {
    
    let user: User?
    
    init(user: User?) {
        self.user = user
        self.model = .init(user: user)
    }

    @ObservedObject var model: ChatViewModel
    
    @State var text = ""

    var body: some View {
        ZStack {
            messagesView
            VStack(spacing: 0) {
                Spacer()
                chatBottomBar
                    .background(Color.white.ignoresSafeArea())
            }
        }.onAppear() {
            model.fetchChat()
        }
        .navigationTitle(user?.firstName ?? "")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    static let emptyString = "Empty"

    private var messagesView: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                VStack {
                    ForEach(model.messages) { message in
                        MessageView(message: message)
                        
                    }
                    HStack{ Spacer() }
                        .id(Self.emptyString)
                }
                .onReceive(model.$count) { _ in
                    withAnimation(.easeOut(duration: 0.4)) {
                        scrollViewProxy.scrollTo(Self.emptyString, anchor: .bottom)
                    }
                }
            }
        }
        .background(Color(.init(white: 0.95, alpha: 1)))

    }

    private var chatBottomBar: some View {
        HStack(spacing: 16) {
            /*Image(systemName: "photo.on.rectangle")
                .font(.system(size: 24))
                .foregroundColor(Color(.darkGray))*/
            ZStack {
                DescriptionPlaceholder()
                TextEditor(text: $model.text)
                    .opacity(text.isEmpty ? 0.5 : 1)
            }
            .frame(height: 40)

            Button {
                model.send()
            } label: {
                Text("Send")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 6)
            .background(Color.blue)
            .cornerRadius(4)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

private struct DescriptionPlaceholder: View {
    var body: some View {
        HStack {
            Text("")
                .foregroundColor(Color(.gray))
                .font(.system(size: 17))
                .padding(.leading, 5)
                .padding(.top, -4)
            Spacer()
        }
    }
}
struct MessageView: View {
    let message: Message
    
    var body: some View {
        VStack {
            if message.fromId == Auth.auth().currentUser?.uid {
                HStack {
                    Spacer()
                    HStack {
                        Text(message.text)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                }
            }
            else {
                HStack {
                    HStack {
                        Text(message.text)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatView(user: nil)
        }
    }
}
