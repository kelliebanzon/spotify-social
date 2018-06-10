//
//  SPTPlaylist.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/28/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation

struct SPTPlaylistSimpleListService: Codable {
    var playlists: SPTPlaylistSimpleList
}


struct SPTPlaylistSimpleList: Codable {
    var items: [SPTPlaylistSimple]
    var next: String?
    var total: Int
    var href: String
}

struct SPTPlaylistSimple: Codable {
    
    var external_urls: [String: String]?
    var href: String
    var id: String
    var images: [SPTImage]?
    var name: String
    var owner: SPTUser?
    //var tracks: [SPTTrack]?
    var tracks: SPTPager?
    var type: String
    
    struct SPTPager: Codable {
        var href: String
        var total: Int
    }
}
