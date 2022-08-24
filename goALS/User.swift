//
//  User.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/22/22.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String
    var firstName: String
    var lastName: String
    var patientID: String
    var patientName: String
    var email: String
}
