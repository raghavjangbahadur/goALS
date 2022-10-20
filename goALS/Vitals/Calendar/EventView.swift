//
//  EventView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 9/18/22.
//

import SwiftUI

struct EventView: View {
    
    @ObservedObject var model: EventModel
    
    @State var shouldShowAddView = false
    
    @State var shouldShowDetail = false
    
    let date: Date
    
    let stringified: String

    init(date: Date, model: EventModel) {
        self.date = date
        self.model = model
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        stringified = dateFormatter.string(from: date)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    shouldShowAddView.toggle()
                } label: {
                    Image(systemName: "plus")
                }.sheet(isPresented: $shouldShowAddView){
                    AddEventView(date: stringified, model: model)
                }
            }
            .padding(5)
            List (model.events) { event in
                NavigationLink {
                    EventItemView(event: event, model: model)
                } label: {
                    HStack {
                        Text(event.title)
                        Spacer()
                        Text(event.startTime + "-" + event.endTime)
                            .font(.system(size: 13))
                    }
                }
            }
            
        }
        .onAppear {
            model.getEvents(date: stringified)
        }
        .background(Color("DeepRed").opacity(0.5))
        .padding(.trailing, 5)
        .padding(.bottom)
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(date: Date(), model: EventModel())
    }
}
