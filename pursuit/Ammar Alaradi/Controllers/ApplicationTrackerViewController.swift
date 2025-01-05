//
//  ApplicationTrackerViewController.swift
//  pursuit
//
//  Created by BP-36-201-21 on 11/12/2024.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth


// SORTING
enum applicationSortType: CaseIterable {
    case oldest
    case newest
    case ascending
    case descending
    
    var title: String {
        switch self {
        case .oldest: return "Oldest First"
        case .newest: return "Most Recent"
        case .ascending: return "A-Z"
        case .descending: return "Z-A"
        }
    }
}
// SORTING

class ApplicationTrackerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    
    @IBOutlet weak var TableViewApplication: UITableView!
    
    var profileImage = ""
    var firstName = ""
    var lastName = ""
    
    var jobSeekerApplications: [JobSeekerApplication] = []
    
    var filteredJobSeekerApplications: [JobSeekerApplication] = []
    
    var applicationSortTypes: [applicationSortType] = [.oldest, .newest, .ascending, .descending]
    var applicationFilterTypes: [ApplicationStatus] = [.rejected, .pending, .accepted]
    
    var isDeleting: Bool = false
    
    var currentUserId: String {
        return Auth.auth().currentUser?.uid ?? "noUser"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredJobSeekerApplications = jobSeekerApplications
        self.profileImg.image = UIImage(named: profileImage)
        self.userNameLbl.text = "Hello,\n\(firstName) \(lastName)"
        
        let nib = UINib(nibName: "ApplicationTableViewCell", bundle: nil)
        TableViewApplication.register(nib, forCellReuseIdentifier: "Application")
        TableViewApplication.dataSource = self
        TableViewApplication.delegate = self
        
        //fetch from firestore
//        fetchJobSeekerApplicationsFromFirestore()
        fetchJobSeekerApplicationsFromFirestore()
    }
    
    override func viewDidLayoutSubviews() {
        profileImg.layer.cornerRadius = profileImg.frame.size.height / 2
    }
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        isDeleting.toggle()
        sender.setTitle(isDeleting ? "Cancel" : "Delete", for: .normal)
        sender.tintColor = isDeleting ? .systemBlue : .red
        self.TableViewApplication.reloadData()
    }
    
    @IBAction func sortTapped(_ sender: Any) {
        self.showSortSheet()
    }
    
    @IBAction func filterTapped(_ sender: Any) {
        self.showFilterSheet()
    }
    
//    //FETCH FUNCTION
    
    func fetchJobSeekerApplicationsFromFirestore() {
        let db = Firestore.firestore()
        
        let jobSeekerRef = db.collection("jobSeeker").document(currentUserId)

        let query = db.collection("JobApplications")
            .whereField("AppJobSeeker", isEqualTo: jobSeekerRef)
        
        query.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching JobApplications: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents, !documents.isEmpty else {
                print("No job applications found for this user.")
                return
            }
            
            var tempApplications: [JobSeekerApplication] = []
            
            for doc in documents {
                let data = doc.data()
                
                // Read fields from Firestore
                let companyName = data["companyName"] as? String ?? "Unknown Company"
                let jobName = data["jobName"] as? String ?? "Unknown Job"
                let image = data["image"] as? String ?? "placeholder"
                
                // Convert status to ApplicationStatus
                let statusString = (data["status"] as? String ?? "pending").lowercased()
                let status: ApplicationStatus
                switch statusString {
                case "accepted":
                    status = .accepted
                case "rejected":
                    status = .rejected
                default:
                    status = .pending
                }
                
                // Convert Firestore Timestamp to a date string
                let dateString: String
                if let timestamp = data["date"] as? Timestamp {
                    let dateValue = timestamp.dateValue()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "MMMM dd, yyyy"
                    dateString = formatter.string(from: dateValue)
                } else {
                    dateString = "January 1, 2025"
                }
                
                // Create your local model object
                let application = JobSeekerApplication(
                    companyName: companyName,
                    jobName: jobName,
                    date: dateString,
                    image: image,
                    status: status,
                    documentId: doc.documentID
                )
                tempApplications.append(application)
            }
            
            // Assign to your arrays and refresh the table
            self.jobSeekerApplications = tempApplications
            self.filteredJobSeekerApplications = tempApplications
            DispatchQueue.main.async {
                self.TableViewApplication.reloadData()
            }
        }
    }
    
//    func fetchJobSeekerApplicationsFromFirestore() {
//            let db = Firestore.firestore()
//            
//            db.collection("jobSeeker").document(currentUserId)
//                .collection("jobSeekerApplications")
//                .getDocuments { snapshot, error in
//                    
//                    if let error = error {
//                        print("Error fetching job applications: \(error.localizedDescription)")
//                        return
//                    }
//                    
//                    guard let documents = snapshot?.documents else {
//                        print("No job applications found.")
//                        return
//                    }
//                    
//                    var tempApplications: [JobSeekerApplication] = []
//                    
//                    for doc in documents {
//                        let data = doc.data()
//                        
//                        // Map Firestore fields to model
//                        let companyName = data["companyName"] as? String ?? "Unknown Company"
//                        let jobName = data["jobName"] as? String ?? "Unknown Job"
//                        let date = data["date"] as? String ?? "January 1, 2025"
//                        let image = data["image"] as? String ?? "placeholder"
//                        
//                        // The status is stored as "pending", "accepted", "rejected"
//                        let statusString = data["status"] as? String ?? "pending"
//                        let status: ApplicationStatus
//                        switch statusString.lowercased() {
//                        case "accepted": status = .accepted
//                        case "rejected": status = .rejected
//                        default: status = .pending
//                        }
//                        
//                        // Create a JobSeekerApplication instance
//                        let application = JobSeekerApplication(
//                            companyName: companyName,
//                            jobName: jobName,
//                            date: date,
//                            image: image,
//                            status: status
//                        )
//                        tempApplications.append(application)
//                    }
//                    
//                    // Assign to array and reload
//                    self.jobSeekerApplications = tempApplications
//                    self.filteredJobSeekerApplications = tempApplications
//                    DispatchQueue.main.async {
//                        self.TableViewApplication.reloadData()
//                    }
//                }
//        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredJobSeekerApplications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewApplication.dequeueReusableCell(withIdentifier: "Application") as! ApplicationTableViewCell
        let jobSeekerApplication = filteredJobSeekerApplications[indexPath.row]
        cell.ParentView.backgroundColor = isDeleting ? .clear : jobSeekerApplication.status.color.withAlphaComponent(0.2)
        cell.CompanyImage.image = UIImage(named: jobSeekerApplication.image)
        cell.CompanyName.text = jobSeekerApplication.companyName
        cell.JobName.text = jobSeekerApplication.jobName
        cell.Date.text = jobSeekerApplication.date
        cell.DateView.backgroundColor = isDeleting ? .clear : jobSeekerApplication.status.color.withAlphaComponent(0.4)
        cell.DateView.layer.cornerRadius = 6
        cell.RemoveButton.isHidden  = !isDeleting
        cell.callBack = { [weak self] in
            self?.showDeleteAlert(index: indexPath.row)
        }
        return cell
    }
    
    func showDeleteAlert(index : Int) {
        let alert = UIAlertController(title: " Confirm Application Deletion", message: "Are you sure you want to delete this application?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Proceed", style: .default, handler: { _ in
            if let firstIndex = self.jobSeekerApplications.firstIndex(where: { $0.jobName == self.filteredJobSeekerApplications[index].jobName }) {
                self.jobSeekerApplications.remove(at: firstIndex)
            }
            self.filteredJobSeekerApplications.remove(at: index)
            self.TableViewApplication.reloadData()
        }))
        present(alert, animated: true)
    }
    
    func showSortSheet() {
        let alert = UIAlertController(title: "Sort By", message: "", preferredStyle: .actionSheet)
        for index in 0..<self.applicationSortTypes.count {
            alert.addAction(UIAlertAction(title: self.applicationSortTypes[index].title, style: .default, handler: { _ in
                self.sortActionTapped(applicationSortType: self.applicationSortTypes[index])
            }))
            
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
            self.filteredJobSeekerApplications = self.jobSeekerApplications
            self.TableViewApplication.reloadData()
        }))
        // For iPad: Configure popoverPresentationController
        if let popoverController = alert.popoverPresentationController {
            // Provide source view and source rect
            popoverController.sourceView = self.view // Replace `self.view` with the relevant view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = [] // Use .any or specify directions (optional)
        }
        present(alert, animated: true)
    }
    
    func sortActionTapped(applicationSortType: applicationSortType) {
        switch applicationSortType {
        case .oldest:
            self.filteredJobSeekerApplications = self.jobSeekerApplications.sorted(by: { $0.date.convertToDate() < $1.date.convertToDate() })
        case .newest:
            self.filteredJobSeekerApplications = self.jobSeekerApplications.sorted(by: { $0.date.convertToDate() > $1.date.convertToDate() })
        case .ascending:
            self.filteredJobSeekerApplications = self.jobSeekerApplications.sorted(by: { $0.jobName < $1.jobName })
        case .descending:
            self.filteredJobSeekerApplications = self.jobSeekerApplications.sorted(by: { $0.jobName > $1.jobName })
        }
        self.TableViewApplication.reloadData()
    }
    
    func showFilterSheet() {
        let alert = UIAlertController(title: "Filter", message: "", preferredStyle: .actionSheet)
        for index in 0..<self.applicationFilterTypes.count {
            alert.addAction(UIAlertAction(title: self.applicationFilterTypes[index].title, style: .default, handler: { _ in
                self.filterActionTapped(applicationFilterType: self.applicationFilterTypes[index])
            }))
            
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
            self.filteredJobSeekerApplications = self.jobSeekerApplications
            self.TableViewApplication.reloadData()
        }))
        // For iPad: Configure popoverPresentationController
        if let popoverController = alert.popoverPresentationController {
            // Provide source view and source rect
            popoverController.sourceView = self.view // Replace `self.view` with the relevant view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = [] // Use .any or specify directions (optional)
        }
        present(alert, animated: true)
    }
    
    func filterActionTapped(applicationFilterType: ApplicationStatus) {
        switch applicationFilterType {
        case .rejected:
            self.filteredJobSeekerApplications = self.jobSeekerApplications.filter({ $0.status == .rejected })
        case .pending:
            self.filteredJobSeekerApplications = self.jobSeekerApplications.filter({ $0.status == .pending })
        case .accepted:
            self.filteredJobSeekerApplications = self.jobSeekerApplications.filter({ $0.status == .accepted })
        }
        self.TableViewApplication.reloadData()
    }
}

extension String {
    func convertToDate () -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd,yyyy"
        if let date = formatter.date(from: self) {
            return date
        }
        formatter.dateFormat = "mm DD, yyyy"
        return formatter.date(from: self) ?? Date()
    }
}
