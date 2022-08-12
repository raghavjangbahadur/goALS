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
    
    var body: some View {
        
        
        VStack {
            HStack {
                Text("Gender")
                    .foregroundColor(.teal)
                Spacer()
                TextField("New Gender", text: self.$newGender)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom)
            }
            .padding()
            HStack {
                Text("Age")
                    .foregroundColor(.teal)
                Spacer()
                TextField("New Age", text: self.$newAge)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom)
            }
            .padding()
            HStack {
                Text("Stage of ALS \n [Link for more info](https://alsnewstoday.com/stages-of-als/)")
                    .foregroundColor(.teal)
                Spacer()
                TextField("New Stage", text: self.$newStage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .padding(.bottom)
            }
            .padding()
            Button("Update data", action: updateData)
                .padding(.bottom)
        }
    }
    
    init() {
        model.getSingleData()
    }
    
    func updateData() {
        if newGender != "" {
            model.updateDataString("patientGender", newGender)
        }
        if newAge != "" {
            model.updateDataInt("patientAge", Int(newAge) ?? 0)
        }
        if newStage != "" {
            model.updateDataString("stage", newStage)
        }
    }
}

struct PatientInfoEditView_Previews: PreviewProvider {
    static var previews: some View {
        PatientInfoEditView()
    }
}
