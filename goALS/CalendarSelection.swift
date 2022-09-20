//
//  AddEventView.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 9/18/22.
//

import SwiftUI

struct CalendarDateSelectionKey: EnvironmentKey {
    static let defaultValue: Binding<Date?> = .constant(nil)
}

extension EnvironmentValues {
    var selectedDate: Binding<Date?> {
        get { return self[CalendarDateSelectionKey.self] }
        set { self[CalendarDateSelectionKey.self] = newValue }
    }
}
