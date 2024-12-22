//
//  ApplicationPostViewController.swift
//  pursuit
//
//  Created by Ali Alqassab on 15/12/2024.
//

import UIKit

class ApplicationPostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //Filter Buttton outlet
    @IBOutlet weak var btnFilter: UIButton!
    
    
    //sort button outlet and its menu buttons
    @IBOutlet weak var btnSort: UIButton!
    @IBOutlet var sortButtons: [UIButton]!
    
    
    //Employer Image profile
    @IBOutlet weak var imgProfile: UIImageView!
    
    //Table View Outlet
    @IBOutlet weak var ApplicantPostTableView: UITableView!
    
    //the container for the pop up menu (the sort menu)
    @IBOutlet weak var sortMenuContainer: UIStackView!
    
    //Cell Info
    
        //this array will be used to populate the table view
    var jobApplications: [JobApplication] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApplicantPostTableView.dataSource = self
        ApplicantPostTableView.delegate = self
        
        
        // First Dummy Data
        let dummyJobEntry = JobEntry(
            JobTitle:       "Junior Developer",
            Company:        "Batelco",
            StartDate:      "01/01/2024",
            EndDate:        "01/01/2025",
            Achievements:   "Developed IOS Apps"
        )

        let dummyDegree = Degree(
            DegreeName:         "Bacholar Degree",
            Institution:        "Bahrain Polytechnic",
            YearOfGraduation:   2023,
            AdditionalNotes:     "Graduated with honors"
        )

        let dummyCV = CV(
            firstName:       "James",
            lastName:        "Carter",
            CPR:             12345678,
            DOB:             "26/05/2001",
            Location:        "Muharraq",
            phoneNumber:     "35006789",
            Email:           "James@gmail.com",
            summary:         "Passionate IOS developer with a strong foundation in Swift.",
            JobEntryArray:   [dummyJobEntry],
            DegreeArray:     [dummyDegree]
        )

        let dummyJobSeeker = JobSeeker(
            Username:       "JamesCarter123",
            email:          "James@gmail.com",
            password:       "james123",
            phoneNumber:    "35006789",
            governorate:    "Muharraq",
            description:    "Looking for IOS Development positions",
            JobSeekerCv:    dummyCV,
            pfpName: "dummyApplicantImage"
        )

        let dummyJobApplication = JobApplication(
            AppJobSeeker:        dummyJobSeeker,
            firstName:           "James",
            lastName:            "Carter",
            age:                 23,
            currentOccupation:   "Junior IOS Developer",
            previousExperience:  "1 year",
            Qualifications:      "Swift, UIKit, MVVM",
            coverLEtter:         "I am excited to apply for this position because I like programming",
            dateApplied: Date()
        )


        // Second Dummy Data
        let dummyJobEntry2 = JobEntry(
            JobTitle:       "Senior iOS Developer",
            Company:        "Zain",
            StartDate:      "02/02/2023",
            EndDate:        "02/02/2024",
            Achievements:   "Led a team to build a finance app"
        )

        let dummyDegree2 = Degree(
            DegreeName:         "Master Degree",
            Institution:        "University of Bahrain",
            YearOfGraduation:   2022,
            AdditionalNotes:    "Specialized in Mobile App Development"
        )

        let dummyCV2 = CV(
            firstName:       "Sarah",
            lastName:        "Johnson",
            CPR:             87654321,
            DOB:             "15/07/1990",
            Location:        "Manama",
            phoneNumber:     "36123456",
            Email:           "Sarah@example.com",
            summary:         "Experienced iOS developer with leadership skills.",
            JobEntryArray:   [dummyJobEntry2],
            DegreeArray:     [dummyDegree2]
        )

        let dummyJobSeeker2 = JobSeeker(
            Username:       "SarahJohnson890",
            email:          "Sarah@example.com",
            password:       "sarah123",
            phoneNumber:    "36123456",
            governorate:    "Manama",
            description:    "Aiming for senior-level iOS roles",
            JobSeekerCv:    dummyCV2,
            pfpName: "sarah"
        )

        let dummyJobApplication2 = JobApplication(
            AppJobSeeker:        dummyJobSeeker2,
            firstName:           "Sarah",
            lastName:            "Johnson",
            age:                 33,
            currentOccupation:   "Senior iOS Developer",
            previousExperience:  "5 years",
            Qualifications:      "Swift, UIKit, SwiftUI, Leadership",
            coverLEtter:         "Looking forward to contributing my experience to your company.",
            dateApplied: Date()
        )


        // Third Dummy Data
        let dummyJobEntry3 = JobEntry(
            JobTitle:       "Intern iOS Developer",
            Company:        "STC",
            StartDate:      "05/05/2022",
            EndDate:        "05/05/2023",
            Achievements:   "Contributed to UI improvements"
        )

        let dummyDegree3 = Degree(
            DegreeName:         "Associate Degree",
            Institution:        "Gulf College",
            YearOfGraduation:   2021,
            AdditionalNotes:    "Focused on app design"
        )

        let dummyCV3 = CV(
            firstName:       "Ahmed",
            lastName:        "Ali",
            CPR:             44332211,
            DOB:             "10/10/1995",
            Location:        "Manama",
            phoneNumber:     "39998877",
            Email:           "Ahmed@example.com",
            summary:         "Enthusiastic about kickstarting my iOS development career.",
            JobEntryArray:   [dummyJobEntry3],
            DegreeArray:     [dummyDegree3]
        )

        let dummyJobSeeker3 = JobSeeker(
            Username:       "AhmedAli95",
            email:          "Ahmed@example.com",
            password:       "ahmed123",
            phoneNumber:    "39998877",
            governorate:    "Manama",
            description:    "Eager to learn and grow in iOS dev",
            JobSeekerCv:    dummyCV3,
            pfpName: "Ahmed"
        )

        let dummyJobApplication3 = JobApplication(
            AppJobSeeker:        dummyJobSeeker3,
            firstName:           "Ahmed",
            lastName:            "Ali",
            age:                 28,
            currentOccupation:   "Intern iOS Developer",
            previousExperience:  "1 year internship",
            Qualifications:      "Swift, UIKit",
            coverLEtter:         "I am ready to apply what I’ve learned and improve further.",
            dateApplied: Date()
        )


        jobApplications = [dummyJobApplication, dummyJobApplication2, dummyJobApplication3]
        ApplicantPostTableView.reloadData()
    }
    
    //animation for the drop sort menu
    func showSortMenu() {
        let isCurrentlyHidden = sortMenuContainer.isHidden

        if isCurrentlyHidden {
            
            sortMenuContainer.alpha = 0
            sortMenuContainer.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.sortMenuContainer.alpha = 1
            }
        } else {
            
            UIView.animate(withDuration: 0.3, animations: {
                self.sortMenuContainer.alpha = 0
            }) { _ in
                self.sortMenuContainer.isHidden = true
            }
        }
    }
    
    //happens when you click on the sort button
    @IBAction func selectSortAction(_ sender: Any) {
        showSortMenu()
    }
    
    @IBAction func sortButtonAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            // Sort by latest
            jobApplications.sort { $0.dateApplied > $1.dateApplied }
        case 1:
            // Sort by Oldest
            jobApplications.sort { $0.dateApplied < $1.dateApplied }
        case 2:
            // Sort by A-Z
            jobApplications.sort {
                $0.ApplicationJobSeeker.JobSeekerCv.firstName.lowercased() <
                $1.ApplicationJobSeeker.JobSeekerCv.firstName.lowercased()
            }
        case 3:
            // Sort by Z-A
            jobApplications.sort {
                $0.ApplicationJobSeeker.JobSeekerCv.firstName.lowercased() >
                $1.ApplicationJobSeeker.JobSeekerCv.firstName.lowercased()
            }
        default:
            break
        }

        ApplicantPostTableView.reloadData()
        showSortMenu()  // Hide the menu after sorting
    }
    
    //happens when you click on the buttons that show up
    //@IBAction func sortButtonAction(_ sender: UIButton) {
    //    showSortMenu()
    //}
    
    //Rounded Corners
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnFilter.layer.cornerRadius = 5
        btnSort.layer.cornerRadius = 5
        sortMenuContainer.layer.cornerRadius = 10
        
    }
    
    //this allows you to set the number of cells that are displayed
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    //in here we will display the prototype cell and we can specify what to include in it
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ApplicantPostTableView.dequeueReusableCell(withIdentifier: "applicantTableCell", for: indexPath) as? ApplicantPostTableViewCell else {
            return UITableViewCell()
        }
        //takes current row for the JobApplication object
        let application = jobApplications[indexPath.row]
        let seeker = application.ApplicationJobSeeker
        let cv = seeker.JobSeekerCv
        
        let fullName = "\(cv.firstName) \(cv.lastName)"
        cell.applicantName.text = fullName
        
        if let jobRole = cv.JobEntryArray.first{
            cell.applicantJobRole.text = jobRole.JobTitle
        } else {
            cell.applicantJobRole.text = "N/A"
        }
        
        cell.applicantLocation.text = cv.Location
        cell.applicantHours.text = "0h ago"
        
        if let image = UIImage(named: seeker.pfpName), seeker.pfpName != "" {
            cell.applicantImg.image = image
        } else {
            cell.applicantImg.image = UIImage(systemName: "person.crop.circle.fill")
        }
        
        return cell
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
