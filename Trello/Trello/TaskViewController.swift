//
//  TaskViewController.swift
//  Trello
//
//  Created by Onie on 09.11.2019.
//  Copyright © 2019 Onie. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
         navigationController?.setNavigationBarHidden(true, animated: true)
     }
}
