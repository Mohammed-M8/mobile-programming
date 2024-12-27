//
//  DescriptionTableViewCell.swift
//  pursuit
//
//  Created by BP-36-201-05 on 19/12/2024.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var descriptionField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
