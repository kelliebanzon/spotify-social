//
//  SPTTrack.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/27/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation

struct SPTTrackListService: Codable {
    var tracks: SPTTrackList
}

struct SPTTrackListBasic: Codable {
    var tracks: [SPTTrack]
}

struct SPTTrackList: Codable {
    var items: [SPTTrack]
    var next: String?
    var total: Int?
    var limit: Int?
    var offset: Int?
    var href: String
}

struct SPTTrack: Codable {
    
    var album: SPTAlbumSimple?
    var artists: [SPTArtistSimple]
    var duration_ms: Int?
    var external_urls: [String: String]?
    var href: String
    var id: String
    var name: String
    var popularity: Int?
    var track_number: Int?
    var type: String
    
    var description: String {
        return "\(String(describing: name)), by \(artists.description), on album \(String(describing: album?.description)). id: \(id), popularity: \(String(describing: popularity)). type: \(type), href: \(href). external_urls: \(String(describing: external_urls))"
    }
    
}
