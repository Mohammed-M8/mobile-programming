//
//  JobEntry.swift
//  pursuit
//
//  Created by BP-36-201-06 on 02/12/2024.
//

import Foundation

class JobEntry{
    var JobTitle:String;
    var Company:String;
    var StartDate:String;
    var EndDate:String;
    var Achievements:String;
    
    init(JobTitle: String, Company: String, StartDate: String, EndDate: String, Achievements: String) {
        self.JobTitle = JobTitle
        self.Company = Company
        self.StartDate = StartDate
        self.EndDate = EndDate
        self.Achievements = Achievements
    }
}
