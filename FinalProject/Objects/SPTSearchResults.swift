//
//  SPTSearchResults.swift
//  FinalProject
//
//  Created by Kellie Banzon on 06/09/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation

struct SPTSearchResults: Codable {
    var tracks: SPTTrackList?
    var artists: SPTArtistList?
    var albums: SPTAlbumList?
    var playlists: SPTPlaylistSimpleList?
}
