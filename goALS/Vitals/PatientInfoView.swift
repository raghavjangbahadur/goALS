//
//  PatientInfoView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/9/22.
//

import SwiftUI

struct PatientInfoView: View {
    
    @ObservedObject var model: PatientInfoModel
    
    init(model: PatientInfoModel) {
        self.model = model
    }
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Gender")
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Text(model.patient.gender)
                        .foregroundColor(Color("DarkGrey"))
                        .frame(width: 70)
                }
                .padding(10)
                HStack {
                    Text("Age")
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Text(String(model.patient.age))
                        .foregroundColor(Color("DarkGrey"))
                        .frame(width: 70)
                }
                .padding(10)
                HStack {
                    Text("[Stage of ALS](https://alsnewstoday.com/stages-of-als/)")
                        .accentColor(.blue)
                    Spacer()
                    Text(model.patient.stage)
                        .foregroundColor(Color("DarkGrey"))
                        .frame(width: 70)
                }
                .padding(10)
                HStack {
                    Text("Use of feeding tube")
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Text(model.patient.tube)
                        .foregroundColor(Color("DarkGrey"))
                        .frame(width: 70)
                }
                .padding(10)
                HStack {
                    Text("Hand strength/control (clumsiness, inability to hold items, difficulty, etc)")
                        .foregroundColor(Color("DarkGrey"))
                    
                    Spacer()
                    Text(model.patient.hands)
                        .foregroundColor(Color("DarkGrey"))
                        .frame(width: 70)
                }
                .padding(10)
                HStack {
                    Text("Speech issues (slurring, trouble speaking clearly")
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Text(model.patient.speech)
                        .foregroundColor(Color("DarkGrey"))
                        .frame(width: 70)
                }
                .padding(10)
                HStack {
                    Text("Muscle cramp/twitches")
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Text(model.patient.muscles)
                        .foregroundColor(Color("DarkGrey"))
                        .frame(width: 70)
                }
                .padding(10)
                HStack {
                    Text("Difficulty walking without tripping/falling")
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Text(model.patient.walking)
                        .foregroundColor(Color("DarkGrey"))
                        .frame(width: 70)
                }
                .padding(10)
                HStack {
                    Text("Weakness in legs, feet, hands, or fingers")
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Text(model.patient.legs)
                        .foregroundColor(Color("DarkGrey"))
                        .frame(width: 70)
                    
                }
                .padding(10)
                HStack {
                    Text("Difficult breathing")
                        .foregroundColor(Color("DarkGrey"))
                    Spacer()
                    Text(model.patient.breathing)
                        .foregroundColor(Color("DarkGrey"))
                        .frame(width: 70)
                }
                .padding(10)
            }.onAppear {
                model.getSingleData()
            }
            .navigationTitle("Key Details and Information")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(.white)
        }
        NavigationLink(destination: PatientInfoEditView(), label: {
            Text("Update")
                .foregroundColor(Color.white)
                .fontWeight(.bold)
                .padding(10)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color("DeepRed"))
                )
        })
        .padding()
        
    }
}

struct PatientInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PatientInfoView(model: PatientInfoModel())
    }
}
