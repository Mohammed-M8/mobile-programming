//
//  Users.swift
//  pursuit
//
//  Created by BP-36-201-17 on 28/11/2024.
//

import Foundation

class User {
    //Superclass to generalize all the Users of the App
    //all variables
    var Email:String;
    var Password:String;
    var phoneNumber:String;
    var Governorate:String;
    var Description:String;
    
    
    //constructor - this is what creates the object
    init(email: String, password: String, phoneNumber: String, governorate: String, description:String){
        self.Email = email
        self.Password = password
        self.phoneNumber = phoneNumber
        self.Governorate=governorate
        self.Description = description
        
    }
    
}
