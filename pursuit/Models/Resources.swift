//
//  Resources.swift
//  pursuit
//
//  Created by BP-36-201-06 on 02/12/2024.
//

import Foundation


class Resources{
    var ResourceTitle:String;
    var CompanyName:String;
    var ExtraComment:String;
    var Hours:Int;
    var ResourceType:String;
    var Industry:String;
    var Details:String;
    var Summary:String;
    var dateCreated: Date
    
    
    init(ResourceTitle: String, CompanyName: String, ExtraComment: String, Hours: Int, ResourceType: String, Industry: String, Details: String, Summary: String, dateCreated: Date) {
        self.ResourceTitle = ResourceTitle
        self.CompanyName = CompanyName
        self.ExtraComment = ExtraComment
        self.Hours = Hours
        self.ResourceType = ResourceType
        self.Industry = Industry
        self.Details = Details
        self.Summary = Summary
        self.dateCreated = dateCreated
    }
}
