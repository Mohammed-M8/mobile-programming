//
//  ViewProfileApplicantViewController.swift
//  pursuit
//
//  Created by Ali Alqassab on 26/12/2024.
//

import UIKit
import FirebaseFirestore
import Firebase

class ViewProfileApplicantViewController: UIViewController {
    var applicantData: JobApplication?
    var currentStatus: ApplicationStatus = .pending
    
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var applicantDescription: UILabel!
    @IBOutlet weak var applicantEmail: UILabel!
    @IBOutlet weak var applicantPhone: UILabel!
    @IBOutlet weak var applicantGovernate: UILabel!
    @IBOutlet weak var fName: UILabel!
    @IBOutlet weak var lName: UILabel!
    @IBOutlet weak var viewCV: UIButton!
    @IBOutlet var skillsStackView: [UIStackView]!
    @IBOutlet var skillsLbl: [UILabel]!
    @IBOutlet var percentageLbl: [UILabel]!
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    
    @IBOutlet weak var pending: UIButton!
    @IBOutlet weak var Accepted: UIButton!
    @IBOutlet weak var Rejected: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveBarButton.isEnabled = false
        
        let allButtons = [pending, Accepted, Rejected]
            allButtons.forEach { button in
                button?.layer.cornerRadius = 10
                button?.layer.masksToBounds = true
            }
        
        guard let data = applicantData else { return }
        switch data.status {
        case .accepted:
            selectButton(Accepted)
        case .rejected:
            selectButton(Rejected)
        default:
            selectButton(pending)
        }

        // Do any additional setup after loading the view.
        
        guard let data = applicantData else { return }
            
            fName.text = data.firstName
            lName.text = data.lastName
        applicantEmail.text = data.ApplicationJobSeeker.Email
        applicantPhone.text = data.ApplicationJobSeeker.JobSeekerCv.phoneNumber
        applicantGovernate.text = data.ApplicationJobSeeker.JobSeekerCv.Location
        applicantDescription.text = data.ApplicationJobSeeker.Description
        profileImg.image = UIImage(named: data.ApplicationJobSeeker.pfpName) ?? UIImage(systemName: "person.crop.circle.fill")
        
        // Make the profile image circular
            profileImg.layer.cornerRadius = 69
            profileImg.layer.masksToBounds = true
            profileImg.clipsToBounds = true
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        let docID = "dummyApplication"
        
        let db = Firestore.firestore()
        db.collection("JobApplications")
            .document(docID)
            .updateData(["status": currentStatus.rawValue]) { error in
                if let error = error {
                    print("Error updating status: \(error.localizedDescription)")
                } else {
                    print("Status updated successfully in Firestore to \(self.currentStatus.rawValue)")
                    self.performSegue(withIdentifier: "unwindToApplicantsPage", sender: self)
                }
            }
    }
    
    @IBAction func saveStatus(_ sender: UIButton) {
        let docID = "dummyApplication"
        
        let db = Firestore.firestore()
        db.collection("JobApplications")
            .document(docID)
            .updateData(["status": currentStatus.rawValue]) { error in
                if let error = error {
                    print("Error updating status: \(error.localizedDescription)")
                } else {
                    print("Status updated successfully in Firestore to \(self.currentStatus.rawValue)")
                }
            }
    }
    
    
    func selectButton(_ selectedButton: UIButton) {
        let customColor = UIColor(red: 24/255.0, green: 116/255.0, blue: 148/255.0, alpha: 1.0)
        // Reset styles for all buttons
        [pending, Accepted, Rejected].forEach { button in
            button?.backgroundColor = .systemGray5
            button?.setTitleColor(.black, for: .normal)
            button?.isSelected = false
        }

        // Apply selected styles
        selectedButton.backgroundColor = customColor
        selectedButton.setTitleColor(.white, for: .normal)
        selectedButton.isSelected = true

        
        // Update currentStatus & applicantData.status
        switch selectedButton {
        case Accepted:
            currentStatus = .accepted
            applicantData?.status = .accepted
        case Rejected:
            currentStatus = .rejected
            applicantData?.status = .rejected
        default:
            currentStatus = .pending
            applicantData?.status = .pending
        }
        
        
        saveBarButton.isEnabled = (currentStatus != .pending)
        
        // Update currentStatus based on the button tapped
//        if let application = applicantData {
//            if selectedButton == Accepted {
//                application.status = .accepted
//            } else if selectedButton == Rejected {
//                application.status = .rejected
//            } else {
//                application.status = .pending
//            }
//        }
        
        // Enable Save button only if the selected button is NOT Pending
//        saveBarButton.isEnabled = selectedButton != pending
    }
    
    @IBAction func pendingButtonTapped(_ sender: UIButton) {
        selectButton(sender)
    }

    @IBAction func acceptedButtonTapped(_ sender: UIButton) {
        selectButton(sender)
    }

    @IBAction func rejectedButtonTapped(_ sender: UIButton) {
        selectButton(sender)
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
