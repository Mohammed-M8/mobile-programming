//
//  TextViewTableViewCell.swift
//  pursuit
//
//  Created by BP-36-201-17 on 27/12/2024.
//

import UIKit

class TextViewTableViewCell: UITableViewCell {

    @IBOutlet weak var label:UILabel!
    @IBOutlet weak var textView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
