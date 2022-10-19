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
        VStack(alignment: .leading) {
            Text(event.title)
                .font(.system(size: 30))
                .foregroundColor(Color("DarkGrey"))
                .padding(.bottom, 0.1)
            Text(event.date + " from " + event.startTime + " to " + event.endTime)
                .foregroundColor(Color("DarkGrey"))
                .font(.system(size: 15))
            Divider()
            Text(event.description)
                .foregroundColor(Color("DarkGrey"))
                .padding(.bottom, 20)
            Spacer()
        }
        .padding(25)
        .navigationTitle("Event Details")
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    deletedEvent = event
                    deletedDate = event.date
                    shouldDelete.toggle()
                }, label: {
                    Text("Delete event")
                        .foregroundColor(Color.red)
                })
            }
        }
    }
}


struct EventItemView_Previews: PreviewProvider {
    static var previews: some View {
        EventItemView(event: Event(id: "", title: "Meeting", description: "Go to work", date: "", startTime: "2:30", endTime: "3:00"), model: EventModel())
    }
}
