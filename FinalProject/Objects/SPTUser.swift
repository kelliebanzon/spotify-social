//
//  SPTUserPrivate.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/26/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation

struct SPTUser: Codable {
    var display_name: String?
    var followers: SPTFollowers
    var href: String
    var id: String
    var images: [SPTImage]?
    var type: String
    
    var description: String {
        return "\(String(describing: display_name)), id: \(id), numfollowers: \(followers.total) type: \(type), href: \(href). images: \(String(describing: images))"
    }

}



