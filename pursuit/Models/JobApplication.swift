//
//  JobApplication.swift
//  pursuit
//
//  Created by BP-36-201-06 on 02/12/2024.
//

import Foundation

class JobApplication
{
 var ApplicationJobSeeker:JobSeeker;
    var firstName: String;
    var lastName:String;
    var age:Int;
    var currentOccupation:String;
    var previousExperience:String;
    var Qualifications: String;
    var coverLetter: String;
    
    
    init(AppJobSeeker: JobSeeker, firstName: String,lastName:String,age:Int, currentOccupation:String, previousExperience:String, Qualifications: String, coverLEtter: String){
        self.ApplicationJobSeeker = AppJobSeeker;
        self.firstName=firstName;
        self.lastName=lastName;
        self.age=age;
        self.currentOccupation=currentOccupation;
        self.previousExperience=previousExperience;
        self.Qualifications=Qualifications;
        self.coverLetter=coverLEtter;
    }
}
