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
	
	var heightOfNote: CGFloat = 100
	var isTapped = false
	
    public static let reuseId = "MyReuseID"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
		noteLabel.numberOfLines = 0
//        noteLabel.frame = self.contentView.frame
//        noteLabel.center = self.contentView.center
		noteLabel.font = UIFont.systemFont(ofSize: 20)
        contentView.addSubview(noteLabel)
		
		
		
		noteLabel.translatesAutoresizingMaskIntoConstraints = false
    }
	
	override func updateConstraints() {

		noteLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1).isActive = true
		noteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2).isActive = true
		noteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2).isActive = true
		noteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 1).isActive = true

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

        // Configure the view for the selected state
    }
	
	

	override class var requiresConstraintBasedLayout: Bool {
		return true
	}
}
