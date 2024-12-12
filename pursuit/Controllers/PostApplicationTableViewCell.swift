//
//  PostApplicationTableViewCell.swift
//  pursuit
//
//  Created by BP-36-201-05 on 12/12/2024.
//

import UIKit

class PostApplicationTableViewCell: UITableViewCell {

    @IBOutlet weak var DatePosted: UILabel!
    @IBOutlet weak var JobDescription: UILabel!
    @IBOutlet weak var JobTitle: UILabel!
    @IBOutlet weak var JobLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
