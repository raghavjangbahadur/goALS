//
//  Calendar.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 9/12/22.
//

import SwiftUI
import ElegantCalendar

struct Calendar: View {
    
    @ObservedObject var calendarManager: MonthlyCalendarManager
    @ObservedObject var model = EventModel()

    init() {
        let startDate = Date()
        let endDate = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (30 * 36)))
        let configuration = CalendarConfiguration(startDate: startDate, endDate: endDate)
        calendarManager = MonthlyCalendarManager(configuration: configuration)
        calendarManager.datasource = self
        model.getTotalEvents()
    }
    
    var progressView: some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                Spacer()
            }
            Spacer() // VStack bottom spacer
        }
        .frame(maxWidth: .infinity)
        .navigationBarHidden(true)
    }

    var body: some View {
        if model.loaded {
            MonthlyCalendarView(calendarManager: calendarManager)
                .theme(CalendarTheme(primary: Color("DeepRed"),
                                     todayTextColor: nil,
                                     todayBackgroundColor: Color("DeepRed").opacity(model.returnOpacity(date: Date()))))
                .navigationTitle("Calendar")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarColor(.white)
        }
        else {
            progressView
        }
    }
}

extension Calendar: MonthlyCalendarDataSource {

    func calendar(backgroundColorOpacityForDate date: Date) -> Double {
        return model.returnOpacity(date: date)
    }

    func calendar(canSelectDate date: Date) -> Bool {
        return true
    }

    func calendar(viewForSelectedDate date: Date, dimensions size: CGSize) -> AnyView {
        AnyView(EventView(date: date, model: model).environment(\.selectedDate, self.$calendarManager.selectedDate)
            .frame(maxHeight: (size.height - 80))
            .offset(x: -10))
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        Calendar()
    }
}
