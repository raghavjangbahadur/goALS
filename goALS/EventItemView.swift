//
//  EventItemView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 9/18/22.
//

import SwiftUI

struct EventItemView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var model: EventModel
    
    @State var shouldDelete = false
    
    let event: Event
    
    init(event: Event, model: EventModel) {
        self.event = event
        self.model = model
    }
    
    @State var deletedEvent = Event(id: "", title: "", description: "", date: "", startTime: "", endTime: "")
    @State var deletedDate = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Description")
                    .font(.headline)
                Text(event.description)
                    .padding(.bottom, 20)
                HStack {
                    Text("Starts:")
                    Text(event.startTime)
                    Spacer()
                }
                HStack {
                    Text("Ends:")
                    Text(event.endTime)
                    Spacer()
                }
                Spacer()
                Button(action: {
                    deletedEvent = event
                    deletedDate = event.date
                    shouldDelete.toggle()
                }, label: {
                    Text("Delete event")
                })
            }
            .padding(10)
            .navigationTitle(event.title)
        }
        .actionSheet(isPresented: $shouldDelete) {
            .init(title: Text("Are you sure you want to delete this event?") , buttons: [
                .destructive(Text("Delete"), action: {
                    model.deleteEvent(deletedEvent, deletedDate)
                    presentationMode.wrappedValue.dismiss()
                    print("handle exit")
                }),
                .cancel()
            ])
        }
    }
}


/*struct EventItemView_Previews: PreviewProvider {
    static var previews: some View {
        EventItemView(event: nil)
    }
}*/
