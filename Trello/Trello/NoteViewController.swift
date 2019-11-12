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
    var dictOfHeight = [IndexPath : CGFloat]()
    var dictOfDefHeight = [IndexPath : CGFloat]()
    var firstTap = true
    
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
		self.tableView.estimatedRowHeight = 100.0
		self.tableView.rowHeight = UITableView.automaticDimension
    }
	
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.viewControllers[0].title = "Заметки (\(noteService.notes.count))"
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
		let width = cell.frame.size.width
		
		print(cell.noteLabel.frame)
		cell.noteLabel.sizeToFit()
		print(cell.noteLabel.frame)
		var height = cell.noteLabel.frame.size.height
        dictOfDefHeight[indexPath] = height
		height = (height < 100) ? height : 100
		cell.noteLabel.frame.size = CGSize(width: width, height: height)
		cell.frame.size = CGSize(width: width, height: height)
        print(cell.noteLabel.frame)
		print(cell.frame)
		
		dictOfHeight[indexPath] = height
		
		cell.accessoryType = .disclosureIndicator
        
        
        let showMoreTap = UITapGestureRecognizer(target: self, action: #selector(tapCenterOfCell(_:)))
        
        cell.contentView.addGestureRecognizer(showMoreTap)
		
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteService.notes.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @objc
    func tapCenterOfCell(_ sender: UITapGestureRecognizer) {
        if let view = sender.view {
            if let cell = view.superview as? TableViewCell {
                guard let index = self.tableView.indexPath(for: cell) else {
                    return
                }
                print(index)
                if firstTap {
                    cell.noteLabel.frame.size.height = dictOfDefHeight[index]!
                    cell.frame.size.height = dictOfDefHeight[index]!
                    tableView.setNeedsDisplay()
                    firstTap = false
                } else {
                    cell.noteLabel.frame.size.height = dictOfHeight[index]!
                    cell.frame.size.height = dictOfHeight[index]!
                    tableView.setNeedsDisplay()
                    firstTap = true
                }
                
            }
        }
    }
}

extension NoteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newNoteVC = NewNoteViewController()
        let newNote = noteService.notes[indexPath.row]
        newNoteVC.textField.text = newNote
        newNoteVC.tеmpIndex = indexPath.row
        noteService.isEdit = true
        navigationController?.pushViewController(newNoteVC, animated: true)
    }
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		if let height = dictOfHeight[indexPath] {
			return (height > 100) ? 100 : height
		}
		return UITableView.automaticDimension
	}
}
