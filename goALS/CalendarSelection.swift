//
//  AddEventView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 9/18/22.
//

import SwiftUI



struct CalendarSelectionKey: EnvironmentKey {
    static let defaultValue: Binding<Date?> = .constant(nil)
}

extension EnvironmentValues {
    var selectedDate: Binding<Date?> {
        get { return self[CalendarSelectionKey.self] }
        set { self[CalendarSelectionKey.self] = newValue }
    }

    func refresh() {
        let date = selectedDate.wrappedValue
        selectedDate.wrappedValue = nil
        selectedDate.wrappedValue = date
    }
}
