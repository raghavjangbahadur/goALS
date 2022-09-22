//
//  Event.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 9/18/22.
//

import Foundation

struct Event: Codable, Identifiable, Hashable {
    var id: String
    var title : String
    var description : String
    var date: String
    var startTime: String
    var endTime: String
}
