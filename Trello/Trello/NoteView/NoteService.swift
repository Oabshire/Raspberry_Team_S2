//
//  NoteService.swift
//  Trello
//
//  Created by Konstantin Nikandrov on 11.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import Foundation

struct NoteFromBase:Decodable{
    var imageURL: String
    let text: String
}

class NoteService {
    static var shared: NoteService = {
        let instance = NoteService()
        
        return instance
    }()
	public var notes: [Note] = []
    public var isEdit: Bool = false
}
