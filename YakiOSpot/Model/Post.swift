//
//  Post.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 24/11/2021.
//

import Foundation

struct Post: Codable {
    let id: String?
    let user: User
    let postedDate: Date
    var comments: Int
    var likes: Int
}
