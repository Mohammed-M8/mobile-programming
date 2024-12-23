//
//  ApplicationTableViewCell.swift
//  pursuit
//
//  Created by BP-36-201-21 on 11/12/2024.
//

import UIKit

class ApplicationTableViewCell: UITableViewCell {

    @IBOutlet weak var ParentView: UIView!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var DateView: UIView!
    @IBOutlet weak var JobName: UILabel!
    @IBOutlet weak var CompanyName: UILabel!
    @IBOutlet weak var CompanyImage: UIImageView!
    @IBOutlet weak var RemoveButton: UIButton!
    var callBack: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func removeTapped(_ sender: Any) {
        if let callBack = callBack {
            callBack()
        }
    }
    
}
