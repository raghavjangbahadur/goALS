//
//  AddChecklistItemView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 10/17/22.
//

import SwiftUI

struct AddChecklistItemView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var model: PatientInfoModel
    
    init(model: PatientInfoModel) {
        self.model = model
    }
    
    @State var name : String = ""
    @State var notes : String = ""
    
    var body: some View {
        VStack{
            Text("Add Item to Checklist")
                .fontWeight(.bold)
                .padding(20)
                .font(.system(size: 20))
            VStack() {
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                    .frame(alignment: .leading)
                TextField("Notes (activites, times, etc.)", text: $notes)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .frame(alignment: .leading)
                    .padding(.bottom, 20)
                Button(action: {
                    if(name == "") {
                        model.checklistErrorMessage = "Please enter checklist item name"
                    }
                    else {
                        model.addChecklistItem(name, notes)
                        name = ""
                        notes = ""
                        presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    Text("Add")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .padding(10)
                        .padding(.horizontal)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(Color("DeepRed"))
                        )
                })
                .padding(10)
                
                Text(model.checklistErrorMessage)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.red)
                    .padding(.bottom, 10)
                
                Spacer()
            }
        }
        .onAppear {
            model.getSingleData()
            model.getChecklist()
        }
    }
}

struct AddChecklistItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddChecklistItemView(model: PatientInfoModel())
    }
}
