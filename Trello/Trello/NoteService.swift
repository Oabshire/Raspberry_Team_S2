//
//  NoteService.swift
//  Trello
//
//  Created by Konstantin Nikandrov on 11.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import Foundation

class NoteService {
    static var shared: NoteService = {
        let instance = NoteService()
        
        return instance
    }()
	public var notes: [String] = []
    public var isEdit: Bool = false
}
