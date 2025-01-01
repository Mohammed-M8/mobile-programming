//
//  CVCreationOrgViewController.swift
//  pursuit
//
//  Created by BP-36-201-09 on 27/12/2024.
//

import UIKit

class CVCreationOrgViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var cvData: CVModel?
    private var removeButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        // Create Remove CV button
        removeButton = UIBarButtonItem(
            title: "Remove CV",
            style: .plain,
            target: self,
            action: #selector(removeButtonTapped)
        )
        removeButton.tintColor = .red
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        tableView.separatorStyle = .none
        tableView.register(CustomCVCell.self, forCellReuseIdentifier: CustomCVCell.identifier)
        
        // Add some padding at the top
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load saved CV data
        cvData = CVDataManager.shared.loadCV()
        
        // Show/hide remove button based on CV existence
        updateRemoveButtonVisibility()
        
        tableView.reloadData()
    }
    
    private func updateRemoveButtonVisibility() {
        navigationItem.rightBarButtonItem = cvData != nil ? removeButton : nil
    }
    
    @objc private func removeButtonTapped() {
        let alert = UIAlertController(
            title: "Remove CV",
            message: "Are you sure you want to remove your CV?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Remove", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            
            // Remove CV data
            CVDataManager.shared.removeCV()
            self.cvData = nil
            
            // Hide remove button
            self.updateRemoveButtonVisibility()
            
            // Simply reload the entire table view
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        present(alert, animated: true)
    }
    
    @IBAction func createCVButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "CvCreationJobseeker", bundle: nil)
        if let cvCreationVC = storyboard.instantiateViewController(withIdentifier: "CVCReationInputTableViewController") as? CVCReationInputTableViewController {
            navigationController?.pushViewController(cvCreationVC, animated: true)
        }
    }
    
    // MARK: - Table View Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cvData != nil ? 4 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard cvData != nil else { return 0 }
        
        switch section {
        case 0: return 6 // First Name, Last Name, CPR, Age, Phone, Email
        case 1: return 1 // Professional Summary
        case 2: return 5 // Job Title, Company, Start Year, End Year, Responsibilities
        case 3: return 4 // Degree, Institution, Graduation Year, Additional Notes
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCVCell.identifier) as? CustomCVCell,
              let cv = cvData else { return UITableViewCell() }
        
        var text = ""
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: text = "First Name: \(cv.firstName)"
            case 1: text = "Last Name: \(cv.lastName)"
            case 2: text = "CPR: \(cv.cpr)"
            case 3: text = "Age: \(cv.age)"
            case 4: text = "Phone: \(cv.phoneNumber)"
            case 5: text = "Email: \(cv.email)"
            default: break
            }
            
        case 1:
            text = cv.professionalSummary
            
        case 2:
            switch indexPath.row {
            case 0: text = "Job Title: \(cv.workExperience.jobTitle)"
            case 1: text = "Company: \(cv.workExperience.company)"
            case 2: text = "Start Year: \(cv.workExperience.startYear)"
            case 3: text = "End Year: \(cv.workExperience.endYear)"
            case 4: text = "Responsibilities:\n\(cv.workExperience.responsibilities)"
            default: break
            }
            
        case 3:
            switch indexPath.row {
            case 0: text = "Degree: \(cv.education.degree)"
            case 1: text = "Institution: \(cv.education.institution)"
            case 2: text = "Graduation Year: \(cv.education.graduationYear)"
            case 3: text = "Additional Notes:\n\(cv.education.additionalNotes)"
            default: break
            }
            
        default: break
        }
        
        cell.configure(with: text)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(red: 0.2, green: 0.427, blue: 0.553, alpha: 1)
        
        switch section {
        case 0: label.text = "Personal Information"
        case 1: label.text = "Professional Summary"
        case 2: label.text = "Work Experience"
        case 3: label.text = "Educational Background"
        default: break
        }
        
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
