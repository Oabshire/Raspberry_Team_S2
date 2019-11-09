//
//  ViewController.swift
//  UIVIewLectApp
//
//  Created by Дарья Витер on 05/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	//MARK: -	второй вариант
	override func loadView() {
		let gradientView = GradientView()
		gradientView.colorsArray = [.yellow, .green]
		view = gradientView
	}
	
	//	MARK: - GradientView
	var gradientView: GradientView {
		return self.view as! GradientView
	}
	
	//MARK: - button
	let button: UIButton = {
		let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
		button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
		button.setTitle("Change color", for: .normal)
		button.layer.cornerRadius = 20
		button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
		return button
	}()
	
	//	MARK: - circleView
	let circleToSecondVC: UIView = {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		view.layer.cornerRadius = 50
		view.backgroundColor = .white
		//	MARK: label
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		label.text = "To Second View"
		label.textColor = .black
		label.numberOfLines = 0
		label.textAlignment = .center
		view.addSubview(label)
		return view
	}()
	
	let circleToThirdVC: UIView = {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		view.layer.cornerRadius = 50
		view.backgroundColor = .cyan
		//	MARK: label
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		label.text = "To Third View"
		label.textColor = .blue
		label.numberOfLines = 0
		label.textAlignment = .center
		view.addSubview(label)
		return view
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .orange
		
		view.addSubview(button)
		view.addSubview(circleToSecondVC)
		view.addSubview(circleToThirdVC)
		
		//		MARK:UITapGestureRecognizer
		
		let tapGestureForSecondView = UITapGestureRecognizer(target: self, action: #selector(tapSecondView))
		let tapGestureForThirdView = UITapGestureRecognizer(target: self, action: #selector(tapThirdView))
		
		button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
		circleToSecondVC.addGestureRecognizer(tapGestureForSecondView)
		circleToThirdVC.addGestureRecognizer(tapGestureForThirdView)
		
		
		//		let circle2 = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
		//		circle2.backgroundColor = .blue
		//		circle2.center = view.center
		//		circle2.layer.cornerRadius = 30
		
		//		let circle3 = GradientView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
		//		circle3.colorsArray = [.white, .orange, .blue, .green]
		//		circle3.center = view.center
		//		circle3.layer.cornerRadius = 30
		
		//		view.insertSubview(circle2, belowSubview: circle)
		//		view.insertSubview(circle2, at: 0)
		//		view.insertSubview(circle3, at: 1)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		
		button.center = CGPoint(x: view.center.x, y: view.center.y - 100)
		circleToSecondVC.center = CGPoint(x: view.center.x, y: view.center.y)
		circleToThirdVC.center = CGPoint(x: view.center.x, y: view.center.y + 125)
	}
	
	
	//	MARK: - Funcs
	func randomColors() -> [UIColor] {
		
		var colorArray: [UIColor] = []
		
		for _ in 0 ..< 3 {
			let red = Float.random(in: 0...255) / 255
			let green = Float.random(in: 0...255) / 255
			let blue = Float.random(in: 0...255) / 255
			colorArray.append(UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1))
		}
		return colorArray
	}
	
	@objc func tapButton() {
		UIView.animate(withDuration: 1) {
			self.gradientView.colorsArray = self.randomColors()
		}
	}
	
	@objc
	func tapSecondView() {
		navigationController?.pushViewController(SecondViewController(), animated: true)
	}
	
	@objc
	func tapThirdView() {
		let thirdVC = ThirdViewController()
		thirdVC.modalPresentationStyle = .fullScreen
		present(thirdVC, animated: true, completion: nil)
	}
}

