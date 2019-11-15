//
//  TaskViewController.swift
//  Trello
//
//  Created by Onie on 10.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
	
	public var textArray = ["First List", "Second List", "third", "fourth", "sisth", "seventh"]
	private var isDeleteActivate = false
	private var indexToDelete = 0
	
	let userSettings = UserDefaults.standard
	
	let layout = UICollectionViewFlowLayout()
//	var collectionView: TaskListsCollectionView!
	var collectionView: UICollectionView!
	
	init() {
		super.init(nibName: nil, bundle: nil)
		self.tabBarItem = UITabBarItem(title: "Задачи", image: UIImage(named: "Task"), tag: 0)
		//		self.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - View Did Load
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .red
		
		//MARK: CollectiuonView
		
		layout.itemSize = CGSize(width: 300, height: 500)
		layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
		layout.minimumLineSpacing = 20
		layout.minimumInteritemSpacing = 20
		layout.scrollDirection = .horizontal
		
		collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
		
		collectionView.backgroundColor = #colorLiteral(red: 1, green: 0.7164984345, blue: 0.8314651847, alpha: 1)
		collectionView.register(TaskListCell.self, forCellWithReuseIdentifier: TaskListCell.reuseId)
		
		collectionView.delegate = self
		collectionView.dataSource = self
		
		collectionView.layer.borderWidth = 1
		collectionView.layer.borderColor = UIColor.lightGray.cgColor
		
		let longPress = UILongPressGestureRecognizer(target: self, action: nil)
		collectionView.addGestureRecognizer(longPress)
		
		view.addSubview(collectionView)
	}
	
	//MARK: - ViewWillAppear
	
	override func viewWillAppear(_ animated: Bool) {
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTaskList))
		navigationController?.viewControllers[0].navigationItem.rightBarButtonItem = addButton
		
		//////////
		//#fix
	//	navigationController?.viewControllers[0].title = "Задачи"
		self.navigationController?.title = "Задачи "
		/////////
		
		
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	@objc
	func addTaskList() {
		let addTaskAllert = UIAlertController(title: "Введите название нового списка заданий", message: nil, preferredStyle: .alert)
		
		addTaskAllert.addTextField(configurationHandler: nil)
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		
		let okAction = UIAlertAction(title: "OK", style: .default) {
			_ in
			
			// @fix
			let textField = addTaskAllert.textFields![0] as UITextField
			if let text = textField.text {
				AppDelegate.shared.array.append(Column(name: text))
			} else {
				return
			}
			
			self.collectionView.reloadData()
		}
		
		addTaskAllert.addAction(cancelAction)
		addTaskAllert.addAction(okAction)
		
		present(addTaskAllert, animated: true, completion: nil)
	}
	
}

//MARK: - UICollectionViewDataSource and UICollectionViewDelegate

extension TaskViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return AppDelegate.shared.array.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskListCell.reuseId, for: indexPath) as! TaskListCell
		
		let currentColumn = AppDelegate.shared.array[indexPath.item]
		
		cell.data = currentColumn

		
		let title = currentColumn.name
		cell.navigationBar.items?[0].title = title
		
		
		return cell
	}
	
	
}

extension TaskViewController: UICollectionViewDelegate {
}

// MARK: - UICollectionViewDragDelegate
//extension TaskViewController: UICollectionViewDragDelegate {
//	func collectionView(_ collectionView: UICollectionView,
//						itemsForBeginning session: UIDragSession,
//						at indexPath: IndexPath) -> [UIDragItem] {
//		let cell = collectionView.cellForItem(at: indexPath) as! TaskListCell

//		let image = cell.image
//		let item = NSItemProvider(object: image!)
//		let dragItem = UIDragItem(itemProvider: item)
//		return [dragItem]
//		return []
//	}
//}
