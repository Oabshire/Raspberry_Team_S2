//
//  GradientView.swift
//  UIVIewLectApp
//
//  Created by Дарья Витер on 05/11/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

final class GradientView: UIView {
	public var colorsArray : [UIColor] = [] {
		didSet {
			update()
		}
	}
	
	override class var layerClass: AnyClass {
		return CAGradientLayer.self
	}
	
	var gradientLayer: CAGradientLayer {
		return layer as? CAGradientLayer ?? CAGradientLayer()
	}
	
	func update() {
		gradientLayer.colors = colorsArray.compactMap { $0.cgColor }
	}
}
