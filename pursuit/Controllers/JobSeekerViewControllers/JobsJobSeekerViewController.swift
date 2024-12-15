//
//  JobsJobSeekerViewController.swift
//  pursuit
//
//  Created by BP-36-201-17 on 08/12/2024.
//

import UIKit

class JobsJobSeekerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
   
   
    @IBOutlet weak var JobtblView: UITableView!
    @IBOutlet weak var jobCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        JobtblView.dataSource=self
        JobtblView.delegate=self
    }
    
    func setupCollectionView(){
        jobCollectionView.delegate=self
        jobCollectionView.dataSource=self
    
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = JobtblView.dequeueReusableCell(withIdentifier: "jobTblCell") as! JobTableViewCell
        cell.lblCompany.text="Batelco"
        cell.lblLocation.text="hello"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=jobCollectionView.dequeueReusableCell(withReuseIdentifier: "promotedCollectionCell" , for: indexPath) as! promotedCollectionViewCell
        let colors: [UIColor] = [.red, .green, .blue]
        cell.contentView.backgroundColor = colors[indexPath.row % colors.count]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)-> CGSize {
        
        return CGSize(width: jobCollectionView.frame.width/3.3, height: 100)
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
