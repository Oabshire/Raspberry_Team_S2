//
//  NetWork.swift
//  VKnotes
//
//  Created by Дарья Витер on 17/11/2019.
//  Copyright © 2019 Fems. All rights reserved.
//

import UIKit

let session = AppDelegate.shared.session

func downloadPosts(_ completionHandler: @escaping (_ genres: [NoteFromBase]) -> ()) {
	
	let apiKey = "AIzaSyCHc17KIlD5V3QEnHIYJsn3VL4hSC5pGQY"
	var memesLink: String {
		return "https://troll-4d320.firebaseio.com/notes.json?avvrdd_token=\(apiKey))"
	}
	
//	let config = URLSessionConfiguration.default
//	let session = URLSession(configuration: config)
	
	let url = URL(string: memesLink)!
	let urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 120)
	
	let task = session.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
		do {
			let jsonText = try? JSONSerialization.jsonObject(with: data!, options: [])
			print(jsonText!)
			let notes = try JSONDecoder().decode([String: NoteFromBase].self, from: data!)
			print(notes)
			var notesFromFirebase = Array(notes.values)
//			AppDelegate.shared.categories = Array(posts.values)
//			self.categories = Array(posts.values)
			//                for (each) in self.categories{
			//                    self.category.append(each.title)
			//                }
			print("\n------\n\(notes)")
//			DispatchQueue.main.async {
//				self.tableView.reloadData()
//			}
//			print(notesFromFirebase)
			notesFromFirebase = notesFromFirebase.sorted{$0.text < $1.text}
			completionHandler(notesFromFirebase)
		} catch {
			print("\n------\n\(error)")
			completionHandler([])
		}
	})
	task.resume()
}


func uploadPosts(_ notes: [Note], _ completionHandler: @escaping (_ genres: Bool) -> ()) {

	let apiKey = "AIzaSyCHc17KIlD5V3QEnHIYJsn3VL4hSC5pGQY"
	var memesLink: String {
		return "https://troll-4d320.firebaseio.com/notes.json?avvrdd_token=\(apiKey))"
	}

//	'https://[PROJECT_ID].firebaseio.com/users/jack/name.json'

	var dataToLoad : [String : NoteFromBase] = [:]
		for index in 0 ..< notes.count {
			let tempNote = notes[index]
			let noteForBack = NoteFromBase(imageURL: tempNote.imageURL, text: tempNote.text)
			dataToLoad["note\(index)"] = noteForBack
		}
	print(dataToLoad)
	
	//	let dataToLoad = posts
	let config = URLSessionConfiguration.default
	let session = URLSession(configuration: config)

	let url = URL(string: memesLink)!
	var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 120)
	urlRequest.httpMethod = "PUT"
	urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
	urlRequest.httpBody = try! JSONEncoder().encode(dataToLoad)
	completionHandler(true)

	_ = session.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
		do {
			_ = String(data: data!, encoding: .utf8)
//			print("\n------\n\(posts!)")
		}
	}).resume()
}

func upload(image: UIImage?, withName name: String, completionHandler: @escaping (_ url: String) -> ()) {
	
	guard let image = image else { return  }
	
	let filename = name
	let boundary = UUID().uuidString
	let fieldName = "reqtype"
	let fieldValue = "fileupload"
	
//	let config = URLSessionConfiguration.default
//	let session = URLSession(configuration: config)
	
	// Set the URLRequest to POST and to the specified URL
	var urlRequest = URLRequest(url: URL(string: "https://catbox.moe/user/api.php")!)
	urlRequest.httpMethod = "POST"
	
	// Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data in a web browser
	urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
	
	var data = Data()
	
	// Add the field name and field value to the raw http request data
	// put two dashes ("-") in front of boundary string to separate different field/values
	data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
	data.append("Content-Disposition: form-data; name=\"\(fieldName)\"\r\n\r\n".data(using: .utf8)!)
	data.append("\(fieldValue)".data(using: .utf8)!)
	
	// Add the image to the raw http request data
	data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
	data.append("Content-Disposition: form-data; name=\"fileToUpload\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
	data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
	let img = image.pngData()!
	data.append(img)
	
	data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
	
	// Send a POST request to the URL, with the data we created earlier
	
	session.uploadTask(with: urlRequest, from: data, completionHandler: { (responseData, response, error) in
//		print("data: ", responseData, "response: ", response, "error: ", error)
		
		if(error != nil){
			print("\(error!.localizedDescription)")
			completionHandler("")
		}
		
		guard let responseData = responseData else {
			print("no response data")
			completionHandler("")
			return
		}
		
		if let responseString = String(data: responseData, encoding: .utf8) {
			print("uploaded to: \(responseString)")
			completionHandler(responseString)
		}
	}).resume()
}
