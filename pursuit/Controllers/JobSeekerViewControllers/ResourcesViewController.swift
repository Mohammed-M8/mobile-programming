//
//  ResourcesViewController.swift
//  pursuit
//
//  Created by BP-36-201-15 on 11/12/2024.
//

import UIKit

class ResourcesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var sortMenuContainer: UIStackView!
    
 
    @IBOutlet weak var resourcesTableView: UITableView!
    @IBOutlet weak var resourcesCollectionView: UICollectionView!
    
    var resources: [Resources] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        resourcesTableView.dataSource=self
        resourcesTableView.delegate=self
        
        let resource1 = Resources(ResourceTitle: "Xcode For Noobs lol", CompanyName: "Xcode", ExtraComment: "you will learn here", Hours: 20, ResourceType: "Easy", Industry: "Software", Details: "aknfioanfpanfaofnapofnapofnaopf", Summary: "ianfioabwfi;bafobwfbafiobiwbfiawbf", dateCreated: Date())
        
        let resource2 = Resources(ResourceTitle: "Learn Java", CompanyName: "Java", ExtraComment: "you will learn here", Hours: 10, ResourceType: "Easy", Industry: "Software", Details: "aknfioanfpanfaofnapofnapofnaopf", Summary: "ianfioabwfi;bafobwfbafiobiwbfiawbf", dateCreated: Date())
        
        let resource3 = Resources(ResourceTitle: "Learn CSS", CompanyName: "Microsoft", ExtraComment: "you will learn here", Hours: 10, ResourceType: "Easy", Industry: "Software", Details: "aknfioanfpanfaofnapofnapofnaopf", Summary: "ianfioabwfi;bafobwfbafiobiwbfiawbf", dateCreated: Date())
        
        resources = [resource1, resource2, resource3]
        resourcesTableView.reloadData()
    }
    
    @IBAction func selectSortAction(_ sender: Any) {
        showSortMenu()
    }
    
    @IBAction func sortButtonAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            // Sort by Latest
            resources.sort { $0.dateCreated > $1.dateCreated }
        case 1:
            // Sort by Oldest
            resources.sort { $0.dateCreated < $1.dateCreated }
        case 2:
            // Sort by A-Z (First Name)
            resources.sort {
                $0.ResourceTitle.lowercased() <
                $1.ResourceTitle.lowercased()
            }
        case 3:
            // Sort by Z-A (First Name)
            resources.sort {
                $0.ResourceTitle.lowercased() >
                $1.ResourceTitle.lowercased()
            }
        default:
            break
        }

        resourcesTableView.reloadData()
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
        resourcesCollectionView.delegate=self
        resourcesCollectionView.dataSource=self
        
        
    
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resourcesTableView.dequeueReusableCell(withIdentifier: "resourcesTableCell") as! ResourcesTableViewCell
        
        let resource = resources[indexPath.row]
        
        cell.lblResources.text = resource.ResourceTitle
        cell.lblCompany.text = resource.CompanyName
        cell.lblFeature.text = resource.ResourceType
        cell.lblTime.text = resource.dateCreated.formatted(date: .numeric, time: .shortened)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=resourcesCollectionView.dequeueReusableCell(withReuseIdentifier: "resourcesCollectionCell" , for: indexPath) as! ResourcesCollectionViewCell
        let colors: [UIColor] = [.red, .green, .blue]
        cell.contentView.backgroundColor = colors[indexPath.row % colors.count]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)-> CGSize {
        
        return CGSize(width: resourcesCollectionView.frame.width/3.3, height: 100)
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
