//
//  SettingViewController.swift
//  Trello
//
//  Created by Onie on 10.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
	
	init() {
		super.init(nibName: nil, bundle: nil)
		self.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(logOutButton)
		logOutButton.center = view.center
		view.backgroundColor = .white
	}
	
	var logOutButton: UIButton = {
		let logOutButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
		logOutButton.backgroundColor = .blue
		logOutButton.setTitle("Log Out", for: .normal)
		logOutButton.layer.cornerRadius = 15
		logOutButton.addTarget( self, action: #selector(logOut), for: .touchUpInside)
		return logOutButton
	}()
	
	@objc
	func logOut(){
		AppDelegate.defaults.set(false, forKey: "loggedIn")
		AppDelegate.shared.rootViewController.switchToLogout()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
}

