//
//  Net.swift
//  Trello
//
//  Created by Погос  on 16.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import Foundation

class Net {

    static public var shared = Net()
    private var apiKey = "e8376b95d6a2ed11b874d334758c6def"
    
    public func authorizationUrl() -> URLRequest {
        let url = "https://trello.com/1/authorize?expiration=never&name=RedTeam&scope=read&response_type=token&key=\(apiKey)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        return request
    }
}

