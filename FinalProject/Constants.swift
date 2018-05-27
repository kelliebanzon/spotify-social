//
//  Constants.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/26/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation

struct Constants {
    static let clientID = "a7d2882594ee46fda239dc1b2b2f11a4"
    static let redirectURI = URL(string: "finalproject://")!
    static let sessionKey = "spotifySessionKey"
    static var authKey = ""
    static var currentUser: SPTUserPrivate? = nil
    //static let navBarHeight = 42
}
