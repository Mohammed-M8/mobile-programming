//
//  Video.swift
//  pursuit
//
//  Created by BP-36-201-06 on 02/12/2024.
//

import Foundation


class Video:Resources {
    var VideoURL: String
    
    init(ResourceTitle: String, CompanyName: String, ExtraComment: String, Hours: Int, ResourceType: String, Industry: String, Details: String, Summary: String, VideoURL: String) {
        self.VideoURL = VideoURL
        super.init(ResourceTitle: ResourceTitle, CompanyName: CompanyName, ExtraComment: ExtraComment, Hours: Hours, ResourceType: ResourceType, Industry: Industry, Details: Details, Summary: Summary)
    }
}
