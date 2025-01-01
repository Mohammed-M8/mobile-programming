//
//  CVModel.swift
//  pursuit
//
//  Created by Ali Alqassab on 28/12/2024.
//

import Foundation

struct CVModel: Codable {
    // Personal Info
    var firstName: String
    var lastName: String
    var cpr: String
    var age: String
    var phoneNumber: String
    var email: String
    
    // Professional Summary
    var professionalSummary: String
    
    // Work Experience
    struct WorkExperience: Codable {
        var jobTitle: String
        var company: String
        var startYear: String
        var endYear: String
        var responsibilities: String
    }
    var workExperience: WorkExperience
    
    // Educational Background
    struct Education: Codable {
        var degree: String
        var institution: String
        var graduationYear: String
        var additionalNotes: String
    }
    var education: Education
}
