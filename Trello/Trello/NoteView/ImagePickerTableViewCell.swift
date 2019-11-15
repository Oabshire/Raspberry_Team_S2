//
//  ImagePickerTableViewCell.swift
//  Trello
//
//  Created by Onie on 15.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import UIKit

class ImagePickerTableViewCell: UITableViewCell {
    
    let imagePicker: UIImageView = {
        let image = UIImage(named: "Photo")
        let imagePicker = UIImageView(image: image)
        return imagePicker
    }()
    
    public static let reuseId = "ImageID"
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        
        contentView.backgroundColor = .white
        contentView.addSubview(imagePicker)
            
        imagePicker.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
//        imagePicker.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        imagePicker.heightAnchor.constraint(equalToConstant: 300).isActive = true
		imagePicker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
		imagePicker.widthAnchor.constraint(equalTo: imagePicker.heightAnchor).isActive = true
        imagePicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        imagePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 0).isActive = true
        
        super.updateConstraints()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}
