//
//  TextViewTableViewCell.swift
//  Trello
//
//  Created by Onie on 15.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
	
	let textField = UITextView()
	
	var heightOfNote: CGFloat = 500
	
	public static let reuseId = "TextID"
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		
		textField.font = UIFont.systemFont(ofSize: 20)
		textField.frame = contentView.frame
		contentView.addSubview(textField)
		
		textField.translatesAutoresizingMaskIntoConstraints = true
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
	override func updateConstraints() {
		
		textField.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  5).isActive = true
		textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2).isActive = true
		textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2).isActive = true
		textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
		
		let heightForContentView = textField.heightAnchor.constraint(equalToConstant: heightOfNote)
		heightForContentView.priority = UILayoutPriority(rawValue: 999)
		heightForContentView.isActive = true
		
		super.updateConstraints()
	}
	
	override class var requiresConstraintBasedLayout: Bool {
		return true
	}
	
}
