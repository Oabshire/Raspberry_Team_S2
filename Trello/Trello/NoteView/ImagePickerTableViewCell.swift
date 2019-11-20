//
//  ImagePickerTableViewCell.swift
//  Trello
//
//  Created by Onie on 15.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import UIKit

class ImagePickerTableViewCell: UITableViewCell {
	
	var imageOnCell: UIImage!
	
	var imagePicker: UIImageView = {
		let image = UIImage(named: "Photo")
		let imagePicker = UIImageView(image: image)
		return imagePicker
	}()
	
	public static let reuseId = "ImageID"
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		
		
		contentView.backgroundColor = .white
		let image = imageOnCell
		imagePicker = UIImageView(image: image)
		imagePicker.contentMode = .scaleToFill
		contentView.addSubview(imagePicker)
		
		
		imagePicker.translatesAutoresizingMaskIntoConstraints = false
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func updateConstraints() {
		//        imagePicker.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
		
//		imagePicker.heightAnchor.constraint(equalToConstant: 200).isActive = true
		imagePicker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//		imagePicker.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//		imagePicker.widthAnchor.constraint(equalTo: imagePicker.heightAnchor).isActive = true
		
		imagePicker.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 2).isActive = true
		imagePicker.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -2).isActive = true
		
		imagePicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
		imagePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5).isActive = true
		
		let heightForContentView = imagePicker.heightAnchor.constraint(equalToConstant: 200)
		heightForContentView.priority = UILayoutPriority(rawValue: 999)
		heightForContentView.isActive = true
		
		super.updateConstraints()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
	override class var requiresConstraintBasedLayout: Bool {
		return true
	}
}
