//
//  Skills.swift
//  pursuit
//
//  Created by BP-36-201-05 on 23/12/2024.
//

import Foundation

class JobSeekerProfile: Codable {
    var firstName: String?
    var lastName: String?
    var profilePicture: String?
    var bgPicture: String?
    var email: String?
    var phoneNumber: String?
    var profileDescription: String?
    var governate: String?
    var skills: [JobSeekerSkills]?
    
    init(firstName: String?, lastName: String?, profilePicture: String?, bgPicture: String?, email: String?, phoneNumber: String?, profileDescription: String?, governate: String?, skills: [JobSeekerSkills]?) {
        self.firstName = firstName
        self.lastName = lastName
        self.profilePicture = profilePicture
        self.bgPicture = bgPicture
        self.email = email
        self.phoneNumber = phoneNumber
        self.profileDescription = profileDescription
        self.governate = governate
        self.skills = skills
    }
}

class JobSeekerSkills: Codable {
    var title: String
    var percentage: String
    var isRemoved: Bool
    
    init(title: String, percentage: String, isRemoved: Bool = false) {
        self.title = title
        self.percentage = percentage
        self.isRemoved = isRemoved
    }
}

