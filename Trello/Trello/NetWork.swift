//
//  NetWork.swift
//  VKnotes
//
//  Created by Дарья Витер on 17/11/2019.
//  Copyright © 2019 Fems. All rights reserved.
//

import Foundation

func downloadPosts(_ completionHandler: @escaping (_ genres: [NoteFromBase]) -> ()) {
	
	let apiKey = "AIzaSyCHc17KIlD5V3QEnHIYJsn3VL4hSC5pGQY"
	var memesLink: String {
		return "https://troll-4d320.firebaseio.com/notes.json?avvrdd_token=\(apiKey))"
	}
	
	let config = URLSessionConfiguration.default
	let session = URLSession(configuration: config)
	
	let url = URL(string: memesLink)!
	let urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 120)
	
	let task = session.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
		do {
			let jsonText = try? JSONSerialization.jsonObject(with: data!, options: [])
			print(jsonText)
			let notes = try JSONDecoder().decode([String: NoteFromBase].self, from: data!)
			print(notes)
			let notesFromFirebase = Array(notes.values)
//			AppDelegate.shared.categories = Array(posts.values)
//			self.categories = Array(posts.values)
			//                for (each) in self.categories{
			//                    self.category.append(each.title)
			//                }
			print("\n------\n\(notes)")
//			DispatchQueue.main.async {
//				self.tableView.reloadData()
//			}
			print(notesFromFirebase)
			completionHandler(notesFromFirebase)
		} catch {
			print("\n------\n\(error)")
			completionHandler([])
		}
	})
	task.resume()
}

//func uploadPosts(_ posts: [NoteFromBase], _ completionHandler: @escaping (_ genres: Bool) -> ()) {
//
//	let apiKey = "AIzaSyCHc17KIlD5V3QEnHIYJsn3VL4hSC5pGQY"
//	var memesLink: String {
//		return "https://troll-4d320.firebaseio.com/notes.json?avvrdd_token=\(apiKey))"
//	}
//
//	var dataToLoad : [String : NoteFromBase] = [:]
//		for index in 0 ..< posts.count {
//			dataToLoad["note\(index)"] = posts[index]
//		}
//	print(dataToLoad)
//	//	let dataToLoad = posts
//	let config = URLSessionConfiguration.default
//	let session = URLSession(configuration: config)
//
//	let url = URL(string: noteLink)!
//	var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 120)
//	urlRequest.httpMethod = "PUT"
//	urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//	urlRequest.httpBody = try! JSONEncoder().encode(dataToLoad)
//	completionHandler(true)
//
//	let task = session.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
//		do {
//			let posts = String(data: data!, encoding: .utf8)
//			print("\n------\n\(posts)")
//		}
//	}).resume()
//}
