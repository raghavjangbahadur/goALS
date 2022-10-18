//
//  GroupChatView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/30/22.
//

import SwiftUI
import Firebase
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Foundation

struct GroupChatView: View {
    
    @ObservedObject var model: GroupChatModel

    @State var text = ""

    init(model: GroupChatModel) {
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
        .navigationTitle(model.patientName + "'s Circle" )
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
                        GroupMessageView(message: message)
                        
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
            /*Image(systemName: "photo.on.rectangle")
                .font(.system(size: 24))
                .foregroundColor(Color(.darkGray))*/
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

struct GroupMessageView: View {
    let message: GroupMessage
    
    let formatter = DateFormatter()
    
    init(message: GroupMessage) {
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
                        Text(message.firstName + " " + message.lastName)
                            .font(.system(size: 10))
                            .padding(.bottom, 1)
                        Text(message.text)
                            .foregroundColor(.black)
                            .padding(.bottom, 2)
                        Text(formatter.string(from: message.time))
                            .foregroundColor(.black)
                            .font(.system(size: 10))
                        
                    }
                    .padding(.leading, 10)
                    .padding(.trailing, 20)
                    .padding(.top, 7)
                    .padding(.bottom, 20)
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

struct GroupChatView_Previews: PreviewProvider {
    static var previews: some View {
        GroupChatView(model: GroupChatModel())
    }
}
