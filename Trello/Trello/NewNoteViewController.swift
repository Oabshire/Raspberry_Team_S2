//
//  NewNoteViewController.swift
//  Trello
//
//  Created by Onie on 10.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import UIKit

class NewNoteViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        let saveBarItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
        navigationController?.viewControllers[1].navigationItem.rightBarButtonItem = saveBarItem
    }
    
    @objc
    func saveNote(){
        NoteViewController.notesCount =  NoteViewController.notesCount + 1
        navigationController?.popViewController(animated: true)
    }
}

