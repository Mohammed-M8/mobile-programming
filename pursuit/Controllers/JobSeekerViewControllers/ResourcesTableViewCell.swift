//
//  ResourcesTableViewCell.swift
//  pursuit
//
//  Created by BP-36-201-15 on 11/12/2024.
//

import UIKit

class ResourcesTableViewCell: UITableViewCell {

    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lblfeature: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgCompany: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
