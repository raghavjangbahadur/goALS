//
//  Message.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/22/22.
//
import Foundation
import Firebase
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct Message: Identifiable, Codable {

    var id: String { documentId }

    let documentId: String
    let fromId, toId, text: String
    let time: Date

    init(documentId: String, data: [String: Any], stamp: Timestamp) {
        self.documentId = documentId
        self.fromId = data["fromId"] as? String ?? ""
        self.toId = data["toId"] as? String ?? ""
        self.text = data["text"] as? String ?? ""
        self.time = stamp.dateValue()
    }
}

extension Message: Equatable, Hashable {}
