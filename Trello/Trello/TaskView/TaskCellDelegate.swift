//
//  TaskCellDelegate.swift
//  Trello
//
//  Created by Дарья Витер on 14/11/2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import UIKit

class TaskCellDelegate: NSObject,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	var tasks = [String]()
	
//	var collectionView = UICollectionView()
	
	var labelOfList: String = "" {
		didSet {
			print("labelOfList", labelOfList)
		}
	}
	
	var headerOfList: String = "" {
		didSet {
			print("headerOfList", headerOfList)
		}
	}
	
	var taskInCellLabel: String!
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//		let count1 = AppDelegate.shared.array["1"]
		let count = AppDelegate.shared.array[labelOfList]?.count
		return count ?? 0 //tasks.count
		}
		
		func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EachTaskCollectionViewCell.reuseId, for: indexPath) as! EachTaskCollectionViewCell
			
//			let tasks = UserDefaults.standard.value(forKey: "Tasks") as! [String]
			
	//		cell.backgroundColor = .white
			tasks = AppDelegate.shared.array[labelOfList]!
			print("labelOfList: ", labelOfList, ", tasks : ", tasks )
			cell.label.textColor = .black
			taskInCellLabel = tasks[indexPath.row]
			cell.label.text = taskInCellLabel
			return cell
		}
	
//	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//		switch kind {
//		case UICollectionView.elementKindSectionHeader:
//			guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TaskHeader", for: indexPath) as? TaskHeader
//				else {
//				fatalError("Invalid view type")
//			}
//
//			headerView.label.text = headerOfList
//			return headerView
//
//		default:
//			assert(false, "Invalid element type")
//		}
//	}
}

//class TaskHeader: UICollectionReusableView {
//
//	var label: UILabel!
//
//}
