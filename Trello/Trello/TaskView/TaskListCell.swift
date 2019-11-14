//
//  TaskCollectionViewCell.swift
//  Trello
//
//  Created by Дарья Витер on 11/11/2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import UIKit

class TaskListCell: UICollectionViewCell {
	static let reuseId = "TasksCell"
	
	var collectionViewForTasks: UICollectionView!
	var layout: UICollectionViewFlowLayout!
	var navigationBar: UINavigationBar!
	
	var tasks = [String]() //["Task1", "Task2"]
	
	var label: UILabel!
	
	var taskInCellLabel = ""
	
	let taskCellDelegate = TaskCellDelegate()
	
//	public var taskView: TaskView!
		
		
		override init(frame: CGRect) {
			super.init(frame: frame)
			self.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
			self.layer.cornerRadius = 20
//			self.backgroundColor = 
			
//			taskView = TaskView(frame: contentView.frame)
//			taskView.center = contentView.center
//			taskView.layer.cornerRadius = 20
//			taskView.layer.masksToBounds = true
//			self.addSubview(taskView)
			
//			label = UILabel(frame: self.contentView.frame)
//			self.contentView.addSubview(label)
			self.addCustomView(withFrame: self.contentView.frame)
		}
		
		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
}

extension TaskListCell {
	override func prepareForReuse() {
//		self.taskInCellLabel = ""
		
		self.taskCellDelegate.labelOfList = ""
		self.taskCellDelegate.tasks = []
	}
}

extension TaskListCell {
		
	func addCustomView(withFrame frame: CGRect) {
			
			setupNavigationBar(withFrame: frame)
			let frameForCollection = CGRect(x: 0, y: 0 + navigationBar.frame.size.height, width: frame.width, height: frame.size.height - navigationBar.frame.size.height)
			setupCollectionView(withFrame: frameForCollection)
		}
		
		func setupCollectionView(withFrame frame: CGRect) {
			layout = UICollectionViewFlowLayout()
			layout.itemSize = CGSize(width: frame.width * 3 / 4, height:  frame.width * 3 / 4)
			layout.minimumLineSpacing = 20
			layout.minimumInteritemSpacing = 20
			layout.scrollDirection = .vertical
			layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
			
			collectionViewForTasks = UICollectionView(frame: frame, collectionViewLayout: layout)
			collectionViewForTasks.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
			collectionViewForTasks.register(EachTaskCollectionViewCell.self, forCellWithReuseIdentifier: "TaskCell")
			
			collectionViewForTasks.delegate = taskCellDelegate //self
			collectionViewForTasks.dataSource = taskCellDelegate //self
//			taskCellDelegate.collectionView = collectionViewForTasks
			
			self.contentView.addSubview(collectionViewForTasks)
		}
		
		func setupNavigationBar(withFrame frame: CGRect) {
			navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height:44))
			navigationBar.backgroundColor = UIColor.white
			
			let navigationItem = UINavigationItem()
//			navigationItem.title = ""
			
			let rightButton =  UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonClicked))
	//		let leftButton = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteButtonClicked))
			navigationItem.rightBarButtonItem = rightButton
	//		navigationItem.leftBarButtonItem = leftButton
			
			navigationBar.items = [navigationItem]
			self.contentView.addSubview(navigationBar)
		}
	
	@objc
	func addButtonClicked() {
		let addTaskAllert = UIAlertController(title: "Введите название нового списка заданий", message: nil, preferredStyle: .alert)
		
		addTaskAllert.addTextField(configurationHandler: nil)
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		
		let okAction = UIAlertAction(title: "OK", style: .default){
			_ in
			
			let textField = addTaskAllert.textFields![0] as UITextField
			guard !textField.text!.isEmpty else { return }
			
			self.tasks.append(textField.text!)
//			self.taskCellDelegate.tasks = self.tasks
			
//			UserDefaults.standard.set(self.tasks, forKey: "Tasks")
			
			print(AppDelegate.shared.array)
			let title : String = (self.navigationBar.items?[0].title!)!
//			self.taskCellDelegate.labelOfList = title
			
			AppDelegate.shared.array[title]?.append(textField.text!)
//			let array = AppDelegate.shared.array[title]
			
			self.collectionViewForTasks.reloadData()
		}
		
		addTaskAllert.addAction(cancelAction)
		addTaskAllert.addAction(okAction)
		
		self.window?.rootViewController!.present(addTaskAllert, animated: true, completion: nil)
	}
}

//MARK: - UICollectionViewDataSource and Delegate

//extension TaskListCell: UICollectionViewDataSource {
//	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//		return tasks.count
//	}
//	
//	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EachTaskCollectionViewCell.reuseId, for: indexPath) as! EachTaskCollectionViewCell
//
////		cell.backgroundColor = .white
//		cell.label.textColor = .black
//		taskInCellLabel = tasks[indexPath.row]
//		cell.label.text = taskInCellLabel
//		return cell
//	}
//}
//
////MARK: - UICollectionViewDelegate
//extension TaskListCell: UICollectionViewDelegate {
//	
//}
