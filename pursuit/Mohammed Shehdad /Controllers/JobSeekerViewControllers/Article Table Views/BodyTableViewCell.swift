//
//  BodyTableViewCell.swift
//  pursuit
//
//  Created by BP-36-201-17 on 27/12/2024.
//

import UIKit

class BodyTableViewCell: UITableViewCell {

    @IBOutlet weak var txtBody: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
