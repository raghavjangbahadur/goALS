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
    @State private var calendarTheme: CalendarTheme = CalendarTheme(primary: Color("DeepRed"))
    @ObservedObject var model = EventModel()

    init() {
        let startDate = Date()
        let endDate = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (30 * 36)))
        let configuration = CalendarConfiguration(startDate: startDate, endDate: endDate)
        calendarManager = MonthlyCalendarManager(configuration: configuration)
        calendarManager.datasource = self
    }

    var body: some View {
        MonthlyCalendarView(calendarManager: calendarManager)
            .theme(calendarTheme)
            .navigationTitle("Calendar")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(.white)
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
            .offset(x: -7))
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        Calendar()
    }
}
