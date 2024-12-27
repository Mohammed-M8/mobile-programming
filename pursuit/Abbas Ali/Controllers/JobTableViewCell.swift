//
//  JobTableViewCell.swift
//  JobPost1
//
//  Created by Abbas  on 12/26/24.
//

import UIKit

class JobTableViewCell: UITableViewCell {
    static let identifier = "JobTableViewCell"
    
    var editButtonTapped: (() -> Void)?
    
    /*private let containerView: UIView = {
           let view = UIView()
           view.backgroundColor = .systemBackground
           view.layer.cornerRadius = 10
           view.layer.shadowColor = UIColor.black.cgColor
           view.layer.shadowOpacity = 0.1
           view.layer.shadowOffset = CGSize(width: 0, height: 2)
           view.layer.shadowRadius = 4
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }() */
    
    // UI Elements
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let jobTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let companyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .systemBackground
       // contentView.addSubview(containerView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(jobTitleLabel)
        contentView.addSubview(companyLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(editButton)
        
        NSLayoutConstraint.activate([
            /*containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8), */
            
            // Logo constraints
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 50),
            logoImageView.heightAnchor.constraint(equalToConstant: 50),
            
            // Job Title constraints
            jobTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            jobTitleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 12),
            jobTitleLabel.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -12),
            
            // Company Label constraints
            companyLabel.topAnchor.constraint(equalTo: jobTitleLabel.bottomAnchor, constant: 4),
            companyLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 12),
            
            // Location Label constraints
            locationLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 4),
            locationLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 12),
            
            // Time Label constraints
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Edit Button constraints
            editButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            editButton.widthAnchor.constraint(equalToConstant: 30),
            editButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        editButton.addTarget(self, action: #selector(editButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func editButtonTapped(_ sender: UIButton) {
            editButtonTapped?()
        }
    
    func configure(with job: JobData, editAction: @escaping () -> Void)  {
        jobTitleLabel.text = job.title
        companyLabel.text = job.company
        locationLabel.text = job.location
        timeLabel.text = job.timeAgo

        editButtonTapped = editAction
        
        if let imageData = UserDefaults().data(forKey: "logo_\(job.index)"),
           let image = UIImage(data: imageData) {
            logoImageView.image = image
        } else {
            logoImageView.image = UIImage(systemName: "building.2")
        }
    }
}
