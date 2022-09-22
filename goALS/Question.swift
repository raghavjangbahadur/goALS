//
//  Question.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 9/21/22.
//

import Foundation
 
struct Question: Identifiable, Codable {
    
    var id: String?
    var question: String?
    var option1: String?
    var option2: String?
    var answer: String?
    var submitted = false
    var completed = false
    
}
