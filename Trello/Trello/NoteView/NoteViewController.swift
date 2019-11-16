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
		//		self.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
		self.tabBarItem = UITabBarItem(title: "Заметки", image: UIImage(named: "Note"), tag: 0)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let barItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(itemPressed))
		navigationController?.viewControllers[0].navigationItem.rightBarButtonItem = barItem
		
		let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditing))
		navigationController?.viewControllers[0].navigationItem.leftBarButtonItem = editButton
		
		navigationController?.viewControllers[0].title = "Заметки (\(noteService.notes.count))"
		view.backgroundColor = .green
		
		
		tableView.frame = view.frame
		tableView.delegate = self
		tableView.dataSource = self
		tableView.tableFooterView = UIView()
		view.addSubview(tableView)
		
		tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseId)
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
	
	@objc private func toggleEditing() {
		tableView.setEditing(!tableView.isEditing, animated: true)
		navigationItem.leftBarButtonItem?.title = tableView.isEditing ? "Done" : "Edit"
	}
}

extension NoteViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseId, for: indexPath) as! TableViewCell
		
		let image = (UIImage(data:noteService.notes[indexPath.row].image!))!
		print("image ", image)
		cell.noteImage.image = image
		let note = noteService.notes[indexPath.row].text
		
		let heightOfText = note.heightWithConstrainedWidth(width: cell.contentView.frame.size.width, font: .systemFont(ofSize: 20))
		
		cell.noteLabel.text = note
		let height = heightOfText < 100 ? heightOfText : 100
		cell.heightOfNote = height
		
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
		if let view = sender.view, let cell = view.superview as? TableViewCell {
			
			let fullHeightOfText = (cell.noteLabel.text?.heightWithConstrainedWidth(width: cell.contentView.frame.size.width, font: .systemFont(ofSize: 20)))!
			
			if !cell.isTapped {
				cell.heightOfNote = fullHeightOfText
				cell.updateConstraints()
				tableView.reloadData()
			} else {
				cell.heightOfNote = fullHeightOfText < 100 ? fullHeightOfText : 100
				cell.updateConstraints()
				tableView.reloadData()
			}
			cell.isTapped = !cell.isTapped
		}
	}
}

extension NoteViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let newNoteVC = NewNoteViewController()
		let newNote = noteService.notes[indexPath.row]
		newNoteVC.textFieldVC.textField.text = newNote.text
		newNoteVC.imagePickerVC.imageView!.image = UIImage(data: newNote.image!)
		newNoteVC.tempIndex = indexPath.row
		noteService.isEdit = true
		navigationController?.pushViewController(newNoteVC, animated: true)
	}
	
	func tableView(_ tableView: UITableView, canEditAtRow indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			print("noteService.notes: ", noteService.notes)
			noteService.notes.remove(at: indexPath.row)
			print("noteService.notes: ", noteService.notes)
			navigationController?.viewControllers[0].title = "Заметки (\(noteService.notes.count))"
			tableView.reloadData()
		}
	}
	
	func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		return UITableViewCell.EditingStyle.delete
	}
}

extension String {
	func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
		return boundingBox.height
	}
}
