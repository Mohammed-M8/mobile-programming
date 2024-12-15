//
//  EntryViewController.swift
//  JobPost1
//
//  Created by Abbas  on 12/13/24.
//

import UIKit

class EntryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var field: UITextField!
    @IBOutlet var extraCommentField: UITextField!
    @IBOutlet var salaryField: UITextField!
    @IBOutlet var typeField: UITextField!
    @IBOutlet var locationField: UITextField!
    @IBOutlet var detailsField: UITextField!
    @IBOutlet var requirementsField: UITextField!
    @IBOutlet weak var imageButton: UIButton!
    
    var update: (() -> Void)?
    private var selectedImage: UIImage?
    
    var isModifying = false
    var existingTask: String?
    var existingTaskIndex: Int?
    var existingEC: String?
    var existingSalary: String?
    var existingType: String?
    var existingLocation: String?
    var existingDetails: String?
    var existingRequirements: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        field.delegate = self
        extraCommentField.delegate = self
        
        if isModifying {
            field.text = existingTask
            extraCommentField.text = existingEC
            salaryField.text = existingSalary
            typeField.text = existingType
            locationField.text = existingLocation
            detailsField.text = existingDetails
            requirementsField.text = existingRequirements
            
            if let index = existingTaskIndex,
                let imageData = UserDefaults().data(forKey: "logo_\(index)"),
                let image = UIImage(data: imageData) {
                imageButton.setImage(image, for: .normal)
                selectedImage = image
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
    }
    
    @IBAction func didTapImageButton(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        selectedImage = image
        
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        imageButton.setImage(image, for: .normal)
        imageButton.imageView?.contentMode = .scaleAspectFit
        imageButton.clipsToBounds = true
        imageButton.backgroundColor = .clear
        imageButton.tintColor = .clear
        imageButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        imageButton.contentMode = .scaleAspectFit
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    
    @objc func saveTask() {
        
        guard let text = field.text, !text.isEmpty else {
            return
        }
        
        
        if isModifying {
            if let taskIndex = existingTaskIndex {
                UserDefaults().set(text, forKey: "task_\(taskIndex)")
            
            if let extraComment = extraCommentField.text {
                UserDefaults().set(extraComment, forKey: "ec_\(taskIndex)")
            }
                    
            if let salary = salaryField.text {
                UserDefaults().set(salary, forKey: "salary_\(taskIndex)")
            }
                    
            if let type = typeField.text {
                UserDefaults().set(type, forKey: "type_\(taskIndex)")
            }
                    
            if let location = locationField.text {
                UserDefaults().set(location, forKey: "location_\(taskIndex)")
            }
                    
            if let details = detailsField.text {
                UserDefaults().set(details, forKey: "details_\(taskIndex)")
            }
                    
            if let requirements = requirementsField.text {
                UserDefaults().set(requirements, forKey: "requirements_\(taskIndex)")
            }
                    
            if let image = selectedImage {
                if let imageData = image.jpegData(compressionQuality: 0.8) {
                    UserDefaults().set(imageData, forKey: "logo_\(taskIndex)")
                }
            }
                
                UserDefaults().synchronize()
        }
    } else {
            
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "task_\(newCount)")
        
        
        if let extraComment = extraCommentField.text {
            UserDefaults().set(extraComment, forKey: "ec_\(newCount)")
        }
        
        if let salary = salaryField.text {
            UserDefaults().set(salary, forKey: "salary_\(newCount)")
        }
        
        if let type = typeField.text {
            UserDefaults().set(type, forKey: "type_\(newCount)")
        }
        if let location = locationField.text {
            UserDefaults().set(location, forKey: "location_\(newCount)")
        }
        
        if let details = detailsField.text {
            UserDefaults().set(details, forKey: "details_\(newCount)")
        }
        
        if let requirements = requirementsField.text {
            UserDefaults().set(requirements, forKey: "requirements_\(newCount)")
        }
        if let image = selectedImage {
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                UserDefaults().set(imageData, forKey: "logo_\(newCount)")
            }
        }
        UserDefaults().synchronize()
    }
    
        if let viewController = navigationController?.viewControllers.first as? TasksUpdating {
            DispatchQueue.main.async {
                viewController.updateTasks()
            }
        }
        
        update?()
        navigationController?.popToRootViewController(animated: true)
    
    }
}

extension EntryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


