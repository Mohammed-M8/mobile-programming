//
//  Employer.swift
//  pursuit
//
//  Created by BP-36-201-17 on 28/11/2024.
//

import Foundation



class Employer : User {
    //yap here
    var Role: String;
    var Address: String;
    var JobsArray:
    
    
    
    //constructor - this is what creates the object
    init(Username: String,email: String, password: String, phoneNumber: String, governorate: String, description:String,role: String,address: String){
        super.init(Username:Username,email: email, password: password, phoneNumber: phoneNumber,governorate: governorate,description: description)
    }
}
