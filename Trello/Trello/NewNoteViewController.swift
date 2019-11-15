//
//  NewNoteViewController.swift
//  Trello
//
//  Created by Onie on 10.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import UIKit


class NewNoteViewController: UIViewController {
    
    var tеmpIndex = 0
    let noteService = NoteService.shared
    let noteVC = NoteViewController()
    
    let textField = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        textField.frame = view.frame
        textField.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		textField.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(textField)
        
        let saveBarItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
        navigationController?.viewControllers[1].navigationItem.rightBarButtonItem = saveBarItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    @objc
    func saveNote(){
        if noteService.isEdit {
            if let temp = textField.text {
                noteVC.noteService.notes[tеmpIndex] = temp
            }
        } else {
            if let temp = textField.text {
                noteService.notes.append(temp)
            }
        }
        
       
        textField.resignFirstResponder()
        noteService.isEdit = false
        navigationController?.popViewController(animated: true)
    }
}

