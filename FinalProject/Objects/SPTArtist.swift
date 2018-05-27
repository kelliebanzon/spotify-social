//
//  SPTArtist.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/27/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation

struct SPTArtistListService: Codable {
    //var artists: [SPTArtistList]?
    var artists: SPTArtistList
}

struct SPTArtistList: Codable {
    var items: [SPTArtist]
    var next: String?
    var total: Int
    var href: String
}


struct SPTArtist: Codable {
    
    var external_urls: [String: String]?
    var followers: SPTFollowers
    var href: String
    var id: String
    var images: [SPTImage]?
    var name: String
    var popularity: Int
    var type: String
    
    var description: String {
        return "\(String(describing: name)), id: \(id), numfollowers: \(followers.total), popularity: \(popularity). type: \(type), href: \(href). images: \(String(describing: images)), external_urls: \(String(describing: external_urls))"
    }
    
}


