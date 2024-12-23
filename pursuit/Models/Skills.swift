//
//  Skills.swift
//  pursuit
//
//  Created by BP-36-201-05 on 23/12/2024.
//

import Foundation

class Skills {
    var title: String
    var percentage: String
    var isRemoved: Bool
    
    init(title: String, percentage: String, isRemoved: Bool = false) {
        self.title = title
        self.percentage = percentage
        self.isRemoved = isRemoved
    }
}

