//
//  ApplicantPostTableViewCell.swift
//  pursuit
//
//  Created by Ali Alqassab on 16/12/2024.
//

import UIKit

class ApplicantPostTableViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var applicantImg: UIImageView!
    
    @IBOutlet weak var applicantName: UILabel!
    
    @IBOutlet weak var applicantJobRole: UILabel!
    
    @IBOutlet weak var applicantLocation: UILabel!
    
    @IBOutlet weak var applicantHours: UILabel!
    
    @IBOutlet weak var applicantViewBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        applicantImg.layer.cornerRadius = 35
        applicantImg.layer.masksToBounds = true
        applicantImg.clipsToBounds = true
        
        applicantViewBtn.layer.cornerRadius = 20
        applicantViewBtn.layer.masksToBounds = true
    }
    
    @IBAction func viewButtonTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("ViewButtonTapped"), object: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
