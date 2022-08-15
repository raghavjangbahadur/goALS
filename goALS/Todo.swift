//
//  Todo.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/14/22.
//

import Foundation

struct Todo: Codable, Identifiable {
    var id : String
    var name : String
    var notes : String
}
