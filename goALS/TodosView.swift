//
//  TodosView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/14/22.
//

import SwiftUI

struct TodosView: View {
    
    @ObservedObject var model = PatientInfoModel()
    @State var name : String = ""
    @State var notes : String = ""
    
    var body: some View {
        VStack {
            List (model.checklist) { item in
                NavigationLink {
                    ChecklistNotesView(item: item)
                } label: {
                    HStack {
                        Text(item.name)
                        Spacer()
                        Button(action: {
                            model.deleteCheckListItem(item)
                        }, label: {
                            Image(systemName: "minus.circle")
                        })
                    }
                }
            }
            
            VStack(spacing: 5) {
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                TextField("Notes (activites, times, etc.)", text: $notes)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                Button(action: {
                    model.addChecklistItem(name, notes)
                    name = ""
                    notes = ""
                }, label: {
                    Text("Add item to checklist")
                })
                .padding()
            }
        }
        .onAppear {
            model.getSingleData()
            model.getChecklist()
        }
    }
}

struct TodosView_Previews: PreviewProvider {
    static var previews: some View {
        TodosView()
    }
}

