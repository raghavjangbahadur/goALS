//
//  Message.swift
//  goALS
//
//  Created by Raghav Jangbahadur on 8/22/22.
//

import Foundation

struct Message: Identifiable, Codable {

    var id: String { documentId }

    let documentId: String
    let fromId, toId, text: String
    //let time: Date

    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.fromId = data["fromId"] as? String ?? ""
        self.toId = data["toId"] as? String ?? ""
        self.text = data["text"] as? String ?? ""
    }
}

extension Message: Equatable, Hashable {}
