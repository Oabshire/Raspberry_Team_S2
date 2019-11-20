//
//  TableViewCell.swift
//  Trello
//
//  Created by Konstantin Nikandrov on 11.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
	
	let noteLabel = UILabel()
	var imageOfNote: UIImage? = nil
	
	let noteImage = UIImageView()
	
	var heightOfNote: CGFloat = 100
	var haveImage: Bool = false
	var isTapped = false
	
	public static let reuseId = "MyReuseID"
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		
		noteLabel.numberOfLines = 0
		noteLabel.font = UIFont.systemFont(ofSize: 20)
		
		noteImage.backgroundColor = .lightGray
		
		contentView.addSubview(noteLabel)
		contentView.addSubview(noteImage)
		
		noteImage.translatesAutoresizingMaskIntoConstraints = false
		noteLabel.translatesAutoresizingMaskIntoConstraints = false
		
	}
	
	override func updateConstraints() {
		
		let heightOfImage: CGFloat = haveImage ? 150 : 0
		
		noteImage.topAnchor.constraint(equalTo:contentView.topAnchor, constant: 10).isActive  = true
		noteImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
		noteImage.heightAnchor.constraint(equalToConstant: heightOfImage).isActive = true
		noteImage.widthAnchor.constraint(equalTo: noteImage.heightAnchor, constant: 0.0).isActive = true
		
		noteLabel.topAnchor.constraint(equalTo: noteImage.bottomAnchor, constant:  10).isActive = true
		noteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2).isActive = true
		noteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2).isActive = true
		noteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
		
		let heightForContentView = noteLabel.heightAnchor.constraint(equalToConstant: heightOfNote)
		heightForContentView.priority = UILayoutPriority(rawValue: 999)
		heightForContentView.isActive = true
		
		super.updateConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:)has not been implemented")
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
	
	
	override class var requiresConstraintBasedLayout: Bool {
		return true
	}
}
