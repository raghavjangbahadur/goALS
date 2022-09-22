//
//  Todo.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/14/22.
//

import Foundation

struct ChecklistItem: Codable, Identifiable {
    var id: String
    var patientId : String
    var name : String
    var notes : String
}
