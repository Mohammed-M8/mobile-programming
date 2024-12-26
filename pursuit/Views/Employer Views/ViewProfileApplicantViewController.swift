//
//  ViewProfileApplicantViewController.swift
//  pursuit
//
//  Created by Ali Alqassab on 26/12/2024.
//

import UIKit

class ViewProfileApplicantViewController: UIViewController {
    
    
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
    
    
    @IBOutlet weak var pending: UIButton!
    @IBOutlet weak var Accepted: UIButton!
    @IBOutlet weak var Rejected: UIButton!
    
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
