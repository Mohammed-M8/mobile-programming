//
//  EditProfileEmployerViewController.swift
//  pursuit
//
//  Created by BP-36-201-05 on 12/12/2024.
//

import UIKit

class EditProfileEmployerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var PostApplicationTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "PostApplicationTableViewCell", bundle: nil)
        PostApplicationTable.register(nib, forCellReuseIdentifier: "PostApplication")
        PostApplicationTable.dataSource = self
        PostApplicationTable.delegate = self
    }
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PostApplicationTable.dequeueReusableCell(withIdentifier: "PostApplication") as! PostApplicationTableViewCell
        return cell
    }
    }

