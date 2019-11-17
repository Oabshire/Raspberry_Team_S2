//
//  NewNoteViewController.swift
//  Trello
//
//  Created by Onie on 10.11.2019.
//  Copyright © 2019 Raspberry. All rights reserved.
//

import UIKit


class NewNoteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var tableView = UITableView()
	
	var imageIsPicked = false
	
	var tempIndex: Int!
	let noteService = NoteService.shared
	let noteVC = NoteViewController()
	let imagePickerVC = ImagePickerTableViewCell()
	let textFieldVC = TextFieldTableViewCell()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = .white
		
		tableView.frame = self.view.frame
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(ImagePickerTableViewCell.self, forCellReuseIdentifier: ImagePickerTableViewCell.reuseId)
		tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: TextFieldTableViewCell.reuseId)
		
		tableView.rowHeight = UITableView.automaticDimension
		
		tableView.tableFooterView = UIView()
		
		view.addSubview(tableView)
		
		textFieldVC.textField.frame = view.frame
		textFieldVC.textField.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		textFieldVC.textField.font = UIFont.systemFont(ofSize: 20)
		view.addSubview(textFieldVC)
		
		if tempIndex == nil {
			tempIndex = NoteService.shared.notes.count
		}
		
		
		let saveBarItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
		navigationController?.viewControllers[1].navigationItem.rightBarButtonItem = saveBarItem
	}
	
	@objc
	func saveNote(){
		
		if NoteService.shared.isEdit {
			if let temp = textFieldVC.textField.text {
				NoteService.shared.notes[tempIndex].text = temp
			}
		} else {
			if let temp = textFieldVC.textField.text {
				NoteService.shared.notes.append(Note(text: temp, image: imagePickerVC.imagePicker.image, imageURL: ""))
			}
			
//			uploadPosts(NoteService.shared.notes) {
//				result in
//				print(result)
//			}
			
		}
		
		uploadPosts(NoteService.shared.notes) {
			result in
			print(result)
		}
		//		if noteService.isEdit {
		//            if let temp = textFieldVC.textField.text {
		//                noteVC.noteService.notes[tempIndex].text = temp
		//            }
		//        } else {
		//            if let temp = textFieldVC.textField.text {
		//                let note = Note(text: temp, image: imagePickerVC.imagePicker.image?.pngData())
		//                noteService.notes.append(note)
		//            }
		//        }
		//
		//
		//		textFieldVC.textField.resignFirstResponder()
		//		noteService.isEdit = false
		navigationController?.popViewController(animated: true)
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 0 {
			let cameraIcon = UIImage(named: "image")
			let photoIcon = UIImage(named: "image")
			
			let actionSheet = UIAlertController(title: nil,
												message: nil,
												preferredStyle: .actionSheet)
			
			let camera = UIAlertAction(title: "Camera", style: .default) { _ in
				self.chooseImagePicker(source: .camera)
			}
			camera.setValue(cameraIcon, forKey: "image")
			camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
			
			let photo = UIAlertAction(title: "Photo", style: .default) { _ in
				self.chooseImagePicker(source: .photoLibrary)
			}
			photo.setValue(photoIcon, forKey: "image")
			photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
			
			let cancel = UIAlertAction(title: "Cancel", style: .cancel)
			
			actionSheet.addAction(camera)
			actionSheet.addAction(photo)
			actionSheet.addAction(cancel)
			
			present(actionSheet, animated: true)
		} else {
			view.endEditing(true)
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			let cell = imagePickerVC
			return cell
			
		} else {
			let cell = textFieldVC
			return cell
		}
	}
}

//MARK: Work with image
extension NewNoteViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
	func chooseImagePicker(source: UIImagePickerController.SourceType){
		
		if UIImagePickerController.isSourceTypeAvailable(source){
			let imagePicker = UIImagePickerController()
			imagePicker.delegate = self
			imagePicker.allowsEditing = true
			imagePicker.sourceType = source
			present(imagePicker, animated:true, completion: nil)
		}
		else {
			let alert  = UIAlertController(title: "Ошибка!", message: "Ваше устройство не поддерживает работу с камерой!", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			self.present(alert, animated: true, completion: nil)
		}
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let image = info[.originalImage] as? UIImage {
			let selectedImage : UIImage = image // вот картинка
			imagePickerVC.imagePicker.image = selectedImage
			imagePickerVC.imagePicker.contentMode = .scaleAspectFill
			imagePickerVC.imagePicker.clipsToBounds = true
			
			imageIsPicked = true
			dismiss(animated: true)
		}
	}
}

