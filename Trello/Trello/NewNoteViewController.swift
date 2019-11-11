//
//  NewNoteViewController.swift
//  Trello
//
//  Created by Onie on 10.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import UIKit


class NewNoteViewController: UIViewController {
    
    
    let noteService = NoteService.shared
    
    let textField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        textField.frame = view.frame
        view.addSubview(textField)
        
        let saveBarItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
        navigationController?.viewControllers[1].navigationItem.rightBarButtonItem = saveBarItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    @objc
    func saveNote(){
       // NoteViewController.notesCount =  NoteViewController.notesCount + 1
        if let temp = textField.text {
            noteService.notes.append(temp)
        }
        textField.resignFirstResponder()
        navigationController?.popViewController(animated: true)
    }
}

