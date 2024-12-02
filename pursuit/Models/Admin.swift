//
//  Admin.swift
//  pursuit
//
//  Created by BP-36-201-17 on 28/11/2024.
//

import Foundation



class Admin : User {
    //yap here
    //all variables
    
    //constructor - this is what creates the object
    override init(Username: String, email: String, password: String, phoneNumber: String, governorate: String, description: String) {
        super.init(Username:Username,email: email, password: password, phoneNumber: phoneNumber,governorate: governorate,description: description)
    }
        
    }

