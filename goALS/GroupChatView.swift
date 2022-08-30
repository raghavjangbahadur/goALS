//
//  GroupChatView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/30/22.
//

import SwiftUI

struct GroupChatView: View {
    
    @ObservedObject var model = GroupChatModel()
    
    @State var text = ""
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct GroupChatView_Previews: PreviewProvider {
    static var previews: some View {
        GroupChatView()
    }
}
