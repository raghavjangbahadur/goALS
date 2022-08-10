//
//  PatientInfoEditView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/9/22.
//

import SwiftUI

struct PatientInfoEditView: View {
    
    @ObservedObject var model = PatientInfoModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    init() {
        model.getSingleData()
    }
}

struct PatientInfoEditView_Previews: PreviewProvider {
    static var previews: some View {
        PatientInfoEditView()
    }
}
