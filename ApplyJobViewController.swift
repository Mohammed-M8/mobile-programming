//
//  ApplyJobViewController.swift
//  pursuit
//
//  Created by Ali Alqassab on 24/12/2024.
//

import UIKit

class ApplyJobViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    

    
    @IBOutlet weak var ApplyTableView: UITableView!
    
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
        
        
            let identifier: String
        
            switch indexPath.row {
            case 0:
                identifier = "fName"
            case 1:
                identifier = "lName"
            case 2:
                identifier = "age"
            case 3:
                identifier = "CurrentOC"
            case 4:
                identifier = "PreviousXP"
            case 5:
                identifier = "Qualification"
            case 6:
                identifier = "CoverLetter"
            case 7:
                identifier = "Apply"
            default:
                fatalError("Unexpected index \(indexPath.row)")
            }
            
            
        guard let cell = ApplyTableView.dequeueReusableCell(withIdentifier: identifier) else {
                fatalError("Could not dequeue a cell with identifier: \(identifier)")
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
