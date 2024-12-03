//
//  CV.swift
//  pursuit
//
//  Created by BP-36-201-06 on 02/12/2024.
//

import Foundation

// <<<<<<< HEAD
/* class CV {
    var FirstName : String
    var LastName : String
    var CPR : String
    var DateOfBirth : Date
    var Location :  String
    var PhoneNumber: String
    var Email: String
    var ProffesionalSummary: String
    var JobEntryArray: [JobEntry]
    var DegreeArray: [Degree]
    
    init(FirstName : String, LastName : String, CPR : String, DateOfBirth : Date, Location :  String, PhoneNumber: String, Email: String, ProffesionalSummary: String, JobEntryArray: [JobEntry], DegreeArray: [Degree]){
        self.FirstName = FirstName
        self.LastName = LastName
        self.CPR = CPR
        self.DateOfBirth = DateOfBirth
        self.Location = Location
        self.PhoneNumber = PhoneNumber
        self.Email = Email
        self.ProffesionalSummary = ProffesionalSummary
        self.JobEntryArray = JobEntryArray
        self.DegreeArray = DegreeArray
    } */
    
    
    
//=======
class CV{
    var firstName:String;
    var lastName:String;
    var CPR:Int;
    var DOB:String;
    var Location: String;
    var phoneNumber: String;
    var Email: String;
    var summary: String;
    var JobEntryArray:[JobEntry];
    var DegreeArray:[Degree];
    
    init(firstName: String, lastName: String, CPR: Int, DOB: String, Location: String, phoneNumber: String, Email: String, summary: String, JobEntryArray: [JobEntry], DegreeArray: [Degree]) {
        self.firstName = firstName
        self.lastName = lastName
        self.CPR = CPR
        self.DOB = DOB
        self.Location = Location
        self.phoneNumber = phoneNumber
        self.Email = Email
        self.summary = summary
        self.JobEntryArray = JobEntryArray
        self.DegreeArray = DegreeArray
    }
//>>>>>>> Mohammed
}
