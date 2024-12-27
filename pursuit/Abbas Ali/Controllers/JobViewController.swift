//
//  ViewController.swift
//  JobPost1
//
//  Created by Abbas  on 12/13/24.
//

import UIKit

class JobViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    private let myView: UIView = {
           let myView = UIView()
           myView.backgroundColor = .systemGroupedBackground
           return myView
       }()
    
    var jobs: [JobData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Jobs"
        
        tableView.register(JobTableViewCell.self, forCellReuseIdentifier: JobTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100 // Set appropriate row height
        tableView.backgroundColor = .systemGroupedBackground
        tableView.separatorStyle = .none
        
        //Setup
        
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        updateTasks()
    
    }
    func updateTasks() {
        jobs.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        for x in 0..<count {
            if let title = UserDefaults().string(forKey: "task_\(x+1)"),
               let company = UserDefaults().string(forKey: "company_\(x+1)"),
               let location = UserDefaults().string(forKey: "location_\(x+1)") {
                            
                let createdDate = UserDefaults().object(forKey: "created_date_\(x+1)") as? Date ?? Date()
                            
                let job = JobData(
                    index: x+1,
                    title: title,
                    company: company,
                    location: location,
                    createdDate: createdDate
                )
                    jobs.append(job)
                }
            }
        
        tableView.reloadData()
    }
    
    @IBAction func didTapAdd() {
        
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.hidesBottomBarWhenPushed = true
        vc.title = "New Job"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JobTableViewCell.identifier, for: indexPath) as? JobTableViewCell else {
            return UITableViewCell()
        }
            
        let job = jobs[indexPath.row]
        
        cell.configure(with: job) { [weak self] in
            self?.showModifyView(for: job)
        }
            
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let job = jobs[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
        vc.hidesBottomBarWhenPushed = true
        vc.title = job.title
        vc.task = job.title
        vc.taskIndex = job.index
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Add swipe-to-delete functionality
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Create delete action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            [weak self] (action, view, completionHandler) in
            self?.showDeleteConfirmation(at: indexPath)
            completionHandler(true)
            }
       
        // Create swipe action configuration
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    private func showDeleteConfirmation(at indexPath: IndexPath) {
        let alert = UIAlertController(title: "Delete Job",
                                    message: "Are you sure about deleting?",
                                    preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            self?.handleDelete(at: indexPath)
        })
        
        present(alert, animated: true)
    }
    
    private func showModifyView(for job: JobData) {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.hidesBottomBarWhenPushed = true
        vc.title = "Modify Job"
        vc.isModifying = true
        vc.existingTask = job.title
        vc.existingTaskIndex = job.index
        vc.existingCompany = job.company
        
        // Get other existing data
        if let ec = UserDefaults().string(forKey: "ec_\(job.index)") {
            vc.existingEC = ec
        }
        if let salary = UserDefaults().string(forKey: "salary_\(job.index)") {
            vc.existingSalary = salary
        }
        if let type = UserDefaults().string(forKey: "type_\(job.index)") {
            vc.existingType = type
        }
        if let location = UserDefaults().string(forKey: "location_\(job.index)") {
            vc.existingLocation = location
        }
        if let details = UserDefaults().string(forKey: "details_\(job.index)") {
            vc.existingDetails = details
        }
        if let requirements = UserDefaults().string(forKey: "requirements_\(job.index)") {
            vc.existingRequirements = requirements
        }
        
        vc.update = { [weak self] in
            self?.updateTasks()
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }

    // Handle delete action
    private func handleDelete(at indexPath: IndexPath) {
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        let job = jobs[indexPath.row]
        let taskPosition = job.index
        
        
            if taskPosition < count { // Only shift if there are items after the current position
                // Shift remaining tasks
               for i in taskPosition..<count {
                   if let nextTask = UserDefaults().value(forKey: "task_\(i+1)") as? String {
                       UserDefaults().set(nextTask, forKey: "task_\(i)")
                                   
                        // Also move associated data
                        if let nextCompany = UserDefaults().value(forKey: "company_\(i+1)") {
                            UserDefaults().set(nextCompany, forKey: "company_\(i)")
                        }
                        if let nextEC = UserDefaults().value(forKey: "ec_\(i+1)") {
                            UserDefaults().set(nextEC, forKey: "ec_\(i)")
                        }
                        if let nextSalary = UserDefaults().value(forKey: "salary_\(i+1)") {
                            UserDefaults().set(nextSalary, forKey: "salary_\(i)")
                        }
                        if let nextType = UserDefaults().value(forKey: "type_\(i+1)") {
                            UserDefaults().set(nextType, forKey: "type_\(i)")
                        }
                        if let nextLocation = UserDefaults().value(forKey: "location_\(i+1)") {
                            UserDefaults().set(nextLocation, forKey: "location_\(i)")
                        }
                        if let nextDetails = UserDefaults().value(forKey: "details_\(i+1)") {
                            UserDefaults().set(nextDetails, forKey: "details_\(i)")
                        }
                        if let nextRequirements = UserDefaults().value(forKey: "requirements_\(i+1)") {
                            UserDefaults().set(nextRequirements, forKey: "requirements_\(i)")
                        }
                        if let nextImageName = UserDefaults().string(forKey: "imageName_\(i+1)") {
                            UserDefaults().set(nextImageName, forKey: "imageName_\(i)")
                        }
                        if let nextImageData = UserDefaults().data(forKey: "logo_\(i+1)") {
                            UserDefaults().set(nextImageData, forKey: "logo_\(i)")
                        }
                       if let nextCreatedDate = UserDefaults().object(forKey: "created_date_\(i+1)") as? Date {
                            UserDefaults().set(nextCreatedDate, forKey: "created_date_\(i)")
                        }
                    }
                }
            }
               // Remove the last task and decrease count
                UserDefaults().removeObject(forKey: "task_\(count)")
                UserDefaults().removeObject(forKey: "company_\(count)")
                UserDefaults().removeObject(forKey: "ec_\(count)")
                UserDefaults().removeObject(forKey: "salary_\(count)")
                UserDefaults().removeObject(forKey: "type_\(count)")
                UserDefaults().removeObject(forKey: "location_\(count)")
                UserDefaults().removeObject(forKey: "details_\(count)")
                UserDefaults().removeObject(forKey: "requirements_\(count)")
                UserDefaults().removeObject(forKey: "logo_\(count)")
                UserDefaults().removeObject(forKey: "imageName_\(count)")
                UserDefaults().removeObject(forKey: "created_date_\(count)")
                        
                UserDefaults().set(count - 1, forKey: "count")
                            
                // Update the tasks array and table view
                jobs.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
        
                // Show success message
                let successAlert = UIAlertController(title: "Success",
                                                     message: "Job deleted successfully",
                                                     preferredStyle: .alert)
                successAlert.addAction(UIAlertAction(title: "OK", style: .default))
                present(successAlert, animated: true)
            
                // Refresh the view to ensure proper indexing
                updateTasks()
            }
        }

    
