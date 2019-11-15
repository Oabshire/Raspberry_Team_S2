//
//  EachTaskCollectionViewCell.swift
//  Trello
//
//  Created by Дарья Витер on 11/11/2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import UIKit

class EachTaskCollectionViewCell: UICollectionViewCell {
	static let reuseId = "TaskCell"
	public let label = UILabel()
	public let textOfTask = UITextView()
	
	func setupView(withFrame frame: CGRect) {
		label.frame = CGRect(x: 10, y: 10, width: frame.size.width - 20, height: 40)
		label.textAlignment = .center
		label.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
		label.font = UIFont.systemFont(ofSize: 20)
		label.layer.cornerRadius = 20
		label.layer.masksToBounds = true
		contentView.addSubview(label)
		
		textOfTask.frame = CGRect(x: 10, y: 50, width: frame.size.width - 20, height: frame.size.height - 60)
		
		textOfTask.backgroundColor = .lightText
		textOfTask.text = "description"
		textOfTask.font = UIFont.systemFont(ofSize: 20)
		textOfTask.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		textOfTask.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
		textOfTask.layer.cornerRadius = 20
		textOfTask.layer.masksToBounds = true
		
		contentView.addSubview(textOfTask)
		
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.layer.cornerRadius = 20
		
		setupView(withFrame: frame)
		self.backgroundColor = .white
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
