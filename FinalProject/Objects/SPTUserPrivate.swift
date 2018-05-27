//
//  SPTUserPrivate.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/26/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation

struct SPTUserPrivate: Codable {
    var display_name: String?
    //var followers: Int /*var followers: Follower*/
    var href: String
    var id: String
    var images: [Image?]
    var type: String?
    
    var description: String {
        return "\(String(describing: display_name)), id: \(id). type: \(String(describing: type)), href: \(href). images: \(images)"
    }
    
    /*private enum CodingKeys: String, CodingKey {
        case followers = "followers.total"
    }*/
}

struct Image: Codable {
    var height: Int?
    var width: Int?
    var url: String
}


