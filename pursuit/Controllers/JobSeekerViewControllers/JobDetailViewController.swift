//
//  JobDetailViewController.swift
//  pursuit
//
//  Created by BP-36-201-15 on 09/12/2024.
//

import UIKit

class JobDetailViewController: UIViewController {


    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var lblSalary: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var imgJobCompany: UIImageView!
    var Job :Job?
    @IBOutlet weak var txtShortDesc: UITextView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtRequirements: UITextView!
    @IBOutlet weak var txtDetails: UITextView!
    @IBOutlet weak var lblLocation: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblSalary.text = String(Job!.Salary)
        lblType.text = Job?.type
        lblLocation.text = Job?.Location
        lblTitle.text=Job?.jobTitle
        txtShortDesc.text=Job?.extraComment
        txtRequirements.text = Job?.Requirements
        txtDetails.text = Job?.Details
        imgJobCompany.image=Job?.imgJob
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
