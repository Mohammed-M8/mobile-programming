//
//  JobDetailViewController.swift
//  pursuit
//
//  Created by BP-36-201-15 on 09/12/2024.
//

import UIKit

class JobDetailViewController: UIViewController {


    @IBOutlet weak var btnApply: UIButton!
    var index:Int = 0
    @IBOutlet weak var lblSalary: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var imgJobCompany: UIImageView!
    
    @IBOutlet weak var txtShortDesc: UITextView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtRequirements: UITextView!
    @IBOutlet weak var txtDetails: UITextView!
    @IBOutlet weak var lblLocation: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let job=DataManager.Instance.getAllJobs()[index]
        lblSalary.text = String(job.Salary)
        lblType.text = job.type
        lblLocation.text = job.Location
        lblTitle.text=job.jobTitle
        txtShortDesc.text=job.extraComment
        txtRequirements.text = job.Requirements
        txtDetails.text = job.Details
        imgJobCompany.image=job.imgJob
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
