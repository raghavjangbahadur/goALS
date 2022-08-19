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
            TextField("Update use of feeding tube (high/medium/low)", text: self.$tube)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 10)
                .autocapitalization(.none)
                .padding(.bottom)
            Button("Update", action: updateData)
                .padding(.bottom)
        }.onAppear {
            model.getSingleData()
        }
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
