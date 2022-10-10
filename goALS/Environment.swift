//
//  goALSApp.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 6/28/22.
//

import SwiftUI

struct RootPresentationModeKey: EnvironmentKey {
    static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

extension EnvironmentValues {
    var rootPresentationMode: Binding<RootPresentationMode> {
        get { return self[RootPresentationModeKey.self] }
        set { self[RootPresentationModeKey.self] = newValue }
    }
}

typealias RootPresentationMode = Bool

extension RootPresentationMode {
    
    public mutating func dismiss() {
        self.toggle()
    }
}

struct CalendarDateSelectionKey: EnvironmentKey {
    static let defaultValue: Binding<Date?> = .constant(nil)
}

extension EnvironmentValues {
    var selectedDate: Binding<Date?> {
        get { return self[CalendarDateSelectionKey.self] }
        set { self[CalendarDateSelectionKey.self] = newValue }
    }
}

extension Binding where Value == Bool {
    var not: Binding<Value> {
        Binding<Value>(
            get: { !self.wrappedValue },
            set: { self.wrappedValue = !$0 }
        )
    }
}
