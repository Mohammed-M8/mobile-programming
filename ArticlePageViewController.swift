//
//  ArticlePageViewController.swift
//  pursuit
//
//  Created by Ali Alqassab on 24/12/2024.
//

import UIKit

class ArticlePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var ArticalParagraph: UITableView!
    
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
        
        
            let identifier: String
        
            switch indexPath.row {
            case 0:
                identifier = "Header"
            case 1:
                identifier = "Title"
            case 2:
                identifier = "Body"
            default:
                fatalError("Unexpected index \(indexPath.row)")
            }
            
            
        guard let cell = ArticalParagraph.dequeueReusableCell(withIdentifier: identifier) else {
                fatalError("Could not dequeue a cell with identifier: \(identifier)")
            }
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
