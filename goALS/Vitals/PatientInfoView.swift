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
        ScrollView {
            Text("Key Details and Information")
                .foregroundColor(.teal)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 15)
                .padding(.bottom, 20)
            VStack{
                HStack {
                    Text("Gender")
                        .foregroundColor(.teal)
                    Spacer()
                    Text(model.patient.gender)
                        .foregroundColor(.teal)
                }
                .padding(10)
                HStack {
                    Text("Age")
                        .foregroundColor(.teal)
                    Spacer()
                    Text(String(model.patient.age))
                        .foregroundColor(.teal)
                }
                .padding(10)
                HStack {
                    Text("Stage of ALS \n [Link for more info](https://alsnewstoday.com/stages-of-als/)")
                        .foregroundColor(.teal)
                    Spacer()
                    Text(model.patient.stage)
                        .foregroundColor(.teal)
                }
                .padding(10)
                HStack {
                    Text("Use of feeding tube")
                        .frame(width: 150)
                        .foregroundColor(.teal)
                    Spacer()
                    Text(model.patient.tube)
                        .foregroundColor(.teal)
                }
                .padding(10)
                HStack {
                    Text("Hand strength/control (clumsiness, inability to hold items, difficulty, etc)")
                        .frame(width: 170)
                        .foregroundColor(.teal)
                    Spacer()
                    Text(model.patient.hands)
                        .foregroundColor(.teal)
                }
                .padding(10)
                HStack {
                    Text("Speech issues (slurring, trouble speaking clearly")
                        .frame(width: 185)
                        .foregroundColor(.teal)
                    Spacer()
                    Text(model.patient.speech)
                        .foregroundColor(.teal)
                }
                .padding(10)
                HStack {
                    Text("Muscle cramp/twitches")
                        .foregroundColor(.teal)
                    Spacer()
                    Text(model.patient.muscles)
                        .foregroundColor(.teal)
                }
                .padding(10)
                HStack {
                    Text("Difficulty walking without tripping/falling")
                        .frame(width: 170)
                        .foregroundColor(.teal)
                    Spacer()
                    Text(model.patient.walking)
                        .foregroundColor(.teal)
                }
                .padding(10)
                HStack {
                    Text("Weakness in legs, feet, hands, or fingers")
                        .frame(width: 190)
                        .foregroundColor(.teal)
                    Spacer()
                    Text(model.patient.legs)
                        .foregroundColor(.teal)
                }
                .padding(10)
                HStack {
                    Text("Difficult breathing")
                        .frame(width: 170)
                        .foregroundColor(.teal)
                    Spacer()
                    Text(model.patient.breathing)
                        .foregroundColor(.teal)
                }
                .padding(10)
            }.onAppear {
                model.getSingleData()
            }
        }
        NavigationLink("Update basic information") {
            PatientInfoEditView(/*model: PatientInfoModel()*/)
                .padding(.bottom, 30)
        }
    }
}

struct PatientInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PatientInfoView()
    }
}
