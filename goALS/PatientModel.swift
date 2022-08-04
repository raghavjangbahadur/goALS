//
//  PatientModel.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/3/22.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class PatientModel: ObservableObject {
    @Published var gender: String = ""
    @Published var age: Int = 0
    @Published var stage: String = ""
    @Published var uuid: String = ""
    //need to add a lot more, need to figure out how exactly to store data, sliders, etc.
    
    func patientInit() {
        let dbs = Firestore.firestore()
        
        
        
    }
    
    
}
