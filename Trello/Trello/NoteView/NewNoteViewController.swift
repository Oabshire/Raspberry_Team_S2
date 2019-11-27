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
	
	var tempIndex: Int! = NoteService.shared.notes.count
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
		
//		textFieldVC.textField.frame = CGRect(origin: view.frame.origin, size: CGSize(width: view.frame.size.width, height: 200))//view.frame
//		textFieldVC.backgroundColor = .lightGray
//		textFieldVC.textField.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//		textFieldVC.textField.font = UIFont.systemFont(ofSize: 20)
//		view.addSubview(textFieldVC)
		
		
		
		let saveBarItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
		navigationController?.viewControllers[1].navigationItem.rightBarButtonItem = saveBarItem
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		print(#function)
	}
	
	@objc
	func saveNote(){
		navigationController?.viewControllers[1].navigationItem.rightBarButtonItem?.isEnabled = false
		navigationController?.viewControllers[1].navigationItem.rightBarButtonItem?.tintColor = .gray
		
		if NoteService.shared.isEdit {
			NoteService.shared.isEdit = false
			if let temp = textFieldVC.textField.text {
				let image = (imagePickerVC.imagePicker.image)?.resized(toWidth: 200)
				let tempIm = UIImage(named: "Photo")
				NoteService.shared.notes[tempIndex].text = temp
				if imagePickerVC.imagePicker.image == UIImage(named: "Photo") {
					NoteService.shared.notes[tempIndex].image = nil
				} else {
					NoteService.shared.notes[tempIndex].image = image
				}
				if image != nil {
					
					upload(image: image, withName: "image\(tempIndex!)") {
						urlOfImage in
						DispatchQueue.main.async {
							
							//							print("tempIndex: ", self.tempIndex)
							NoteService.shared.notes[self.tempIndex].imageURL = urlOfImage
							print("notes: ", NoteService.shared.notes)
							
							print("--------------------")
							print("Note save")
							uploadPosts(NoteService.shared.notes) {
								result in
								print(result)
								print("--------------------")
								print("Notes uploaded")
								DispatchQueue.main.async {
									self.navigationController?.popViewController(animated: true)
								}
							}
						}
					}
				} else  {
					uploadPosts(NoteService.shared.notes) {
						result in
						print(result)
						print("--------------------")
						print("Notes uploaded")
						DispatchQueue.main.async {
							self.navigationController?.popViewController(animated: true)
						}
					}
				}
				
			}
		} else {
			
			if let temp = textFieldVC.textField.text {
				let imageForNote = (imagePickerVC.imagePicker.image)?.resized(toWidth: 200)
				NoteService.shared.notes[tempIndex].text = temp
				if imageForNote != nil {
					if imagePickerVC.imagePicker.image == UIImage(named: "Photo") {
						NoteService.shared.notes[tempIndex].image = nil
					} else {
						NoteService.shared.notes[tempIndex].image = imageForNote
					}
					
					upload(image: imageForNote, withName: "image\(tempIndex!)") {
						urlOfImage in
						DispatchQueue.main.async {
							print("tempIndex: ", self.tempIndex)
							NoteService.shared.notes[self.tempIndex].imageURL = urlOfImage
							print("notes: ", NoteService.shared.notes)
							//						NoteService.shared.notes.append(Note(text: temp, image: image!, imageURL: urlOfImage))
							print("--------------------")
							print("Note save")
							uploadPosts(NoteService.shared.notes) {
								result in
								print(result)
								print("--------------------")
								print("Notes uploaded")
								DispatchQueue.main.async {
									self.navigationController?.popViewController(animated: true)
								}
							}
						}
					}
				} else {
					uploadPosts(NoteService.shared.notes) {
						result in
						print(result)
						print("--------------------")
						print("Notes uploaded")
						DispatchQueue.main.async {
							self.navigationController?.popViewController(animated: true)
						}
					}
				}
			}
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
//		navigationController?.popViewController(animated: true)
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 0 {
			
//			let cell = tableView.cellForRow(at: indexPath) as! ImagePickerTableViewCell
			//			cell.contentView.willRemoveSubview(imagePickerVC)
			
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
			cell.imagePicker.image = NoteService.shared.notes[tempIndex].image ?? UIImage(named: "Photo")
			return cell
			
		} else {
			let cell = textFieldVC
			let topSafeArea = view.safeAreaInsets.top
			let bottomSafeArea = view.safeAreaInsets.bottom
			textFieldVC.heightOfNote = view.frame.size.height - imagePickerVC.frame.size.height - topSafeArea - bottomSafeArea
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
			imagePickerVC.reloadInputViews()
			
			NoteService.shared.notes[tempIndex].image = selectedImage
			tableView.reloadData()
			
			imageIsPicked = true
			dismiss(animated: true)
		}
	}
}

extension UIImage {
	enum JPEGQuality: CGFloat {
		case lowest  = 0
		case low     = 0.25
		case medium  = 0.5
		case high    = 0.75
		case highest = 40
	}
	
	func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
		return jpegData(compressionQuality: jpegQuality.rawValue)
	}
	
	func resized(withPercentage percentage: CGFloat) -> UIImage? {
		let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
		return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
			_ in draw(in: CGRect(origin: .zero, size: canvas))
		}
	}
	func resized(toWidth width: CGFloat) -> UIImage? {
		let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
		return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
			_ in draw(in: CGRect(origin: .zero, size: canvas))
		}
	}
}

