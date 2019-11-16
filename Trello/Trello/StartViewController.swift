//
//  StartViewController.swift
//  Trello
//
//  Created by Onie on 10.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
	
	let loadView = DiamondLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        helloLabel.center = CGPoint(x: view.center.x, y: view.center.y - 50)
        view.addSubview(helloLabel)
        
        startButton.center = CGPoint(x: view.center.x, y: view.center.y + 50)
        view.addSubview(startButton)
//		почему-то при добавлении анимации кнопка становится неактивной (
//		UIView.animate(withDuration: 2.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: [.curveEaseInOut, .repeat, .autoreverse], animations: {
//			self.startButton.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
//		}, completion: nil)
		
		
		loadView.dotsColor = .cyan
		loadView.frame.size = CGSize(width: 70, height: 70)
		loadView.center = CGPoint(x: view.center.x, y: view.center.y + 150)
		view.addSubview(loadView)
		
    }
    
    var helloLabel: UILabel = {
        let helloLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        helloLabel.text = "Добро пожаловать!"
        helloLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 25)
        helloLabel.numberOfLines = 2
        helloLabel.textAlignment = .center
        return helloLabel
    }()
    
    var startButton: UIButton = {
        let startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        startButton.backgroundColor = UIColor.blue
        startButton.setTitle("Начать", for: .normal)
        startButton.layer.cornerRadius = 15
        startButton.addTarget( self, action: #selector(start), for: .touchUpInside)
        return startButton
    }()
    
    @objc
    func start(){
		
		UIView.animate(withDuration: 2, delay: 0, options: [], animations: {
			self.startButton.layer.opacity = 0
			self.helloLabel.layer.opacity = 0
		}, completion: {
			_ in
			if AppDelegate.defaults.bool(forKey: "loggedIn"){
				AppDelegate.shared.rootViewController.switchToMainScreen()
			} else {
				AppDelegate.shared.rootViewController.switchToLogout()
			}
		})
//        if AppDelegate.defaults.bool(forKey: "loggedIn") {
//            AppDelegate.shared.rootViewController.switchToMainScreen()
//        } else {
//            AppDelegate.shared.rootViewController.switchToLogout()
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
		loadView.startAnimating()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

