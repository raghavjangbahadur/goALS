//
//  PatientInfoEditView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/9/22.
//
import SwiftUI

struct PatientInfoEditView: View {
    
    @ObservedObject var model = PatientInfoModel()
    
    @State private var newGender: String = ""
    @State private var newStage: String = ""
    @State private var newAge: String = ""
    @State private var tube: String = ""
    @State private var hands: String = ""
    @State private var speech: String = ""
    
    var body: some View {
        ScrollView {
            Text("Edit patient information")
                .foregroundColor(.teal)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 10)
            VStack {
                Text("Basic Information")
                    .fontWeight(.bold)
                    .padding(10)
                TextField("Gender", text: self.$newGender)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom)
                TextField("Age", text: self.$newAge)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom)
                TextField("Stage", text: self.$newStage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom)
                Text("Key Symptoms")
                    .fontWeight(.bold)
                    .padding(10)
                Text("Use of feeding tube (high/medium/low/etc.)")
                    .padding(.horizontal, 5)
                TextField("Enter", text: self.$tube)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom)
                Text("Hand strength/control, clumsiness, inability to hold items, difficulty, etc")
                    .padding(.horizontal, 5)
                TextField("Enter", text: self.$hands)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom)
                Text("Speech issues (slurring, trouble speaking clearly")
                    .padding(.horizontal, 3)
                /*TextField("Enter", text: self.$speech)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom)*/
            }.onAppear {
                model.getSingleData()
            }
        }
        Button("Update", action: updateData)
            .padding(.bottom)
    }
    func updateData() {
        var values = [String: Any]()
        if newGender != "" {
            values["patientGender"] = newGender
        }
        if newAge != "" {
            values["patientAge"] = Int(newAge) ?? 0
        }
        if newStage != "" {
            values["stage"] = newStage
        }
        if tube != "" {
            values["feedingTube"] = tube
        }
        if hands != "" {
            values["hands"] = hands
        }
        if speech != "" {
            values["speech"] = speech
        }
        if !values.isEmpty {
            model.updateData(values)
        }
    }
}

struct PatientInfoEditView_Previews: PreviewProvider {
    static var previews: some View {
        PatientInfoEditView()
    }
}
