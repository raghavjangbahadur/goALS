//
//  PatientInfo.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/9/22.
//

import Foundation

struct PatientInfo: Identifiable, Codable {
    var id: String
    var name: String
    var gender: String
    var age: Int
    var stage: String
    var tube: String
    var hands: String
    var speech: String
    var muscles: String
    var walking: String
    var legs: String
    var breathing: String
}
