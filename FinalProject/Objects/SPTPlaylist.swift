//
//  SPTPlaylist.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/28/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation

struct SPTPlaylistSimple {
    
    var external_urls: [String: String]?
    var href: String
    var id: String
    var images: [SPTImage]?
    var name: String
    var owner: SPTUser?
    var tracks: [SPTTrack]?
    var type: String
    
}
