//
//  JobTableViewCell.swift
//  pursuit
//
//  Created by BP-36-201-15 on 11/12/2024.
//

import UIKit

class JobsTableViewCell: UITableViewCell {

    
 
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var lblJob: UILabel!
    @IBOutlet weak var imgJob: UIImageView!
    
    var buttonTap: (()-> Void)?
    
    @IBAction func btnA(_ sender:UIButton) {
buttonTap?()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
