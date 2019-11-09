//
//  RegistrationViewController.swift
//  Trello
//
//  Created by Onie on 09.11.2019.
//  Copyright © 2019 Onie. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageName = "IMG"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 80, y: 30, width: 265, height: 220)
        view.addSubview(imageView)
       
        signInButton.center = CGPoint(x: view.center.x, y: view.center.y - 50)
         signUpButton.center = CGPoint(x: view.center.x, y: view.center.y + 50)
        
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        view.backgroundColor = .white
        
    }
    
    var signInButton: UIButton = {
        let signInButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        signInButton.backgroundColor = .systemBlue
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.layer.cornerRadius = 15
        signInButton.addTarget( self, action: #selector(signIn), for: .touchUpInside)
        return signInButton
    }()
    
    var signUpButton: UIButton = {
        let signUpButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        signUpButton.backgroundColor = .systemBlue
        signUpButton.setTitle("SignUp", for: .normal)
        signUpButton.layer.cornerRadius = 15
        signUpButton.addTarget( self, action: #selector(signUp), for: .touchUpInside)
        return signUpButton
    }()
    
    @objc
    func signIn(){
        let signInVC = SignInViewController()
            navigationController?.pushViewController(signInVC, animated: true)
    }
    
    @objc
    func signUp(){
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }


}
