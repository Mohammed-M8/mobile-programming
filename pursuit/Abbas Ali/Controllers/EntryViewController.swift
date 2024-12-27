//
//  EntryViewController.swift
//  JobPost1
//
//  Created by Abbas  on 12/13/24.
//

import UIKit
import Photos
import PhotosUI

class EntryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var field: UITextField!
    @IBOutlet var companyField: UITextField!
    @IBOutlet var extraCommentField: UITextView!
    @IBOutlet var salaryField: UITextField!
    @IBOutlet var typeField: UITextField!
    @IBOutlet var locationField: UITextField!
    @IBOutlet var detailsField: UITextView!
    @IBOutlet var requirementsField: UITextView!
    @IBOutlet weak var imageButton: UIButton!
    // @IBOutlet weak var logoImageView: UIImageView!
    
    var update: (() -> Void)?
    private var selectedImage: UIImage?
    private var hasUnsavedChanges = false
    
    var isModifying = false
    var existingTask: String?
    var existingTaskIndex: Int?
    var existingCompany: String?
    var existingEC: String?
    var existingSalary: String?
    var existingType: String?
    var existingLocation: String?
    var existingDetails: String?
    var existingRequirements: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        field.delegate = self
        companyField.delegate = self
        
        //Set up TextViews
        setupTextViews()
        
        // Set the right button title based on mode
        let buttonTitle = isModifying ? "Save" : "Add"
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle,
                                                                  style: .done,
                                                                  target: self,
                                                                  action: #selector(saveTask))
        
        // Add back button confirmation
                navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(backButtonTapped))
        
        if isModifying {
            field.text = existingTask
            companyField.text = existingCompany
            extraCommentField.text = existingEC
            salaryField.text = existingSalary
            typeField.text = existingType
            locationField.text = existingLocation
            detailsField.text = existingDetails
            requirementsField.text = existingRequirements
            
            if let index = existingTaskIndex {
                // Load the image name instead of the image
                if let storedImageName = UserDefaults().string(forKey: "imageName_\(index)") {
                    imageButton.setTitle(storedImageName, for: .normal)
                }
                if let imageData = UserDefaults().data(forKey: "logo_\(index)") {
                                    selectedImage = UIImage(data: imageData)
                }
            }
        }
        
        setupTextChangeObservers()
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
    }
    
    private func setupTextViews() {
        // Configure the text views
        let textViews = [extraCommentField, detailsField, requirementsField]
        
        for textView in textViews {
            textView?.layer.borderWidth = 1.0
            textView?.layer.borderColor = UIColor.systemGray5.cgColor
            textView?.layer.cornerRadius = 5.0
            textView?.font = .systemFont(ofSize: 16)
        }
    }
    
    private func setupTextChangeObservers() {
        // For text fields
        field.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        companyField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        salaryField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        typeField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        locationField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        
        // For text views
        extraCommentField.delegate = self
        detailsField.delegate = self
        requirementsField.delegate = self
    }
        
    @objc private func textChanged() {
        hasUnsavedChanges = true
    }
    
    @objc private func backButtonTapped() {
        if hasUnsavedChanges {
            showDiscardAlert()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func showDiscardAlert() {
        let alert = UIAlertController(title: "Discard Changes",
                                    message: "Are you sure about Discarding?",
                                    preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Keep Editing", style: .cancel))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        
        present(alert, animated: true)
    }
    
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
    
    @IBAction func didTapImageButton(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = false // to get original image
        picker.imageExportPreset = .current //allow asset property access
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { // original image
            return
        }
        selectedImage = image
        hasUnsavedChanges = true
        
        // Try to get the image URL
            if let imageURL = info[.imageURL] as? URL {
                // Get the filename without extension
                let displayName = imageURL.deletingPathExtension().lastPathComponent
                
                // Set the button title to the image name
                imageButton.setTitle(displayName, for: .normal)
                
                // Store the image name temporarily
                UserDefaults().set(displayName, forKey: "temp_image_name")
        }
        
        picker.dismiss(animated: true)
    }
        
    @objc func saveTask() {
        guard validateFields() else { return }
        showSaveConfirmationAlert()
    }
    private func validateFields() -> Bool {
        guard let jobTitle = field.text, !jobTitle.isEmpty else {
                showAlert(title: "Error", message: "Job Title Should not be empty!")
                return false
            }
            
            guard let companyName = companyField.text, !companyName.isEmpty else {
                showAlert(title: "Error", message: "Company Name Should not be empty!")
                return false
            }
            
            guard selectedImage != nil else {
                showAlert(title: "Error", message: "Logo not selected!")
                return false
            }
            
            guard let comment = extraCommentField.text, !comment.isEmpty else {
                showAlert(title: "Error", message: "You must Include some Comment!")
                return false
            }
            
            guard let salary = salaryField.text, !salary.isEmpty else {
                showAlert(title: "Error", message: "No Salary set!")
                return false
            }
                
            guard let type = typeField.text, !type.isEmpty else {
                showAlert(title: "Error", message: "Type Should not be empty!")
                return false
            }
                
            guard let location = locationField.text, !location.isEmpty else {
                showAlert(title: "Error", message: "No Location set!")
                return false
            }
            
            guard let details = detailsField.text, !details.isEmpty else {
                showAlert(title: "Error", message: "Details Should not be empty!")
                return false
            }
            
            guard let requirements = requirementsField.text, !requirements.isEmpty else {
                showAlert(title: "Error", message: "Requirements Should not be empty!")
                return false
            }
        
        return true
    }
    private func showSaveConfirmationAlert() {
        let title = isModifying ? "Save Changes" : "Add Job"
        let message = isModifying ? "Are you sure you want to save these changes?" : "Are you sure you want to add this job?"
        
        let alert = UIAlertController(title: title,
                                    message: message,
                                    preferredStyle: .alert)
            
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: isModifying ? "Save" : "Add", style: .default) { [weak self] _ in
            self?.performSave()
        })
            
        present(alert, animated: true)
    }
        
    private func performSave() {
        guard let jobTitle = field.text,
                let companyName = companyField.text,
                let comment = extraCommentField.text,
                let salary = salaryField.text,
                let type = typeField.text,
                let location = locationField.text,
                let details = detailsField.text,
                let requirements = requirementsField.text else {
            return
        }
            
        let newCount: Int
            
                if isModifying {
                    guard let index = existingTaskIndex else {
                        return
                    }
                    UserDefaults().set(jobTitle, forKey: "task_\(index)")
                    UserDefaults().set(companyName, forKey: "company_\(index)")
                    UserDefaults().set(comment, forKey: "ec_\(index)")
                    UserDefaults().set(salary, forKey: "salary_\(index)")
                    UserDefaults().set(type, forKey: "type_\(index)")
                    UserDefaults().set(location, forKey: "location_\(index)")
                    UserDefaults().set(details, forKey: "details_\(index)")
                    UserDefaults().set(requirements, forKey: "requirements_\(index)")
                    
                    // Save image and image name
                    if let image = selectedImage {
                        if let imageData = image.jpegData(compressionQuality: 0.8) {
                            UserDefaults().set(imageData, forKey: "logo_\(index)")
                            
                            // Save the image name
                            if let imageName = UserDefaults().string(forKey: "temp_image_name") {
                                UserDefaults().set(imageName, forKey: "imageName_\(index)")
                            }
                        }
                    }
                    newCount = index
                } else {
                    let count = UserDefaults().integer(forKey: "count")
                    newCount = count + 1
                    UserDefaults().set(newCount, forKey: "count")
                    
                    UserDefaults().set(jobTitle, forKey: "task_\(newCount)")
                    UserDefaults().set(companyName, forKey: "company_\(newCount)")
                    UserDefaults().set(comment, forKey: "ec_\(newCount)")
                    UserDefaults().set(salary, forKey: "salary_\(newCount)")
                    UserDefaults().set(type, forKey: "type_\(newCount)")
                    UserDefaults().set(location, forKey: "location_\(newCount)")
                    UserDefaults().set(details, forKey: "details_\(newCount)")
                    UserDefaults().set(requirements, forKey: "requirements_\(newCount)")
                    
                    // Save image and image name for new entry
                    UserDefaults().set(Date(), forKey: "created_date_\(newCount)")
                    
                    if let image = selectedImage {
                        if let imageData = image.jpegData(compressionQuality: 0.8) {
                            UserDefaults().set(imageData, forKey: "logo_\(newCount)")
                            
                            // Save the image name
                            if let imageName = UserDefaults().string(forKey: "temp_image_name") {
                                UserDefaults().set(imageName, forKey: "imageName_\(newCount)")
                            }
                        }
                    }
                }
                // Clean up temporary storage
                UserDefaults().removeObject(forKey: "temp_image_name")
                
                showAlert(title: "Success", message: "Job Post Added!") { [weak self] in
                            
                    if let JobViewController = self?.navigationController?.viewControllers.first as? JobViewController {
                    DispatchQueue.main.async {
                        JobViewController.updateTasks()
                    }
                }
                            
                    self?.update?()
                    self?.navigationController?.popToRootViewController(animated: true)
                
            
        }
    }
}



extension EntryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension EntryViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        hasUnsavedChanges = true
    }
}

