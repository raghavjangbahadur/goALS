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
            TextField("Update Gender", text: self.$newGender)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 10)
                .autocapitalization(.none)
                .padding(.bottom)
            
            TextField("Update Age", text: self.$newAge)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 10)
                .autocapitalization(.none)
                .padding(.bottom)
            TextField("Update Stage", text: self.$newStage)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 10)
                .autocapitalization(.none)
                .padding(.bottom)
            Button("Update data", action: updateData)
                .padding(.bottom)
        }.onAppear {
            model.getSingleData()
        }
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
