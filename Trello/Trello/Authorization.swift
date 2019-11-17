//
//  Authorization.swift
//  Trello
//
//  Created by Погос  on 16.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import UIKit
import WebKit

class Authorization: UIViewController, WKNavigationDelegate {
    
    let web = WKWebView()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = web
        web.navigationDelegate = self
        web.load(Net.shared.authorizationUrl())
        
        button.addTarget(self, action: #selector(touchUpButton), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc
    private func touchUpButton() {
        dismiss(animated: true, completion: nil)
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.documentElement.innerHTML") { (value, error) in
            
            guard let value = value as? String, error == nil else {
                print(error!.localizedDescription)
                return
            }
            let range = NSRange(location: 0, length: value.count)
            let regex = try! NSRegularExpression(pattern: "<pre>[a-zA-Z0-9]{64}</pre>")
            guard let match = regex.firstMatch(in: value, options: [], range: range) else { return }

            let convertMatch = String(value[Range(match.range, in: value)!])
            
            let rangeToken = Range(NSRange(location: 5, length: 64), in: convertMatch)
            let token = convertMatch.substring(with: rangeToken!)
           
            AppDelegate.shared.rootViewController.switchToMainScreen()
            self.dismiss(animated: true, completion: nil)
        }
    }
}
    
    


