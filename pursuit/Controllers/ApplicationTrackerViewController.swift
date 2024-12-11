//
//  ApplicationTrackerViewController.swift
//  pursuit
//
//  Created by BP-36-201-21 on 11/12/2024.
//

import UIKit

class ApplicationTrackerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var TableViewApplication: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ApplicationTableViewCell", bundle: nil) 
        TableViewApplication.register(nib, forCellReuseIdentifier: "Application")
        TableViewApplication.dataSource = self
        TableViewApplication.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewApplication.dequeueReusableCell(withIdentifier: "Application") as! ApplicationTableViewCell
        return cell
    }
}
