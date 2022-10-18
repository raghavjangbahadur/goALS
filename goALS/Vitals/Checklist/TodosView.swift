//
//  TodosView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/14/22.
//

import SwiftUI

struct TodosView: View {
    
    @ObservedObject var model: PatientInfoModel
    @State var name : String = ""
    @State var notes : String = ""
    
    @State var shouldShowAddView = false
    
    init(model: PatientInfoModel) {
        self.model = model
    }
    
    var body: some View {
        VStack {
            List (model.checklist) { item in
                NavigationLink {
                    ChecklistNotesView(item: item)
                } label: {
                    HStack {
                        Text(item.name)
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Checklist")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarColor(.white)
        .accentColor(.red)
        .onAppear {
            model.getSingleData()
            model.getChecklist()
        }
        .sheet(isPresented: $shouldShowAddView, content: {
            AddChecklistItemView(model: model)
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    shouldShowAddView.toggle()
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
    }
}

struct TodosView_Previews: PreviewProvider {
    static var previews: some View {
        TodosView(model: PatientInfoModel())
    }
}
