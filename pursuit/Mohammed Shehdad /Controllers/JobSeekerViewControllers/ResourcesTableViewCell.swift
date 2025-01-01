//
//  ResourcesTableViewCell.swift
//  pursuit
//
//  Created by BP-36-201-15 on 11/12/2024.
//

import UIKit

class ResourcesTableViewCell: UITableViewCell {

    
   
    
    @IBOutlet weak var btnView: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblFeature: UILabel!
    @IBOutlet weak var lblResources: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var imgResource: UIImageView!
    
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
