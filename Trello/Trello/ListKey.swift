//
//  ListKey.swift
//  Trello
//
//  Created by Погос  on 17.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import UIKit

struct ModelList: Codable {
    let name: String
    var cards: [Card?]
    var lists: [List?]
}

struct List: Codable {
    let name: String
    let id: String?
    let idBoard: String
}

struct Card: Codable {
    let name: String
    let idList: String
}

