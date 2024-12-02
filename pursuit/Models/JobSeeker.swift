//
//  JobSeeker.swift
//  pursuit
//
//  Created by BP-36-201-17 on 28/11/2024.
//

import Foundation

class JobSeeker : User {
        var Skills: [String]
        var ApplicationList: [JobApplication]
        var JobSeekerCv: [CV]
        
        // Constructor
        override init(Firstname: String, Lastname: String, Skills: [String] = [], ApplicationList: [JobApplication] = [], JobSeekerCv: [CV] = []) {
            self.Skills = Skills
            self.ApplicationList = ApplicationList
            self.JobSeekerCv = JobSeekerCv
            
            super.init(Firstname: Firstname, Lastname: Lastname)
        }
    }

