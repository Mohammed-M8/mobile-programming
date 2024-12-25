//
//  SkillsTableViewCell.swift
//  pursuit
//
//  Created by BP-36-201-05 on 23/12/2024.
//

import UIKit

class SkillsTableViewCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet var skillsStackView: [UIStackView]!
    @IBOutlet var skillsField: [UITextField]!
    @IBOutlet var percentageField: [UITextField]!
    
    @IBOutlet var skillsView: [UIView]!
    @IBOutlet var percentageView: [UIView]!
    
    var removeSkillCallBack: ((Int) -> Void)?
    var addSkillCallBack: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addSkillsTapped(_ sender: Any) {
        if let addSkillCallBack {
            addSkillCallBack()
        }
    }
    
    @IBAction func removeSkillTapped(_ sender: UIButton) {
        if let removeSkillCallBack {
            removeSkillCallBack(sender.tag)
        }
    }
}
