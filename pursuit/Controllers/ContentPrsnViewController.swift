//
//  ContentPrsnViewController.swift
//  pursuit
//
//  Created by BP-36-201-09 on 27/12/2024.
//

import UIKit

class ContentPrsnViewController: UIViewController {
    
    
    let job1 = Job(jobTitle: "Developer", companyName: "bb", extraComment: "bb", Salary: 22, type: "bb", Location: "capital", Details: "bb", Requirements: "bb" )
    let job2 = Job(jobTitle: "Networking", companyName: "bb", extraComment: "bb", Salary: 22, type: "bb", Location: "southern", Details: "bb", Requirements: "bb" )
    let job3 = Job(jobTitle: "Programmer", companyName: "bb", extraComment: "bb", Salary: 22, type: "bb", Location: "northern", Details: "bb", Requirements: "bb" )
    
    var selectedJobTitels: [String] = ["Development", "Security", "UX/UI", "Cloud", "Data", "MAnagement", "Programming", "Database", "MIS", "Networking"]
    var selectedLocations: [String] = ["Capital", "Muharraq", "Southern", "Northern"]
    
    // Jobs
    @IBAction func DevBttnClicked(_ sender: UIButton) {
        guard let jobTitle = sender.titleLabel?.text else { return }
        
        // Toggle selection
        if let index = selectedJobTitels.firstIndex(of: jobTitle) {
            selectedJobTitels.remove(at: index)
            
            sender.backgroundColor = .clear
        }
        else {
            selectedJobTitels.append(jobTitle)
            sender.backgroundColor = .blue
        }
        
        filterJobs()
    }
    
    func filterJobs() {
    }
    
    @IBAction func SecBttnClicked(_ sender: UIButton) {
    }
    
    @IBAction func UXUIBttnClicked(_ sender: UIButton) {
    }
    
    @IBAction func CloudBtnnClicked(_ sender: UIButton) {
    }
    
    
    @IBAction func DataBtnnClicked(_ sender: UIButton) {
    }
    
    
    @IBAction func ManageBtnnClicked(_ sender: UIButton) {
    }
    
    @IBAction func ProgBtnnClicked(_ sender: UIButton) {
    }
    
    @IBAction func DBBtnnClicked(_ sender: UIButton) {
    }
    
    @IBAction func MIS(_ sender: UIButton) {
    }
    
    @IBAction func NetBtnnClicked(_ sender: UIButton) {
    }
    
    @IBOutlet weak var InterestLbl: UILabel!
    
    
    // Resources
    
    @IBAction func CapitalBtnnClicked(_ sender: UIButton) {
    }
    
    @IBAction func MuharraqBtnnClicked(_ sender: UIButton) {
    }
    
    @IBAction func SouthernBtnnClicked(_ sender: UIButton) {
    }
    
    
    @IBAction func NorthernBtnnClicked(_ sender: UIButton) {
    }
    
    @IBOutlet weak var locationLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
