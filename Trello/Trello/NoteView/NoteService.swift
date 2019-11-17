//
//  NoteService.swift
//  Trello
//
//  Created by Konstantin Nikandrov on 11.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import Foundation

struct NoteFromBase: Codable{
    var imageURL: String
    var text: String
}

class NoteService {
    static var shared: NoteService = {
        let instance = NoteService()
        
        return instance
    }()
	public var notes: [Note] = []
    public var isEdit: Bool = false
}

//
//  NoteModel.swift
//  Trello
//
//  Created by Onie on 15.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//


import UIKit

struct Note {
    var text: String
    var image: UIImage? //Data?
	var imageURL: String
    
	init(text: String, image: UIImage?, imageURL: String) {
        //self.init()
        self.text = text
        self.image = image
		self.imageURL = imageURL
    }
}

