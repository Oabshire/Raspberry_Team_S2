//
//  ThirdViewController.swift
//  UIVIewLectApp
//
//  Created by Дарья Витер on 08/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .red
		title = "Third View Controller"
		
		//		MARK: GestureRecognizers
		let gestureRecognizerByTapOnView = UIPanGestureRecognizer(target: self, action: #selector(changeColorOfCircleViewWithRecognizer))
		let swipeUpDown = UISwipeGestureRecognizer(target: self, action: #selector(exit))
		swipeUpDown.direction = .down
		
		circleGradientView.addGestureRecognizer(gestureRecognizerByTapOnView)
		view.addGestureRecognizer(swipeUpDown)
		
		view.addSubview(circleGradientView)
	}
	
	override func viewWillLayoutSubviews() {
		circleGradientView.center = view.center
		circleGradientView.colorsArray = getColorOfView(x: circleGradientView.center.x, y: circleGradientView.center.y)
	}
	
	//	MARK: - GradientView
	
	let circleGradientView: GradientView = {
		let size = UIScreen.main.bounds
		let view = GradientView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		view.layer.cornerRadius = 50
		return view
	}()
	
	
	//	MARK: - Change position and colors of circleGradientView
	@objc
	func changeColorOfCircleViewWithRecognizer(_ tap: UIPanGestureRecognizer) {
		let translation = tap.translation(in: self.view)
		if let view = tap.view as? GradientView {
			view.center = CGPoint(x:view.center.x + translation.x,
								  y:view.center.y + translation.y)
			view.colorsArray = getColorOfView(x: view.center.x, y: view.center.y)
		}
		tap.setTranslation(CGPoint.zero, in: self.view)
	}
	
	//	MARK: - Color definition function for the circleGradientView
	
	func getColorOfView(x: CGFloat, y: CGFloat) -> [UIColor] {
		
		let redX = abs(x).truncatingRemainder(dividingBy: 255) / 255
		let greenX = abs(x * 2).truncatingRemainder(dividingBy: 255) / 255
		let blueX = abs(x * 3).truncatingRemainder(dividingBy: 255) / 255
		
		let redY = abs(y).truncatingRemainder(dividingBy: 255) / 255
		let greenY = abs(y * 2).truncatingRemainder(dividingBy: 255) / 255
		let blueY = abs(y * 3).truncatingRemainder(dividingBy: 255) / 255
		
		
		return [UIColor(red: redX, green: greenX, blue: blueX, alpha: 1), UIColor(red: redY, green: greenY, blue: blueY, alpha: 1)]
	}
	
//	MARK: - Exit func
	@objc
	func exit() {
		dismiss(animated: true, completion: nil)
	}
}
