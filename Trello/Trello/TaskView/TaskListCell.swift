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
	
	var collectionView: UICollectionView!
	let layout = UICollectionViewFlowLayout()
	
	public var taskView: TaskView!
		
		
		override init(frame: CGRect) {
			super.init(frame: frame)
			self.backgroundColor = .clear
			self.layer.cornerRadius = 20
			
			taskView = TaskView(frame: contentView.frame)
			taskView.center = contentView.center
			taskView.layer.cornerRadius = 20
			taskView.layer.masksToBounds = true
			self.addSubview(taskView)
		}
		
		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
	
}
