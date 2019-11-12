//
//  TaskModel.swift
//  Trello
//
//  Created by Дарья Витер on 12/11/2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import Foundation

struct TaskForTrello {
	var label: String
	var content: String
	var id: String
	
	init(label: String, content: String) {
		self.id = UUID().uuidString
		self.label = label
		self.content = content
	}
	
	init() {
		self.id = UUID().uuidString
		self.label = ""
		self.content = ""
	}
}

struct TaskListForTrello {
	var name: String
	var tasks: [TaskForTrello] = []
	var id: String = UUID().uuidString
	
	let defaultSettings = UserDefaults.standard
	
	
	public mutating func addTaskToTheList(_ task: TaskForTrello) {
		if tasks
			.filter({ (taskFromList: TaskForTrello) -> Bool in
			taskFromList.id == task.id})
			.isEmpty {
			print("Not the same task")
			tasks.append(task)
		} else {
			print("The same task")
			
			removeTaskFromTheList(withId: task.id)
			tasks.append(task)
		}
	}
	
	public mutating func removeTaskFromTheList(withId id: String) {
		self.tasks.removeAll(where: { $0.id == id })
	}
	
	public func load() {
//		tasks = []
//		let someTask = TaskForTrello()
//		if let arrayOfTasks = defaultSettings.array(forKey: "tasksArray") as? [[String: Any]] {
//			for item in arrayOfTasks {
//
//				let task = someTask.parse(json: item)
//				tasks.append(task!)
//
//			}
	}
	
	public func saveToFile() {
		var tasksForSave = [[String: Any]]()
		for taskToSave in self.tasks {
//			tasksForSave.append(noteToSave.json)
		}
//		lock.lock()
		defaultSettings.set(tasksForSave as NSArray, forKey: "taskList")
//		lock.unlock()
		print("save to DB ok, count of notes: \(tasksForSave.count)")
	}
}

class DeskOfTaskForTrello {
	var tasksInDesk: [TaskListForTrello] = []
	
	public func add(_ task: TaskForTrello) {
//		if tasksInDesk.filter({ (taskFromList: TaskForTrello) -> Bool in
//			taskFromList.id == task.id }).isEmpty {
//			print("not same note")
//
//			tasksInDesk.append(task)
//
//		} else {
//			print("same note")
//			remove(withID: task.id)
//			tasksInDesk.append(task)
//
//		}
	}
	
	public func remove(withID id: String) {
		self.tasksInDesk.removeAll(where: { $0.id == id })
	}
	
	public func load() {
		
	}
	
	public func save() {
		
	}
}
