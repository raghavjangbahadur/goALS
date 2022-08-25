//
//  verbalsView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/2/22.
//

import SwiftUI

struct verbalsView: View {
    var body: some View {
        VStack {
            Image("goals_logo_white")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
                .padding(.all)
            NavigationLink(destination: MainMessagesView()) {
                ZStack {
                    RoundedRectangle(cornerRadius:15)
                        .frame(width: 320, height: 45)
                        .foregroundColor(.gray)
                    Text("Circle Messaging")
                        .foregroundColor(.white)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .padding(.bottom, 20)
            Divider()
            Spacer()
        }
        .background(Color.red)
    }
}

struct verbalsView_Previews: PreviewProvider {
    static var previews: some View {
        verbalsView()
    }
}
