//
//  Degree.swift
//  pursuit
//
//  Created by BP-36-201-06 on 02/12/2024.
//

import Foundation

class Degree{
    var DegreeName:String;
    var Institution: String;
    var YearOfGraduation:Int;
    var AdditionalNotes:String;
    
    init(DegreeName: String, Institution: String, YearOfGraduation: Int, AdditionalNotes: String) {
        self.DegreeName = DegreeName
        self.Institution = Institution
        self.YearOfGraduation = YearOfGraduation
        self.AdditionalNotes = AdditionalNotes
    }
}
