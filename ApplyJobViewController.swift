//
//  ApplyJobViewController.swift
//  pursuit
//
//  Created by BP-36-201-17 on 24/12/2024.
//

import UIKit

class ApplyJobViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    

    var job1:Job?
    @IBOutlet weak var ApplyTableView: UITableView!
    var first:String=""
    var last:String=""
    var age:Int=0
    var occupation:String=""
    var Experiencetext:String=""
    var qual:String=""
    var CL:String=""
    override func viewDidLoad() {
        super.viewDidLoad()
        ApplyTableView.dataSource = self
        ApplyTableView.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    //displaying cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
            
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "fName", for: indexPath) as! ValueTableViewCell
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "lName", for: indexPath) as! ValueTableViewCell
                
                return cell

            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "age", for: indexPath) as! ValueTableViewCell
                
                return cell

            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentOC", for: indexPath) as! TextViewTableViewCell
                
                return cell

            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PreviousXP", for: indexPath) as! TextViewTableViewCell
                
                return cell

            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: "Qualification", for: indexPath) as! TextViewTableViewCell
                
                return cell

            case 6:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CoverLetter", for: indexPath) as! TextViewTableViewCell
                
                return cell

            case 7:
                let cell = tableView.dequeueReusableCell(withIdentifier: "Apply", for: indexPath) as! TextViewTableViewCell
                
                return cell

            default:
                fatalError("Unexpected index \(indexPath.row)")
            }
            
}
    
    @IBAction func buttonTapped(_ sender: Any) {
        
            if let firstNameCell = ApplyTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ValueTableViewCell {
                first = firstNameCell.textField.text ?? ""
                }
                if let lastNameCell = ApplyTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? ValueTableViewCell {
                    last = lastNameCell.textField.text ?? ""
                }
                if let ageCell = ApplyTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? ValueTableViewCell {
                    age = Int(ageCell.textField.text ?? "") ?? 0
                }
                if let occupationCell = ApplyTableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? TextViewTableViewCell {
                    occupation = occupationCell.textView.text ?? ""
                }
                if let experienceCell = ApplyTableView.cellForRow(at: IndexPath(row: 4, section: 0)) as? TextViewTableViewCell {
                    Experiencetext = experienceCell.textView.text ?? ""
                }
                if let qualificationCell = ApplyTableView.cellForRow(at: IndexPath(row: 5, section: 0)) as? TextViewTableViewCell {
                    qual = qualificationCell.textView.text ?? ""
                }
                if let coverLetterCell = ApplyTableView.cellForRow(at: IndexPath(row: 6, section: 0)) as? TextViewTableViewCell {
                    CL = coverLetterCell.textView.text ?? ""
                }
                
                
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
