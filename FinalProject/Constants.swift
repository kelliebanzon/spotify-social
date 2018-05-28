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
    static var currentUser: SPTUser? = nil
    //static let navBarHeight = 42
    
    static let sendBirdAppID = "D3A9F0C0-21AC-4A27-AA11-F5CC25B99710"
    
    static let defaultCurrentUserProfilePictureName = "defaultUserProfilePicture"
    static let defaultArtistProfilePictureName = "defaultArtistProfilePicture"
}

class ConstantFuncs {
    
    func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    
    
}
