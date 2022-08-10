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
    
}
