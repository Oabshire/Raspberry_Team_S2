//
//  TaskViewController.swift
//  Trello
//
//  Created by Onie on 10.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
	
	public var textArray = ["First List", "Second List"]
	private var isDeleteActivate = false
	private var indexToDelete = 0
	
	let userSettings = UserDefaults.standard
	
	let layout = UICollectionViewFlowLayout()
	var collectionView: TaskListsCollectionView!
	
	init() {
		super.init(nibName: nil, bundle: nil)
		self.tabBarItem = UITabBarItem(title: "Задачи", image: UIImage(named: "Task"), tag: 0)
		//		self.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - ViewWillAppear
	
	override func viewWillAppear(_ animated: Bool) {
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTaskList))
		navigationController?.viewControllers[0].navigationItem.rightBarButtonItem = addButton
		
//		let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editMe))
//		navigationController?.viewControllers[0].navigationItem.leftBarButtonItem = editButton
		
		navigationController?.viewControllers[0].title = "Задачи"
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	@objc
	func editMe() {
		
		isDeleteActivate = true
		
		
		let itemIndex = collectionView.indexPathsForSelectedItems
		if let index = itemIndex?.first?.row {
			remove(indexToDelete)
		}
	}
	
	func remove(_ i: Int) {

		textArray.remove(at: i)

		let indexPath = IndexPath(row: i, section: 0)
		

		self.collectionView.performBatchUpdates({
			self.collectionView.deleteItems(at: [indexPath])
		}) { (finished) in
			self.collectionView.reloadItems(at: self.collectionView.indexPathsForVisibleItems)
		}
	}
	
	@objc
	func addTaskList() {
		let addTaskAllert = UIAlertController(title: "Введите название нового списка заданий", message: nil, preferredStyle: .alert)
		
		addTaskAllert.addTextField(configurationHandler: nil)
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		
		let okAction = UIAlertAction(title: "OK", style: .default){
			_ in
			
			let textField = addTaskAllert.textFields![0] as UITextField
			guard !textField.text!.isEmpty else { return }
			
			self.textArray.append(textField.text!)
			self.collectionView.reloadData()
		}
		
		addTaskAllert.addAction(cancelAction)
		addTaskAllert.addAction(okAction)
		
		present(addTaskAllert, animated: true, completion: nil)
	}
	//MARK: - View Did Load
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .red
		
		//MARK: - CollectiuonView
		
		layout.itemSize = CGSize(width: 300, height: 500)
		layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
		layout.minimumLineSpacing = 20
		layout.minimumInteritemSpacing = 20
		layout.scrollDirection = .horizontal
		
		collectionView = TaskListsCollectionView(frame: view.frame, collectionViewLayout: layout)
		
		collectionView.delegate = self
		collectionView.dataSource = self
		
		//		collectionView.dragDelegate = self
		//		collectionView.dropDelegate = self
		
		collectionView.layer.borderWidth = 1
		collectionView.layer.borderColor = UIColor.lightGray.cgColor
		
		let longPress = UILongPressGestureRecognizer(target: self, action: nil)
		collectionView.addGestureRecognizer(longPress)
		
		
		view.addSubview(collectionView)
	}
	
//	@objc
//	func activateDeletingMode(_ recognizer: UILongPressGestureRecognizer) {
//		if recognizer.state == UIGestureRecognizer.State.began, (isDeleteActivate) {
//			let indexPath = collectionView.indexPathForItem(at: recognizer.location(in: collectionView))
//			let cell = collectionView.cellForItem(at: indexPath!)
//			indexToDelete = indexPath!.row
//			let deleteButton = UIButton(type: .system)
//			deleteButton.addTarget(self, action: #selector(editMe), for: .touchUpInside)
//			deleteButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//				cell?.addSubview(deleteButton)
//
//		}
//	}
	
}

extension TaskViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return textArray.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskListCell.reuseId, for: indexPath) as! TaskListCell
		
		cell.taskView.navigationBar.items![0].title = textArray[indexPath.row]
		return cell
	}
	
	
}

//MARK: - UICollectionViewDelegate
extension TaskViewController: UICollectionViewDelegate {
}

// MARK: - UICollectionViewDragDelegate
extension TaskViewController: UICollectionViewDragDelegate {
	func collectionView(_ collectionView: UICollectionView,
						itemsForBeginning session: UIDragSession,
						at indexPath: IndexPath) -> [UIDragItem] {
		let cell = collectionView.cellForItem(at: indexPath) as! TaskListCell
		
		//		let image = cell.image
		//		let item = NSItemProvider(object: image!)
		//		let dragItem = UIDragItem(itemProvider: item)
		//		return [dragItem]
		return []
	}
}
