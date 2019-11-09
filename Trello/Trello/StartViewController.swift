//
//  StartViewController.swift
//  Trello
//
//  Created by Onie on 09.11.2019.
//  Copyright © 2019 Onie. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
           
        helloLabel.center = CGPoint(x: view.center.x, y: view.center.y - 50)
        view.addSubview(helloLabel)
           
        startButton.center = CGPoint(x: view.center.x, y: view.center.y + 50)
        view.addSubview(startButton)
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
           startButton.backgroundColor = .systemBlue
           startButton.setTitle("Начать", for: .normal)
           startButton.layer.cornerRadius = 15
           startButton.addTarget( self, action: #selector(start), for: .touchUpInside)
           return startButton
       }()
       
       @objc
       func start(){
        let loggedIn = true
        
        if loggedIn {
            
            let taskVC = TaskViewController()
            let noteVC = NoteViewController()
            let settingVC = SettingViewController()
            
            
            let tabBarC = UITabBarController()
            
            let secondNC = UINavigationController()
            
            tabBarC.viewControllers = [taskVC,noteVC,settingVC]
            secondNC.viewControllers = [tabBarC]
            present(secondNC, animated: true, completion: nil)
            
            
            
            
        }else {
            let regVC = RegistrationViewController()
            navigationController?.pushViewController(regVC, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
         navigationController?.setNavigationBarHidden(true, animated: true)
     }
}
