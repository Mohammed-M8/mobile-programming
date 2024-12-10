//
//  Post.swift
//  pursuit
//
//  Created by BP-36-201-16N on 10/12/2024.
//

import Foundation
import SwiftUI

struct DateNodel: Decodable {
    let error: String
    let message: String
    let data: [PostModel]
}

struct PostModel: Decodable {
    let id: Int
    let title: String
    let post: String
}
