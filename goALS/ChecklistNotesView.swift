//
//  ChecklistNotesView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/19/22.
//

import SwiftUI

struct ChecklistNotesView: View {
    let item: ChecklistItem?
    
    init(item: ChecklistItem?) {
        self.item = item
    }
    
    var body: some View {
        VStack {
            Text("Notes")
                .font(.title)
                .padding(20)
            Text(item?.notes ?? "")
            Spacer()
        }
    }
}

/*struct ChecklistNotesView_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistNotesView(model: PatientInfoModel(item: ChecklistItem))
    }
}*/
