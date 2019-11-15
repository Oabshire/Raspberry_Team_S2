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
    var image :Data?
    
    init(text: String, image: Data!) {
        //self.init()
        self.text = text
        self.image = image
    }
};

