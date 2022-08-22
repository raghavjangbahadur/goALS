//
//  vitalsView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 7/2/22.
//

import SwiftUI

struct vitalsView: View {
    var body: some View {
        VStack {
            Image("goals_logo_white")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
                .padding(.all)
            NavigationLink(destination: PatientInfoView()) {
                Text("Key details and information")
                    .foregroundColor(.white)
            }
            .padding(.bottom, 20)
            
            NavigationLink(destination: TodosView()) {
                Text("Daily Checklist")
                    .foregroundColor(.white)
            }
            .padding(.bottom, 20)
            
            NavigationLink(destination: LearnView()) {
                Text("Learn more about ALS")
                    .foregroundColor(.white)
            }
            .padding(.bottom, 20)
            
            Divider()
            Spacer()
        }
        .background(Color.red)
    }
}

struct vitalsView_Previews: PreviewProvider {
    static var previews: some View {
        vitalsView()
    }
}
