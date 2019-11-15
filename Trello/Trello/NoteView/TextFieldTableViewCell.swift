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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	override func updateConstraints() {
        textField.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 0).isActive = true
        
		textField.heightAnchor.constraint(equalToConstant: heightOfNote).isActive = true
		
        super.updateConstraints()
    }
	
	override class var requiresConstraintBasedLayout: Bool {
        return true
    }

}
