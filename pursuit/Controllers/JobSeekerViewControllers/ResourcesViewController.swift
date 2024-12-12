//
//  ResourcesViewController.swift
//  pursuit
//
//  Created by BP-36-201-15 on 11/12/2024.
//

import UIKit

class ResourcesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var searchBarResources: UISearchBar!
    
    @IBOutlet weak var btnSortBy: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    
    @IBOutlet weak var resourcesCollectionView: UICollectionView!
    @IBOutlet weak var resourcesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        let nib = UINib(nibName: "ResourcesTableViewCell", bundle: nil)
        resourcesTableView.register(nib, forCellReuseIdentifier: "resourcesTableCell")
        
        resourcesTableView.dataSource=self
        resourcesTableView.delegate=self
    }
    
    func setupCollectionView(){
        let nib = UINib(nibName:"ResourcesCollectionViewCell", bundle: nil)
        resourcesCollectionView.register(nib, forCellWithReuseIdentifier:"resourcesCollectionCell")
        resourcesCollectionView.delegate=self
        resourcesCollectionView.dataSource=self
    
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resourcesTableView.dequeueReusableCell(withIdentifier: "resourcesTableCell") as! ResourcesTableViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=resourcesCollectionView.dequeueReusableCell(withReuseIdentifier: "resourcesCollectionCell" , for: indexPath) as! ResourcesCollectionViewCell
        let colors: [UIColor] = [.red, .green, .blue]
        cell.contentView.backgroundColor = colors[indexPath.row % colors.count]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)-> CGSize {
        
        return CGSize(width: resourcesCollectionView.frame.width/3, height: 100)
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
