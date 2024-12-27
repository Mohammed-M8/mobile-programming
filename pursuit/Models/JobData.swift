//
//  JobData.swift
//  JobPost1
//
//  Created by Abbas  on 12/26/24.
//

import Foundation

struct JobData {
    let index: Int
    let title: String
    let company: String
    let location: String
    let createdDate: Date
    
    var timeAgo: String {
        // Calculate time difference
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.minute, .hour, .day], from: createdDate, to: now)
        
        if let days = components.day, days > 0 {
            return "\(days)d ago"
        } else if let hours = components.hour, hours > 0 {
            return "\(hours)h ago"
        } else if let minutes = components.minute {
            return "\(minutes)m ago"
        }
        return "Just now"
    }
}
