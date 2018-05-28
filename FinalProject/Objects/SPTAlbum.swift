//
//  SPTAlbum.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/27/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation

/*struct SPTAlbum extends SPTAlbumSimple {
    
}*/


struct SPTAlbumSimple: Codable {
    var artists: [SPTArtistSimple]
    var external_urls: [String: String]?
    var href: String
    var id: String
    var images: [SPTImage]?
    var name: String
    var release_date: String
    var release_date_precision: String
    var type: String
    
    
    var description: String {
        return "name: \(name) by \(artists), date: \(release_date), precision: \(release_date_precision). id:\(id). type: \(type), href: \(href). images: \(String(describing: images)), external_urls: \(String(describing: external_urls))"
    }
    
}
