//
//  verbalsView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/2/22.
//

import SwiftUI

struct verbalsView: View {
    var body: some View {
        VStack{
            VStack {
                HStack{
                    Spacer()
                    Image("goals_logo_white")
                         .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                    Text("> > >")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    Image("verbals_logo_white")
                         .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 125)
                    Spacer()
                }
                Divider()
            }
            .background(Color("DarkGrey"))
            Text("Coming soon!")
                .padding(.top, 100)
            Spacer()
        }
    }
}

struct verbalsView_Previews: PreviewProvider {
    static var previews: some View {
        verbalsView()
    }
}
