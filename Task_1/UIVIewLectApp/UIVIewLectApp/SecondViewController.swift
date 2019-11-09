//
//  SecondViewController.swift
//  UIVIewLectApp
//
//  Created by Дарья Витер on 05/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
		
		title = "Second Controller"
		view.backgroundColor = .systemGreen
    }
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.navigationController?.setNavigationBarHidden(false, animated: true)
	}

}
