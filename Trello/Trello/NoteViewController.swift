//
//  NoteViewController.swift
//  Trello
//
//  Created by Onie on 10.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//


import UIKit

class NoteViewController: UIViewController {
    
    let noteService = NoteService.shared
    
    
    public static var notesCount = 0
    public let tableView = UITableView()
    
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
        
        navigationController?.viewControllers[0].title = "Заметки (\(noteService.notes.count))"
        view.backgroundColor = .green
        
        
        tableView.frame = view.frame
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseId)
        
    }
	
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.viewControllers[0].title = "Заметки (\(noteService.notes.count))"
        let NewCellIndexPath = IndexPath(row: noteService.notes.count-1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [NewCellIndexPath], with: .automatic)
        tableView.endUpdates()
        tableView.reloadData()
    }
    
    
    @objc
    func itemPressed() {
        let newNoteVC = NewNoteViewController()

        navigationController?.pushViewController(newNoteVC, animated: true)
		
    }
}

extension NoteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseId, for: indexPath) as! TableViewCell
        let note = noteService.notes[indexPath.row]
        cell.noteLabel.text = note
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteService.notes.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension NoteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newNoteVC = NewNoteViewController()
        
        
       // newNoteVC.textField = tableView. как то передать текст строки в данной строчке 
        navigationController?.pushViewController(newNoteVC, animated: true)
    }
}
