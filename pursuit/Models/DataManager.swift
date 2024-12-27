//
//  DataManager.swift
//  pursuit
//
//  Created by BP-36-201-17 on 27/12/2024.
//

import Foundation
import UIKit

class DataManager{
    
    static let Instance=DataManager()
    
    private init(){
        }
    var users=[User]()
    var jobSeekers=[JobSeeker]()
    var employers=[Employer]()
    var jobs=[Job]()
    var resources=[Resources]()
    var SignedInUser:User?
        
    var admin:Admin?
    
    func addUser(_ userToAdd: User){
        users.append(userToAdd)
    }
    
    func addJobSeekers(_ jobSeekerToAdd: JobSeeker){
        jobSeekers.append(jobSeekerToAdd)
    }
    
    func addEmployers(_ employerToAdd: Employer){
        employers.append(employerToAdd)
    }
    
    func addJobs(_ jobToAdd: Job){
        jobs.append(jobToAdd)
    }
    
    func addResources(_ resourceToAdd: Resources){
        resources.append(resourceToAdd)
    }
    
    func getAllUsers()->[User]{
        return users
    }
    
    func getAllJobSeekers()->[JobSeeker]{
        return jobSeekers
    }
    
    
    func getAllEmployers()->[Employer]{
        return employers
    }
    
    func getAllJobs()->[Job]{
        return jobs
    }
    
    func getAllResources()->[Resources]{
        return resources
    }
    
    func addData(){
        let job1 = Job(jobTitle: "Junior Developer", companyName: "Batelco", extraComment: "oiahfoihwaifoabfw", Salary: 20.00, type: "front end", Location: "muharraq", Details: "ijahiuahduia", Requirements: "aniownfinawfo", dateCreated: Date(),imgJob: UIImage(named: "download")!)
        
        let job2 = Job(jobTitle: "Senior Developer", companyName: "Viva", extraComment: "iohafih", Salary: 30.00, type: "back end", Location: "muharraq", Details: "ijahiuahduia", Requirements: "aniownfinawfo", dateCreated: Date(),imgJob:UIImage(named: "images")!)
        
        let job3 = Job(jobTitle: "Developer", companyName: "Pursuit", extraComment: "oiahfoihwaifoabfw", Salary: 20.00, type: "front end", Location: "muharraq", Details: "ijahiuahduia", Requirements: "aniownfinawfo", dateCreated: Date(),imgJob:UIImage(named: "images")!)
        
        DataManager.Instance.addJobs(job1)
        DataManager.Instance.addJobs(job2)
        DataManager.Instance.addJobs(job3)

    }
    
    
    
}
