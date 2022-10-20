//
//  CommunicationView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 10/19/22.
//

import SwiftUI

struct CommunicationView: View {
    
    @Environment(\.presentationMode) var present
    
    var body: some View {
        VStack{
            ZStack {
                RoundedRectangle(cornerRadius:15)
                    .frame(width: 350, height: 100)
                    .foregroundColor(Color("DarkGrey"))
                    .padding(.all, 15)
                Text("Patient Communication Resources")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding(.all, 20)
            List(){
                Text("[Changes in Speech and Comunication Solutions](https://www.als.org/sites/default/files/2020-04/lwals_09_2017.pdf)")
                    .padding(10)
                Text("[ALS Communication Devices]( https://www.youralsguide.com/communication.html)")
                    .padding(10)
                Text("[Augmentative and Alternative Communication](https://www.als.org/navigating-als/living-with-als/therapies-care/augmentative-alternative-communication)")
                    .padding(10)
                Text("[\"I Have Voice\" App](https://apps.apple.com/us/app/i-have-voice-als-mnd/id1444485505)")
                    .padding(10)
                Text("[\"Proloque2Go\" App](https://www.assistiveware.com/products/proloquo2go)")
                    .padding(10)
                Text("[\"My Own Voice\" ]( https://mov.acapela-group.com/)")
                    .padding(10)
            }
            Spacer()
        }
        .padding()
    }
}

struct CommunicationView_Previews: PreviewProvider {
    static var previews: some View {
        CommunicationView()
    }
}
