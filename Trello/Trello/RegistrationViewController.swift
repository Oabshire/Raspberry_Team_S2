//
//  RegistrationViewController.swift
//  Trello
//
//  Created by Onie on 10.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//
import UIKit

class RegistrationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "IMG")
        let imageView = UIImageView(image: image)
		imageView.frame = CGRect(x: view.center.x - 265 / 2, y: 75, width: 265, height: 220)
        view.addSubview(imageView)
        
        signInButton.center = CGPoint(x: view.center.x, y: view.center.y)
        signUpButton.center = CGPoint(x: view.center.x, y: view.center.y + 100)
        
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        view.backgroundColor = .white
        
    }
    
    var signInButton: UIButton = {
        let signInButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        signInButton.backgroundColor = .blue
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.layer.cornerRadius = 15
        signInButton.addTarget( self, action: #selector(signIn), for: .touchUpInside)
        return signInButton
    }()
    
    var signUpButton: UIButton = {
        let signUpButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        signUpButton.backgroundColor = .blue
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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}
