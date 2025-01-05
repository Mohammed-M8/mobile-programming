//
//  JobSeekerApplication.swift
//  pursuit
//
//  Created by BP-36-201-05 on 24/12/2024.
//

import Foundation
import UIKit

//enum ApplicationStatus {
//    case rejected
//    case pending
//    case accepted
//    
//    var title: String {
//        switch self {
//        case .rejected: return "Rejected"
//        case .pending: return "Pending"
//        case .accepted: return "Accepted"
//        }
//    }
//    
//    var color: UIColor {
//        switch self {
//        case .rejected: return .red
//        case .pending: return .yellow
//        case .accepted: return .green
//        }
//    }
//}
class JobSeekerApplication {
    let companyName: String
    let jobName: String
    let date: String
    let image: String
    let status: ApplicationStatus
    let documentId: String
    
    init(companyName: String, jobName: String, date: String, image: String, status: ApplicationStatus, documentId: String) {
        self.companyName = companyName
        self.jobName = jobName
        self.date = date
        self.image = image
        self.status = status
        self.documentId = documentId
    }
}
