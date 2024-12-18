//
//  NameTableViewCell.swift
//  pursuit
//
//  Created by BP-36-201-05 on 19/12/2024.
//

import UIKit

class NameTableViewCell: UITableViewCell {
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
