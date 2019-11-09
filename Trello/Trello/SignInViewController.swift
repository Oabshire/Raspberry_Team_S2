//
//  SignInViewController.swift
//  Trello
//
//  Created by Onie on 09.11.2019.
//  Copyright © 2019 Onie. All rights reserved.
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
        startButton.backgroundColor = .systemBlue
        startButton.setTitle("Нажмите на кнопку", for: .normal)
        startButton.layer.cornerRadius = 15
        startButton.addTarget( self, action: #selector(pushButton), for: .touchUpInside)
        return startButton
    }()

    @objc
    func pushButton(){
        let taskVC = TaskViewController()
        let noteVC = NoteViewController()
        let settingVC = SettingViewController()
              
              
        let tabBarC = UITabBarController()
              
        let secondNC = UINavigationController()
              
        tabBarC.viewControllers = [taskVC,noteVC,settingVC]
        secondNC.viewControllers = [tabBarC]
        present(secondNC, animated: true, completion: nil)
              
              
    }
    override func viewWillAppear(_ animated: Bool) {
             navigationController?.setNavigationBarHidden(false, animated: true)
         }
}
