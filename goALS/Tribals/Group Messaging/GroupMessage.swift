//
//  GroupMessage.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/29/22.
//

import Foundation
import FirebaseFirestore

struct GroupMessage: Identifiable, Codable {

    var id: String { documentId }

    let documentId: String
    let fromId, text: String
    let firstName, lastName: String
    let time: Date

    init(documentId: String, data: [String: Any], stamp: Timestamp) {
        self.documentId = documentId
        self.fromId = data["fromId"] as? String ?? ""
        self.text = data["text"] as? String ?? ""
        self.firstName = data["firstName"] as? String ?? ""
        self.lastName = data["lastName"] as? String ?? ""
        self.time = stamp.dateValue()
    }
}
