//
//  NoteViewController.swift
//  Trello
//
//  Created by Onie on 10.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//


import UIKit

class NoteViewController: UIViewController {
    
    public static var notesCount = 0
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(itemPressed))
        navigationController?.viewControllers[0].navigationItem.rightBarButtonItem = barItem
        
        navigationController?.viewControllers[0].title = "Заметки (\(NoteViewController.notesCount))"
        view.backgroundColor = .green
        
    }
    
    @objc
    func itemPressed() {
        let newNoteVC = NewNoteViewController()
        navigationController?.pushViewController(newNoteVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        navigationController?.viewControllers[0].title = "Заметки (\(NoteViewController.notesCount))"
    }
    
    
}
