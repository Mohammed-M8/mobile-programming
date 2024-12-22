//
//  FilterApplicantCollectionViewCell.swift
//  pursuit
//
//  Created by Ali Alqassab on 22/12/2024.
//

import UIKit

class FilterApplicantCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FilterCell"
        
        let button: UIButton = {
            let btn = UIButton()
            btn.setTitleColor(.white, for: .normal)
            btn.backgroundColor = .systemBlue
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            btn.layer.cornerRadius = 15
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.addSubview(button)
            
            // Constraints for button to fill the cell with some padding
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
