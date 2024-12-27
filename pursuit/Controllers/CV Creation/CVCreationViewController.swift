//
//  CVCreationViewController.swift
//  pursuit
//
//  Created by BP-36-201-09 on 10/12/2024.
//

import UIKit

class CVCreationViewController: UIViewController {
    
    @IBOutlet weak var LName: UILabel!
    @IBOutlet weak var FName: UILabel!
    
    @IBOutlet weak var ProfSumTxtView: UITextView!
    
    @IBOutlet weak var EduBckTxtView: UITextView!
    @IBOutlet weak var WorkexpTxtView: UITextView!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var PhoneNumber: UILabel!
    @IBOutlet weak var Location: UILabel!
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
