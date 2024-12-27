//
//  Job.swift
//  pursuit
//
//  Created by BP-36-201-06 on 02/12/2024.
//

import Foundation

class Job{
    var jobTitle: String;
    var companyName: String;
    var extraComment: String;
    var Salary:Double;
    var type:String;
    var Location:String;
    var Details:String;
    var Requirements:String;
   // var JobApplicationsArray:[JobApplication];
    
    init(jobTitle: String, companyName: String, extraComment: String, Salary: Double, type: String, Location: String, Details: String, Requirements: String/*, JobApplicationsArray: [JobApplication]*/) {
        self.jobTitle = jobTitle
        self.companyName = companyName
        self.extraComment = extraComment
        self.Salary = Salary
        self.type = type
        self.Location = Location
        self.Details = Details
        self.Requirements = Requirements
      // self.JobApplicationsArray = JobApplicationsArray
    }
}
