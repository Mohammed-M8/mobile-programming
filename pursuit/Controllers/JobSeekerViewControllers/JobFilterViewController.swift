//
//  JobFilterViewController.swift
//  pursuit
//
//  Created by BP-36-201-17 on 13/12/2024.
//

import UIKit

class JobFilterViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    

    
    
    @IBOutlet weak var sldrExperience: UISlider!
    @IBOutlet weak var btnMuharraq: UIButton!
    @IBOutlet weak var collectionViewCompany: UICollectionView!
    @IBOutlet weak var btnNortther: UIButton!
    @IBOutlet weak var btnSouthern: UIButton!
    @IBOutlet weak var btnCapital: UIButton!
    @IBOutlet weak var btnCloud: UIButton!
    @IBOutlet weak var btnWeb: UIButton!
    @IBOutlet weak var btnCyberSecurity: UIButton!
    @IBOutlet weak var btnSoftware: UIButton!
    @IBOutlet weak var btnEntry: UIButton!
    @IBOutlet weak var btnRemote: UIButton!
    @IBOutlet weak var btnAssistant: UIButton!
    @IBOutlet weak var btnManagerial: UIButton!
    @IBOutlet weak var btnNetworking: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewCompany.dataSource=self
        collectionViewCompany.delegate=self
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewCompany.dequeueReusableCell(withReuseIdentifier: "companyCell", for: indexPath) as! companyCollectionViewCell
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
