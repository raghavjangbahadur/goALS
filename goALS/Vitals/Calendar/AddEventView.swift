//
//  AddEventView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 9/18/22.
//

import SwiftUI



struct AddEventView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.selectedDate) var selectedDate
    
    @ObservedObject var model: EventModel
    
    let date: String
    
    @State private var end = Date()
    @State private var start = Date()
    
    init(date: String, model: EventModel) {
        self.date = date
        self.model = model
    }
    
    @State var title = ""
    @State var description = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: self.$title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding(.horizontal, 10)
                    .padding(.top, 20)
                TextField("Description", text: self.$description)
                    .textFieldStyle(.roundedBorder)
                    .frame(height: 40)
                    .autocapitalization(.none)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                DatePicker("Start Time: ", selection: $start, displayedComponents: .hourAndMinute)
                    .colorScheme(.dark)
                    .padding(.horizontal, 10)
                DatePicker("End Time: ", selection: $end, in: start..., displayedComponents: .hourAndMinute)
                    .padding(.horizontal, 10)
                    .colorScheme(.dark)
                Spacer()
            }
            .background(Color.black.opacity(0.6).ignoresSafeArea(.all))
            .cornerRadius(13)
            .shadow(color: Color.black.opacity(0.5), radius: 10)
            .padding(5)
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
                        addItem(title, description, date, start, end) { _ in
                            presentationMode.wrappedValue.dismiss()
                            // reload
                            let date = selectedDate.wrappedValue
                            selectedDate.wrappedValue = date
                        }
                    } label: {
                        Text("Add event")
                    }
                }
            }
        }
    }
    
    func addItem(_ title: String,
                 _ description: String,
                 _ date: String,
                 _ start: Date,
                 _ end: Date,
                 completion: (([Event]) -> Void)? = nil) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let newStart = dateFormatter.string(from: start)
        let newEnd = dateFormatter.string(from: end)
        model.addEvent(title, description, date, newStart, newEnd, completion: completion)
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView(date: "12/02/2022", model: EventModel())
    }
}
