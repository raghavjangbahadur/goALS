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
            List (model.todoList) { item in
                Text(item.name)
            }
            
            VStack(spacing: 5) {
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                TextField("Notes", text: $notes)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                Button(action: {
                    model.addTodoItem(name, notes)
                    name = ""
                    notes = ""
                }, label: {
                    Text("Add item todo")
                })
                .padding()
            }
        }
        .onAppear {
            model.getSingleData()
        }
    }
}

struct TodosView_Previews: PreviewProvider {
    static var previews: some View {
        TodosView()
    }
}
