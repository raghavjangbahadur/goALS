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
            VStack {
                VStack(alignment: .leading) {
                    Text(event.title)
                        .foregroundColor(Color.white)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                    Text(event.description)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 20)
                    HStack {
                        Text(event.date + " from " + event.startTime + " to " + event.endTime)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    Spacer()
                }
                .padding(15)
                
                VStack{
                    Button(action: {
                        deletedEvent = event
                        deletedDate = event.date
                        shouldDelete.toggle()
                    }, label: {
                        Text("Delete event")
                            .foregroundColor(Color.red)
                    })
                }.padding(.bottom, 10)
            }
            .background(Color.black.opacity(0.7).ignoresSafeArea(.all))
            .cornerRadius(13)
            .shadow(color: Color.black.opacity(0.5), radius: 10)
            .padding(5)
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


struct EventItemView_Previews: PreviewProvider {
    static var previews: some View {
        EventItemView(event: Event(id: "", title: "Meeting", description: "", date: "", startTime: "2:30", endTime: "3:00"), model: EventModel())
    }
}
