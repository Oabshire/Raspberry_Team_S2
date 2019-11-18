//
//  NoteViewController.swift
//  Trello
//
//  Created by Onie on 10.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//


import UIKit

class NoteViewController: UIViewController {
	
	
	let apiKey = "AIzaSyCHc17KIlD5V3QEnHIYJsn3VL4hSC5pGQY"
	var memesLink: String {
		return "https://troll-4d320.firebaseio.com/notes.json?avvrdd_token=\(apiKey))"
	}
	
	var notesArray: [NoteFromBase] = [] {
		didSet {
			loadView.stopAnimating()
		}
	}
	
	let noteService = NoteService.shared
	
	let loadView = DiamondLoad()
	
	var velocityOfTable: CGPoint = .zero
	
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
		
		//		navigationController?.viewControllers[0].title = "Заметки (\(noteService.notes.count))"
		navigationController?.viewControllers[0].title = "Заметки (\(notesArray.count))"
		view.backgroundColor = .green
		
		
		tableView.frame = view.frame
		tableView.delegate = self
		tableView.dataSource = self
		tableView.tableFooterView = UIView()
		tableView.prefetchDataSource = self
		view.addSubview(tableView)
		
		tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseId)
		
		//		loadView.dotsColor = .cyan
		//		loadView.frame.size = CGSize(width: 70, height: 70)
		//		loadView.center = view.center
		//		loadView.startAnimating()
		//		view.addSubview(loadView)
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		//        let config = URLSessionConfiguration.default
		//        let session = URLSession(configuration: config)
		//
		//        let url = URL(string: memesLink)!
		//        let urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 120)
		//
		//        let task = session.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
		//            do {
		//                let posts = try JSONDecoder().decode([String: NoteFromBase].self, from: data!)
		//                self.notesArray = Array(posts.values)
		//                print(posts)
		//                DispatchQueue.main.async {
		//                    self.tableView.reloadData()
		//                }
		//            } catch {
		//                print(error)
		//            }
		//        })
		//        task.resume()
		
		navigationController?.setNavigationBarHidden(false, animated: true)
		navigationController?.viewControllers[0].title = "Заметки (\(NoteService.shared.notes.count))"
		
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
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return NoteService.shared.notes.count//notesArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseId, for: indexPath) as! TableViewCell
		let noteInDB: Note = NoteService.shared.notes[indexPath.row]
		let heightOfText = noteInDB.text.heightWithConstrainedWidth(width: cell.contentView.frame.size.width, font: .systemFont(ofSize: 20))
		let height = heightOfText < 100 ? heightOfText : 100
		let index = indexPath
		
		if tableView.indexPathsForVisibleRows!.contains(indexPath), velocityOfTable == .zero {
			let noteInDB: Note = NoteService.shared.notes[indexPath.row]
			if noteInDB.image == nil {
				//				print("image = nil:" , indexPath.row)
				loadImage(stringUrl: noteInDB.imageURL, index: indexPath.row)
				tableView.reloadData()
			}
		}
		let loadIndicator = UIActivityIndicatorView()
		loadIndicator.frame.size = CGSize(width: 100, height: 100)
		loadIndicator.center = cell.contentView.center // не по центру (
		loadIndicator.startAnimating()
		if noteInDB.imageURL != "" {
			cell.contentView.addSubview(loadIndicator)
		}
		
		cell.noteImage.image = noteInDB.image
		
		
		if cell.noteImage.image != nil {
			loadIndicator.stopAnimating()
		}
		cell.noteLabel.text = noteInDB.text
		cell.heightOfNote = height
		cell.accessoryType = .disclosureIndicator
		
		return cell
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
		
		newNoteVC.textFieldVC.textField.text = NoteService.shared.notes[indexPath.row].text
		
		newNoteVC.imagePickerVC.imageView!.image = NoteService.shared.notes[indexPath.row].image
		newNoteVC.tempIndex = indexPath.row
		NoteService.shared.isEdit = true
		//noteService.isEdit = true
		navigationController?.pushViewController(newNoteVC, animated: true)
		
	}
	
	func tableView(_ tableView: UITableView, canEditAtRow indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			
			NoteService.shared.notes.remove(at: indexPath.row)
			uploadPosts(NoteService.shared.notes) {
				result in
				print(result)
				print("--------------------")
				print("Notes uploaded")
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
			navigationController?.viewControllers[0].title = "Заметки (\(notesArray.count))"
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

extension NoteViewController {
	func loadImage(stringUrl: String, index: Int){
		var image = UIImage()
		if let url = URL(string: stringUrl) {
			
			if let data = try? Data(contentsOf: url)
			{
				image = UIImage(data: data)!
			}
		}
		NoteService.shared.notes[index].image = image
		tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
		
	}
}

extension NoteViewController : UITableViewDataSourcePrefetching {
	
	func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		
	}
	
//	func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
//
//	}
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		print("beginDragging: \(scrollView.contentOffset)")
		velocityOfTable = CGPoint(x: 1, y: 1)
		
	}
	
	//	func scrollViewDidScroll(_ scrollView: UIScrollView) {
	//			print("offset: \(scrollView.contentOffset)")
	
	//	}
	
	//	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
	//
	//	}
	
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		print("enddragging")
		velocityOfTable = .zero
		let t = tableView.indexPathsForVisibleRows!
		tableView.reloadRows(at: t, with: .fade)
	}
	
}
