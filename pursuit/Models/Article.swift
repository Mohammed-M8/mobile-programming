//
//  Article.swift
//  pursuit
//
//  Created by BP-36-201-06 on 02/12/2024.
//

import Foundation


class Article: Resources {
    var Content: String
    
    init(ResourceTitle: String, CompanyName: String, ExtraComment: String, Hours: Int, ResourceType: String, Industry: String, Details: String, Summary: String, Content: String) {
        
        self.Content = Content
        super.init(ResourceTitle: ResourceTitle, CompanyName: CompanyName, ExtraComment: ExtraComment, Hours: Hours, ResourceType: ResourceType, Industry: Industry, Details: Details, Summary: Summary)
    }
    
}
