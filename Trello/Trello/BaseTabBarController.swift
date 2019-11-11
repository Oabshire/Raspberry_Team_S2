//
//  BaseTabBarController.swift
//  Trello
//
//  Created by Onie on 10.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let taskViewController = UINavigationController(rootViewController: TaskViewController() )
        
        
        let noteViewController = UINavigationController(rootViewController: NoteViewController())
        
        
        let settingViewController = UINavigationController(rootViewController: SettingViewController())
        
        viewControllers = [taskViewController, noteViewController, settingViewController]
    }
}

