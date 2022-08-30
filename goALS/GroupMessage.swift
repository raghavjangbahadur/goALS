//
//  GroupMessage.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/29/22.
//

import Foundation

struct GroupMessage: Identifiable, Codable {

    var id: String { documentId }

    let documentId: String
    let fromId, text: String

    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.fromId = data["fromId"] as? String ?? ""
        self.text = data["text"] as? String ?? ""
    }
}
