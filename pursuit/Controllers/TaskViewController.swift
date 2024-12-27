//
//  TaskViewController.swift
//  JobPost1
//
//  Created by Abbas  on 12/13/24.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet var label: UILabel!
    @IBOutlet var ecLabel: UITextView!
   // @IBOutlet var companyLabel: UILabel!
    @IBOutlet var salaryLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var detailsLabel: UITextView!
    @IBOutlet var requirementsLabel: UITextView!
    @IBOutlet var logoImageView: UIImageView!
    
      
    var task: String?
    var taskIndex: Int?
    var existingCompany: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = task
        
        // Set up promote button instead of delete
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Promote", style: .done, target: self, action: #selector(promoteTask))
        
        if let task = task {
            guard let count = UserDefaults().value(forKey: "count") as? Int else {
                return
            }
            for i in 0..<count {
                if let storedTask = UserDefaults().value(forKey: "task_\(i+1)") as? String, storedTask == task {
                    taskIndex = i + 1
                    
                   /* if let company = UserDefaults().string(forKey: "company_\(i+1)") {
                        companyLabel.text = company
                    } */
                    if let imageData = UserDefaults().data(forKey: "logo_\(i+1)") {
                        logoImageView.image = UIImage(data: imageData)
                    } else {
                        logoImageView.image = nil
                    } //Adding else to clear image if null
                    if let ec = UserDefaults().string(forKey: "ec_\(i+1)") {
                        ecLabel.text = ec
                    }
                    if let salary = UserDefaults().string(forKey: "salary_\(i+1)") {
                        salaryLabel.text = salary
                    }
                    if let type = UserDefaults().string(forKey: "type_\(i+1)") {
                        typeLabel.text = type
                    }
                    if let location = UserDefaults().string(forKey: "location_\(i+1)"){
                        locationLabel.text = location
                    }
                    if let details = UserDefaults().string(forKey: "details_\(i+1)") {
                        detailsLabel.text = details
                    }
                    if let requirements = UserDefaults().string(forKey: "requirements_\(i+1)") {
                        requirementsLabel.text = requirements
                    }
                    break
            }
        }
    }
}
    
    @objc func promoteTask() {
            // Add your promote functionality here
            print("Promote button tapped - Feature coming soon!")
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let viewController = navigationController?.viewControllers.first as? ViewController {
            viewController.updateTasks()
        }
    }
    
    @IBAction func modifyButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let entryVC = storyboard.instantiateViewController(withIdentifier: "entry") as? EntryViewController {
            entryVC.isModifying = true
            entryVC.existingTask = task
            entryVC.existingTaskIndex = taskIndex
            
            if let index = taskIndex {
                entryVC.existingCompany = UserDefaults().string(forKey: "company_\(index)")
            }
            
            entryVC.existingEC = ecLabel.text
            entryVC.existingSalary = salaryLabel.text
            entryVC.existingType = typeLabel.text
            entryVC.existingLocation = locationLabel.text
            entryVC.existingDetails = detailsLabel.text
            entryVC.existingRequirements = requirementsLabel.text
            
            navigationController?.pushViewController(entryVC, animated: true)
            
        }
    }
    
    @objc func deleteTask() {
        guard let taskToDelete = task else { return }
            
            // Get current count
            guard let count = UserDefaults().value(forKey: "count") as? Int else { return }
            
            // Find the position of task to delete
            var taskPosition = -1
            for i in 0..<count {
                if let storedTask = UserDefaults().value(forKey: "task_\(i+1)") as? String,
                   storedTask == taskToDelete {
                    taskPosition = i + 1
                    break
                }
            }
            
            if taskPosition != -1 {
                // Shift remaining tasks
                for i in taskPosition..<count {
                    if let nextTask = UserDefaults().value(forKey: "task_\(i+1)") as? String {
                        UserDefaults().set(nextTask, forKey: "task_\(i)")
                    }
                }
                
                // Remove the last task and decrease count
                UserDefaults().removeObject(forKey: "task_\(count)")
                UserDefaults().set(count - 1, forKey: "count")
                
                // Navigate back and update the task list
                navigationController?.popViewController(animated: true)
                
                // Update the main view controller's table
                if let viewController = navigationController?.viewControllers.first as? ViewController {
                    viewController.updateTasks()
                }
            }
    }
    

  

}
