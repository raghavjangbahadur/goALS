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
            Text("Key Details and Information")
                .foregroundColor(Color("DarkGrey"))
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 15)
                .padding(.bottom, 20)
            List {
                HStack {
                    Text("Gender")
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Text(model.patient.gender)
                        .foregroundColor(Color("DarkGrey"))                }
                .padding(10)
                HStack {
                    Text("Age")
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Text(String(model.patient.age))
                        .foregroundColor(Color("DarkGrey"))
                }
                .padding(10)
                HStack {
                    Text("[Stage of ALS](https://alsnewstoday.com/stages-of-als/)")
                        .accentColor(.blue)
                    Spacer()
                    Text(model.patient.stage)
                        .foregroundColor(Color("DarkGrey"))
                }
                .padding(10)
                HStack {
                    Text("Use of feeding tube")
                        .frame(width: 150)
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Text(model.patient.tube)
                        .foregroundColor(Color("DarkGrey"))
                }
                .padding(10)
                HStack {
                    Text("Hand strength/control (clumsiness, inability to hold items, difficulty, etc)")
                        .foregroundColor(Color("DarkGrey"))
                        .frame(width: 170)
                    
                    Spacer()
                    Text(model.patient.hands)
                        .foregroundColor(Color("DarkGrey"))
                }
                .padding(10)
                HStack {
                    Text("Speech issues (slurring, trouble speaking clearly")
                        .frame(width: 185)
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Text(model.patient.speech)
                        .foregroundColor(Color("DarkGrey"))
                }
                .padding(10)
                HStack {
                    Text("Muscle cramp/twitches")
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Text(model.patient.muscles)
                        .foregroundColor(Color("DarkGrey"))
                }
                .padding(10)
                HStack {
                    Text("Difficulty walking without tripping/falling")
                        .frame(width: 170)
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Text(model.patient.walking)
                        .foregroundColor(Color("DarkGrey"))
                }
                .padding(10)
                HStack {
                    Text("Weakness in legs, feet, hands, or fingers")
                        .frame(width: 190)
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Text(model.patient.legs)
                        .foregroundColor(Color("DarkGrey"))
                }
                .padding(10)
                HStack {
                    Text("Difficult breathing")
                        .frame(width: 170)
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Text(model.patient.breathing)
                        .foregroundColor(Color("DarkGrey"))
                }
                .padding(10)
            }.onAppear {
                model.getSingleData()
            }
        }
        NavigationLink(destination: PatientInfoEditView(), label: {
            Text("Update basic information")
                .foregroundColor(Color.white)
                .fontWeight(.bold)
                .padding(10)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color("DeepRed"))
                )
        })
        .padding(.bottom, 20)
        .accentColor(Color("DeepRed"))
    }
}

struct PatientInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PatientInfoView()
    }
}
