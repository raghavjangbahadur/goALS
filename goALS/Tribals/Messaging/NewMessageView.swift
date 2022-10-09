//
//  NewMessageView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/23/22.
//

import SwiftUI

struct NewMessageView: View {
    
    let didSelectNewUser: (User) -> ()
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var model = ChatModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                ForEach(model.users) { user in
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        didSelectNewUser(user)
                    } label: {
                        HStack(spacing: 16) {
                            Image(systemName: "person.fill")
                                .font(.system(size: 34, weight: .heavy))
                                .foregroundColor(.black)
                            Text(user.firstName)
                                .foregroundColor(.black)
                            Spacer()
                        }.padding(.horizontal)
                    }
                    Divider()
                        .padding(.vertical, 8)
                }
            }.navigationTitle("New Message")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }
                }
        }
    }
    
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
    }
}
