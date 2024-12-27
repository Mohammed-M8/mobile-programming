//
//  GovernateTableViewCell.swift
//  pursuit
//
//  Created by BP-36-201-05 on 19/12/2024.
//

import UIKit

class GovernateTableViewCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var dropDownImg: UIImageView!
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet var dropDownImages: [UIImageView]!
    var dropDownCallBack: (() -> Void)?
    var dropDownOptionSelected: ((Int) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func dropDownTapped(_ sender: Any) {
        if let dropDownCallBack {
            dropDownCallBack()
        }
//        dropDownView.isHidden.toggle()
    }
    
    @IBAction func dropDownSelected(_ sender: UIButton) {
        if let dropDownOptionSelected {
            dropDownOptionSelected(sender.tag)
        }
    }
    
    
    
}
