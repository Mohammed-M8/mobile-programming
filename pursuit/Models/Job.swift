//
//  Job.swift
//  pursuit
//
//  Created by BP-36-201-06 on 02/12/2024.
//

import Foundation
import UIKit
class Job{
    
    var imgJob: UIImage?
    var jobTitle: String
    var companyName: String
    var extraComment: String
    var Salary:Double
    var type:String
    var Location:String
    var Details:String
    var Requirements:String
//    var JobApplicationsArray:[JobApplication];
    var dateCreated: Date
    var industry: String
    
    init(jobTitle: String, companyName: String, extraComment: String, Salary: Double, type: String, Location: String, Details: String, Requirements: String /*,JobApplicationsArray: [JobApplication]*/,dateCreated: Date,imgJob: UIImage, industry: String) {
        self.jobTitle = jobTitle
        self.companyName = companyName
        self.extraComment = extraComment
        self.Salary = Salary
        self.type = type
        self.Location = Location
        self.Details = Details
        self.Requirements = Requirements
//        self.JobApplicationsArray = JobApplicationsArray
        self.dateCreated = dateCreated
        self.imgJob=imgJob
        self.industry = industry
        
    }
}
