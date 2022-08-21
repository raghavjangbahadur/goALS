//
//  ChecklistNotesView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/19/22.
//

import SwiftUI

struct ChecklistNotesView: View {
    @ObservedObject var model = PatientInfoModel()
    var body: some View {
        Text("s")
    }
}

struct ChecklistNotesView_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistNotesView(model: PatientInfoModel())
    }
}
