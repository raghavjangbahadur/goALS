//
//  verbalsView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/2/22.
//

import SwiftUI

struct verbalsView: View {
    
    @Environment(\.presentationMode) var present
    
    @State var showCommunication = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack{
                HStack{
                    Button {
                        present.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "house.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30, alignment: .leading)
                            .foregroundColor(.white)
                            .padding(.leading)
                    }
                    Spacer()
                }
                HStack{
                    Image("verbals_logo_white")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 120, alignment: .center)
                }
            }
            .background(Color("DarkGrey"))
            ZStack {
                RoundedRectangle(cornerRadius:15)
                    .frame(width: 320, height: 45)
                    .foregroundColor(Color("LightGrey"))
                    .shadow(color: Color.black.opacity(0.4), radius: 4)
                Text("Patient Communication Resources")
                    .foregroundColor(Color("DarkGrey"))
                    .fontWeight(.bold)
            }
            .padding(.bottom, 30)
            .padding(.vertical, 30)
            .onTapGesture(perform: {
                showCommunication.toggle()
            })
            Spacer()
        }
        .sheet(isPresented: $showCommunication, content: {
            CommunicationView()
        })
        .background(Color("ListBG"))
        .navigationBarHidden(true)
    }
}

struct verbalsView_Previews: PreviewProvider {
    static var previews: some View {
        verbalsView()
    }
}
