//
//  CommunityView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 10/3/22.
//

import SwiftUI

struct CommunityView: View {
    
    @Environment(\.presentationMode) var present
    
    var body: some View {
        VStack{
            ZStack {
                RoundedRectangle(cornerRadius:15)
                    .frame(width: 350, height: 100)
                    .foregroundColor(.gray)
                    .padding(.all, 15)
                Text("Public Community")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding(.all, 20)
            List(){
                Text("[Patientslikeme](https://www.patientslikeme.com/conditions/als)")
                    .padding(10)
                Text("[Support Group](https://www.als.org/local-support/support-groups)")
                    .padding(10)
                Text("[Caregiver Community](https://www.caregiveraction.org/community)")
                    .padding(10)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
