//
//  PatientInfoView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/9/22.
//

import SwiftUI

struct PatientInfoView: View {
    
    @ObservedObject var model = PatientInfoModel()
    var body: some View {
        VStack {
            HStack {
                Text("Gender")
                    .foregroundColor(.teal)
                Spacer()
                Text(model.patient.gender)
                    .foregroundColor(.teal)
            }
            .padding()
            HStack {
                Text("Age")
                    .foregroundColor(.teal)
                Spacer()
                Text(String(model.patient.age))
                    .foregroundColor(.teal)
            }
            .padding()
            HStack {
                Text("Stage of ALS \n [Link for more info](https://alsnewstoday.com/stages-of-als/)")
                    .foregroundColor(.teal)
                Spacer()
                Text(model.patient.stage)
                    .foregroundColor(.teal)
            }
            NavigationLink("Update basic information") {
                PatientInfoEditView(model: PatientInfoModel())
                    .navigationBarBackButtonHidden(true)
                    .padding(.bottom, 30)
            }
            .padding()
        }.onAppear {
            model.getSingleData()
        }
    }
}

struct PatientInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PatientInfoView()
    }
}
