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
    @ObservedObject var model: ChatViewModel

    @State var text = ""

    init(model: ChatViewModel) {
        self.model =  model
    }

    var body: some View {
        VStack {
            if model.count == 0 {
                VStack(spacing: 0) {
                    Spacer()
                    chatBottomBar
                        .background(Color.white.ignoresSafeArea())
                }
            } else {
                messagesView
                VStack(spacing: 0) {
                    chatBottomBar
                        .background(Color.white.ignoresSafeArea())
                }
            }
        }
        .navigationTitle(model.userFirstName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarColor(.white)
        .onAppear {
            self.model.fetchChat()
        }
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
                .onReceive(model.$count) { count in
                    guard count > 0 else {
                        return
                    }
                    withAnimation(.easeInOut(duration: 0.1)) {
                        scrollViewProxy.scrollTo(Self.emptyString, anchor: .bottom)
                        print("--------\(count)---------")
                    }
                }.onAppear {
                    scrollViewProxy.scrollTo(Self.emptyString, anchor: .bottom)
                }
            }
        }
        .background(Color(.init(white: 0.95, alpha: 1)))
    }

    private var chatBottomBar: some View {
        HStack(spacing: 16) {
            ZStack {
                DescriptionPlaceholder()
                    .opacity(model.text.isEmpty ? 1 : 0)
                TextEditor(text: $model.text)
                    .opacity(model.text.isEmpty ? 0.5 : 1)
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
            .background(Color("DeepRed"))
            .cornerRadius(4)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .padding(.bottom, 8)
    }
}

private struct DescriptionPlaceholder: View {
    var body: some View {
        HStack {
            Text("Message")
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
    
    let formatter = DateFormatter()
    
    init(message: Message) {
        self.message = message
        formatter.dateFormat = "dd MMM yyyy"
        if (formatter.string(from: message.time) == formatter.string(from: Date.now)) {
            formatter.dateFormat = "HH:mm"
        }
        else{
            formatter.dateFormat = "MM/dd HH:mm"
        }
    }
    
    var body: some View {
        VStack {
            if message.fromId == Auth.auth().currentUser?.uid {
                HStack {
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(message.text)
                            .foregroundColor(.white)
                            .padding(.bottom, 2)
                        Text(formatter.string(from: message.time))
                            .foregroundColor(.white)
                            .font(.system(size: 10))
                    }
                    .padding()
                    .background(Color("DeepRed"))
                    .cornerRadius(8)
                }
            }
            else {
                HStack {
                    VStack(alignment: .leading) {
                        Text(message.text)
                            .foregroundColor(.black)
                            .padding(.bottom, 2)
                        Text(formatter.string(from: message.time))
                            .foregroundColor(.black)
                            .font(.system(size: 10))
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
            ChatView(model: ChatViewModel())
        }
    }
}
