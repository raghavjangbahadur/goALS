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
                if model.users.count == 1 {
                    Text("No users are in the patient circle, go to settings to add users to Circle!")
                }
                else {
                    ForEach(model.users) { user in
                        if user.id != model.userId {
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
                    }
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
