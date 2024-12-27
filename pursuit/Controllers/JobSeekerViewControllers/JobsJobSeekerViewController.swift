//
//  JobsJobSeekerViewController.swift
//  pursuit
//
//  Created by BP-36-201-17 on 08/12/2024.
//

import UIKit

class JobsJobSeekerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var sortMenuContainer: UIStackView!
    
    
    @IBOutlet weak var JobtblView: UITableView!
    @IBOutlet weak var jobCollectionView: UICollectionView!
    
    
    var currentJobs:Job?
    var jobs: [Job] = DataManager.Instance.getAllJobs()
    //VIEW DID LOOOOOOOOOOOADDDDDDDDDDDD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        JobtblView.dataSource=self
        JobtblView.delegate=self
        
        

        
        JobtblView.reloadData()
    }
    
    
    @IBAction func selectSortAction(_ sender: Any) {
        showSortMenu()
    }
    
    @IBAction func sortButtonAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            // Sort by Latest
            jobs.sort { $0.dateCreated > $1.dateCreated }
        case 1:
            // Sort by Oldest
            jobs.sort { $0.dateCreated < $1.dateCreated }
        case 2:
            // Sort by A-Z (First Name)
            jobs.sort {
                $0.jobTitle.lowercased() <
                    $1.jobTitle.lowercased()
            }
        case 3:
            // Sort by Z-A (First Name)
            jobs.sort {
                $0.jobTitle.lowercased() >
                $1.jobTitle.lowercased()
            }
        default:
            break
        }
        
        JobtblView.reloadData()
        showSortMenu()  // Hide the menu after sorting
    }
    
    
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
    
    func setupCollectionView(){
        jobCollectionView.delegate=self
        jobCollectionView.dataSource=self
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = JobtblView.dequeueReusableCell(withIdentifier: "jobTblCell") as! JobTableViewCell
        
        let job = jobs[indexPath.row]
        
        cell.lblCompany.text = job.companyName
        cell.lblLocation.text = job.Location
        cell.lblJob.text = job.jobTitle
        cell.lblTime.text = job.dateCreated.formatted(date: .numeric, time: .shortened)
        
        cell.imgJob.image=job.imgJob
        cell.buttonTap={[weak self] in
            guard self == self else {return}
            self?.currentJobs = self?.jobs[indexPath.row]
            self?.performSegue(withIdentifier:"DetailsSegue", sender: nil )}
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue"{
           let detailsVC = segue.destination as? JobDetailViewController
            
            detailsVC?.Job = currentJobs
        }
    }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return DataManager.Instance.getAllJobs().count
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

