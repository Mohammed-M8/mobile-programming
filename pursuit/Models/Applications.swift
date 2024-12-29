//
//  Applications.swift
//  pursuit
//
//  Created by BP-36-201-17 on 17/12/2024.
//

import Foundation

class EmployerProfile: Codable {
    var firstName: String?
    var lastName: String?
    var profilePicture: String?
    var bgPicture: String?
    var email: String?
    var phoneNumber: String?
    var profileDescription: String?
    var governate: String?
    var address: String?
    var companyName: String?
    var role: String?
    
    init(firstName: String?, lastName: String?, profilePicture: String?, bgPicture: String?, email: String?, phoneNumber: String?, profileDescription: String?, governate: String?, address: String?, companyName: String?, role: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.profilePicture = profilePicture
        self.bgPicture = bgPicture
        self.email = email
        self.phoneNumber = phoneNumber
        self.profileDescription = profileDescription
        self.governate = governate
        self.address = address
        self.companyName = companyName
        self.role = role
    }
    
    
}


class Applications {
    let title: String
    let description: String
    let date: String
    let image: String
    
    init(title: String, description: String, date: String, image: String) {
        self.title = title
        self.description = description
        self.date = date
        self.image = image
    }
}
