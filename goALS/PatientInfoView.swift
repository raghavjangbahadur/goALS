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
        let gender = model.patient.gender
        let age = model.patient.age
        let stage = model.patient.stage
        VStack {
            HStack {
                Text("Gender")
                    .foregroundColor(.teal)
                Spacer()
                Text(gender)
                    .foregroundColor(.teal)
            }
            .padding()
            HStack {
                Text("Age")
                    .foregroundColor(.teal)
                Spacer()
                Text(String(age))
                    .foregroundColor(.teal)
            }
            .padding()
            HStack {
                Text("Stage of ALS \n [Link for more info](https://alsnewstoday.com/stages-of-als/)")
                    .foregroundColor(.teal)
                Spacer()
                Text(stage)
                    .foregroundColor(.teal)
            }
            .padding()
        }
    }
    init() {
        model.getSingleData()
    }
}

struct PatientInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PatientInfoView()
    }
}
