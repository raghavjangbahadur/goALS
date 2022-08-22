//
//  User.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/22/22.
//

import Foundation

struct User: Codable {
    var uuid: String
    var firstName: String
    var lastName: String
    var patientID: String
    var patientName: String
}
