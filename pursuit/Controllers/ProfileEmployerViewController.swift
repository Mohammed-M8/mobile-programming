//
//  ProfileEmployerViewController.swift
//  pursuit
//
//  Created by BP-36-201-05 on 16/12/2024.
//

import UIKit
struct Applications {
    let title: String
    let description: String
    let date: String
    let image: String
}

class ProfileEmployerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var PostApplicationTable: UITableView!
    
    var tableData = [Applications]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableData = [Applications(title: "Software Engineer", description: "Develop and maintain software applications, focusing on enhancing user experience and functionality.", date: "posted 12 hours ago", image: ""),
                     Applications(title: "Network Engineer", description: "Optimize network performance and troubleshoot connectivity issues to ensure seamless service delivery.", date: "posted 16 hours ago", image: ""),
                     Applications(title: "Sales Executive", description: "Promote Zain’s products and services to customers and achieve sales targets.", date: "posted 1 day ago", image: ""),
                     Applications(title: "Call Centre Representative", description: "Deliver excellent customer service by addressing inquiries and resolving issues.", date: "posted 1 day ago", image: "")]
        let nib = UINib(nibName: "PostApplicationTableViewCell", bundle: nil)
        PostApplicationTable.register(nib, forCellReuseIdentifier: "PostApplication")
        PostApplicationTable.estimatedRowHeight = UITableView.automaticDimension
        PostApplicationTable.dataSource = self
        PostApplicationTable.delegate = self
    }
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostApplication") as! PostApplicationTableViewCell
        let data = tableData[indexPath.row]
        cell.JobTitle.text = data.title
        cell.JobDescription.text = data.description
        cell.DatePosted.text = data.date
        return cell
    }
}
