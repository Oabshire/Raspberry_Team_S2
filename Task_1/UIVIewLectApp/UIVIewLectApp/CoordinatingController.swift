//
//  CoordinatingController.swift
//  UIVIewLectApp
//
//  Created by Дарья Витер on 05/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject { // AnyObject чтобы протокол был только для классов
	func change(_ current: UIViewController)
}

final class CoordinatingController: UIViewController {
	let navController: UINavigationController
	
	init(with first: UINavigationController) {
		self.navController = first
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CoordinatingController : Coordinator {
	func change(_ current: UIViewController) {
		self.navController.pushViewController(resolveDestination(), animated: true)
	}
	
	private func resolveDestination() -> UIViewController{
		return SecondViewController()
	}
}
