//
//  DataManager.swift
//  pursuit
//
//  Created by BP-36-201-09 on 25/12/2024.
//

import Foundation

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
    
    
    func getAllEmployers()->[User]{
        return users
    }
    
    func getAllJobs()->[Job]{
        return jobs
    }
    
    func getAllResources()->[Resources]{
        return resources
    }
    
    
}
