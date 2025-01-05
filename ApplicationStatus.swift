//
//  ApplicationStatus.swift
//  pursuit
//
//  Created by Ali Alqassab on 04/01/2025.
//

import Foundation
// ApplicationStatus.swift

import UIKit

enum ApplicationStatus: String {
    case rejected = "Rejected"
    case pending = "Pending"
    case accepted = "Accepted"
    
    var title: String {
        return self.rawValue
    }
    
    var color: UIColor {
        switch self {
        case .rejected: return .red
        case .pending: return .yellow
        case .accepted: return .green
        }
    }
}
