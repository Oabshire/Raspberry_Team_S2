//
//  Net.swift
//  Trello
//
//  Created by Погос  on 16.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import Foundation

class Net {
	
	enum Result<Value> {
		case success(Value)
		case failure(Error)
	}
	
	static public var shared = Net()
	
	private var apiKey = "e8376b95d6a2ed11b874d334758c6def"
	private var apiToken = "e27be8349b91634239fd229101e48430692286f9d3407e54a2231d64e3220702"
	private var idBoard = "5dc3fe73bdff515b188d5e64"
	
	public func authorizationUrl() -> URLRequest {
		let url = "https://trello.com/1/authorize?expiration=never&name=RaspberryTeam&scope=read&response_type=token&key=\(apiKey)"
		var request = URLRequest(url: URL(string: url)!)
		request.httpMethod = "GET"
		return request
	}
	
	//MARK: GET URL
	private func getUrlOfBoard() -> URLRequest {
		let url = URL(string: "https://api.trello.com/1/members/me/boards?key=\(apiKey)&token=\(apiToken)")!
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		return request
	}
	
	private func getUrlOfList()-> URLRequest {
		let url = URL(string:"https://api.trello.com/1/boards/\(idBoard)?lists=open&cards=all&key=\(apiKey)&token=\(apiToken)")!
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		return request
	}
	
	
	
	
	private func postUrlOfList(listName: String) -> URLRequest {
		let url = URL(string: "https://api.trello.com/1/lists?name=\(listName)&idBoard=\(idBoard)&pos=bottom&key=\(apiKey)" + "&token=\(apiToken)")!
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		return request
	}
	
	private func postUrlOfCard(cardName: String, listId: String) -> URLRequest {
		let url = URL(string: "https://api.trello.com/1/cards?name=\(cardName)&idList=\(listId)&keepFromSource=all&key=\(apiKey)" + "&token=\(apiToken)")!
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		return request
	}
	
	
	
	// MARK: get board element
	public func getMyBoards(completion: ((Result<[BoardKeys]>) -> Void)?) {
		mainSession(request: getUrlOfBoard(), completion: completion)
	}
	
	public func getMyLists(completion: ((Result<ModelList>) -> Void)? ) {
		mainSession(request: getUrlOfList(), completion: completion)
	}
	
	// MARK: add board element
	public func addNewList(listName: String, completion: ((Result<List>) -> Void)?) {
		mainSession(request: postUrlOfList(listName: listName), completion: completion)
	}
	
	public func addNewCard(listId: String, cardName: String, completion: ((Result<Card>) -> Void)?) {
		mainSession(request: postUrlOfCard(cardName: cardName, listId: listId), completion: completion)
	}
	
	//MARK: Session
	private func mainSession<T: Codable> (request: URLRequest, completion: ((Result<T>) -> Void)?) {
		let config = URLSessionConfiguration.default
		let session = URLSession(configuration: config)
		session.dataTask(with: request) { (data, responce, error) in
			guard let jsonData = data, error == nil else { completion?(.failure(error!)); return }
			let decoder = JSONDecoder()
			do {
				let decodedData = try decoder.decode(T.self, from: jsonData)
				completion?(.success(decodedData))
			} catch {
				completion?(.failure(error))
			}
		}.resume()
	}
}


