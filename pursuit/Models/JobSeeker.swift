//
//  JobSeeker.swift
//  pursuit
//
//  Created by BP-36-201-17 on 28/11/2024.
//

import Foundation

class JobSeeker : User {
    var Skills: [String];
    var ApplicationList: [JobApplication];
    var JobSeekerCv: CV;
    var pfpName: String //profile picture name
        
        // Constructor
    init(Username: String,email: String, password: String, phoneNumber: String, governorate: String, description:String, Skills: [String] = [], ApplicationList: [JobApplication] = [], JobSeekerCv: CV, pfpName: String) {
            self.Skills = Skills
            self.ApplicationList = ApplicationList
            self.JobSeekerCv = JobSeekerCv
            self.pfpName = pfpName
            super.init(Username:Username,email: email, password: password, phoneNumber: phoneNumber,governorate: governorate,description: description)
            
        }
    }

