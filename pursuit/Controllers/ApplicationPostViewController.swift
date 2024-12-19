//
//  ApplicationPostViewController.swift
//  pursuit
//
//  Created by Ali Alqassab on 15/12/2024.
//

import UIKit

class ApplicationPostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var btnFilter: UIButton!
    
    
    //sort button outlet and its menu buttons
    @IBOutlet weak var btnSort: UIButton!
    @IBOutlet var sortButtons: [UIButton]!
    
    
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var ApplicantPostTableView: UITableView!
    
    
    @IBOutlet weak var sortMenuContainer: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApplicantPostTableView.dataSource = self
        ApplicantPostTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //animation for the drop sort menu
    func showSortMenu() {
        let isCurrentlyHidden = sortMenuContainer.isHidden

        if isCurrentlyHidden {
            
            sortMenuContainer.alpha = 0
            sortMenuContainer.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.sortMenuContainer.alpha = 1
            }
        } else {
            
            UIView.animate(withDuration: 0.3, animations: {
                self.sortMenuContainer.alpha = 0
            }) { _ in
                self.sortMenuContainer.isHidden = true
            }
        }
    }
    
    
    @IBAction func selectSortAction(_ sender: Any) {
        showSortMenu()
    }
    
    @IBAction func sortButtonAction(_ sender: UIButton) {
        showSortMenu()
    }
    
    
    //Rounded Corners
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnFilter.layer.cornerRadius = 5
        btnSort.layer.cornerRadius = 5
        sortMenuContainer.layer.cornerRadius = 10
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ApplicantPostTableView.dequeueReusableCell(withIdentifier: "applicantTableCell", for: indexPath) as! ApplicantPostTableViewCell
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
