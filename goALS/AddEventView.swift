//
//  AddEventView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 9/18/22.
//

import SwiftUI



struct AddEventView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var model = EventModel()
    
    let date: String
    
    @State private var end = Date()
    @State private var start = Date()
    
    init(date: String) {
        self.date = date
    }
    
    @State var title = ""
    @State var description = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: self.$title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                TextField("Description", text: self.$description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding(.bottom, 30)
                DatePicker("Start Time: ", selection: $start, displayedComponents: .hourAndMinute)
                DatePicker("End Time: ", selection: $end, displayedComponents: .hourAndMinute)
                Spacer()
            }
            .padding(10)
            .navigationTitle("New Event")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            addItem(title, description, date, start, end)
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Add event")
                        }
                    }
                }
        }
    }
    
    func addItem(_ title: String, _ description: String, _ date: String, _ start: Date, _ end: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let newStart = dateFormatter.string(from: start)
        let newEnd = dateFormatter.string(from: end)
        model.addEvent(title, description, date, newStart, newEnd)
    }
}

/*struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView(date: "")
    }
}*/
