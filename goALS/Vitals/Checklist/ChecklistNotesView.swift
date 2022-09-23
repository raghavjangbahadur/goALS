//
//  ChecklistNotesView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/19/22.
//

import SwiftUI

struct ChecklistNotesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var model = PatientInfoModel()
    @State var shouldDelete = false
    
    let item: ChecklistItem?
    
    init(item: ChecklistItem?) {
        self.item = item
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item?.notes ?? "")
                .font(.title)
                .foregroundColor(Color.white)
                .padding(20)
            Text(item?.notes ?? "")
                .foregroundColor(Color.white)
            Divider()
            Spacer()
        }
        .padding()
        .background(Color.black.opacity(0.6).ignoresSafeArea(.all))
        .cornerRadius(13)
        .shadow(color: Color.black.opacity(0.5), radius: 10)
        .padding(5)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if item != nil {
                        shouldDelete.toggle()
                    }
                }, label: {
                    Text("Delete item")
                        .foregroundColor(Color.red)
                })
            }
        }
        .actionSheet(isPresented: $shouldDelete) {
            .init(title: Text("Are you sure you want to delete this item?") , buttons: [
                .destructive(Text("Delete"), action: {
                    model.deleteCheckListItem(item!)
                    presentationMode.wrappedValue.dismiss()
                    print("handle exit")
                }),
                .cancel()
            ])
        }
        
    }
}

struct ChecklistNotesView_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistNotesView(item: ChecklistItem(id: "", patientId: "", name: "", notes: ""))
    }
}
