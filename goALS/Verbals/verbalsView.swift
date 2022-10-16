//
//  verbalsView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/2/22.
//

import SwiftUI

struct verbalsView: View {
    
    @Environment(\.presentationMode) var present
    
    var body: some View {
        VStack{
            VStack {
                VStack {
                    HStack{
                        Spacer()
                        Button {
                            present.wrappedValue.dismiss()
                        } label: {
                            HStack{
                                Image(systemName: "house.fill")
                                    .foregroundColor(.white)
                                    .offset(x: 20)
                                Image("goals_logo_white")
                                     .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 100)
                                
                            }
                        }
                        .offset(x:10)
                        Text("> > >")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                        Image("verbals_logo_white")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 115)
                            .offset(x:-10)
                        Spacer()
                    }
                }
            }
            .background(Color("DarkGrey"))
            Text("Coming soon!")
                .padding(.top, 100)
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct verbalsView_Previews: PreviewProvider {
    static var previews: some View {
        verbalsView()
    }
}
