//
//  SignUpViewController.swift
//  Trello
//
//  Created by Onie on 10.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageLabel.center = view.center
        view.addSubview(messageLabel)
        
        view.backgroundColor = .white
    }
    
    var messageLabel: UILabel = {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        messageLabel.text = "Данная функция недоступна!"
        messageLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 25)
        messageLabel.numberOfLines = 5
        messageLabel.textAlignment = .center
        return messageLabel
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
