//
//  ArticlePageViewController.swift
//  pursuit
//
//  Created by BP-36-201-17 on 24/12/2024.
//

import UIKit

class ArticlePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var ArticalParagraph: UITableView!
    var Resource1 :Resources?

    override func viewDidLoad() {
        super.viewDidLoad()
        ArticalParagraph.dataSource = self
        ArticalParagraph.delegate = self
        // Do any additional setup after loading the view.
        
        ArticalParagraph.separatorStyle = .none
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    //displaying cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            case 0:
                // First cell type
                let cell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath) as! HeaderTableViewCell
            cell.lblHeader.text=Resource1?.ResourceTitle
                return cell

            case 1:
                // Second cell type
                let cell = tableView.dequeueReusableCell(withIdentifier: "Title", for: indexPath) as! TitleTableViewCell
            cell.lblTitle.text=Resource1?.ResourceType
                
                return cell

            case 2:
                // Third cell type
                let cell = tableView.dequeueReusableCell(withIdentifier: "Body", for: indexPath) as! BodyTableViewCell
            cell.txtBody.text=Resource1?.content

            
                return cell

            default:
                fatalError("Unexpected row \(indexPath.row)")
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
