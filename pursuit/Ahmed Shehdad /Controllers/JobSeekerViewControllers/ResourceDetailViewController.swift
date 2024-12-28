//
//  ResourceDetailViewController.swift
//  pursuit
//
//  Created by BP-36-201-17 on 27/12/2024.
//

import UIKit

class ResourceDetailViewController: UIViewController {

    @IBOutlet weak var imgJobResource: UIImageView!
    
    @IBOutlet weak var lblIndustry: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    var index:Int = 0
    @IBOutlet weak var txtSummary: UITextView!
    @IBOutlet weak var txtDetails: UITextView!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var txtShort: UITextView!
    var Resource :Resources?
    override func viewDidLoad() {
        super.viewDidLoad()
        lblIndustry.text=Resource?.ResourceTitle
        lblType.text=Resource?.ResourceType
        lblTitle.text=Resource?.ResourceTitle
        txtSummary.text=Resource?.Summary
        txtDetails.text=Resource?.Details
        lblHours.text=String(Resource!.Hours)
        txtShort.text=Resource?.ExtraComment
        imgJobResource.image=Resource?.resourceImg
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnTap(_ sender: Any) {
        performSegue(withIdentifier:"DetailsSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue" {
            let detailsVC = segue.destination as? ArticlePageViewController
            
          
//             detailsVC.index = index
            detailsVC?.Resource1 = Resource
             
        }
           
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
