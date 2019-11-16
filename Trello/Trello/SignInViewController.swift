//
//  SignInViewController.swift
//  Trello
//
//  Created by Onie on 10.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        someButton.center = view.center
        view.addSubview(someButton)
        
        view.backgroundColor = .white
    }
    
    var someButton: UIButton = {
        let startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        startButton.backgroundColor = .blue
        startButton.setTitle("Нажмите на кнопку", for: .normal)
        startButton.layer.cornerRadius = 15
        startButton.addTarget( self, action: #selector(pushButton), for: .touchUpInside)
        return startButton
    }()
    
    @objc
    func pushButton(){
		
		modalPresentationStyle = .fullScreen
		
		if #available(iOS 13.0, *) {
            present(Authorization(), animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
		
//        AppDelegate.defaults.set(true, forKey: "loggedIn")
//        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
