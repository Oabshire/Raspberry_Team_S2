//
//  ModelCollection.swift
//  Trello
//
//  Created by Погос  on 18.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import Foundation

final class ModelCollection {

    var modelCollection: ModelList!
    
    static let shared = ModelCollection()
    
}

struct Model {
    var nodeTitle: String
    var nameCells: [String?]
}
