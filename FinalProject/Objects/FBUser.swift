//
//  FBUser.swift
//  FinalProject
//
//  Created by Kellie Banzon on 06/11/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FBUser: NSObject, Codable {
    
    var display_name: String?
    var href: String
    var id: String
    var imgURL: String?
    
    init(display_name: String?, href: String, id: String, imgURL: String?){
        self.display_name = display_name
        self.href = href
        self.id = id
        self.imgURL = imgURL
    }

    
    init(snapshot: DataSnapshot) {
        id = snapshot.key
        let snapvals = snapshot.value as! [String : AnyObject]
        print("snapvals: \(snapvals)")
        display_name = snapvals["display_name"] as? String
        href = snapvals["href"] as! String
        id = snapvals["id"] as! String
        imgURL = snapvals["profile_pic_url"] as? String
    }
    
    func toAnyObject() -> Any {
        return [
            "display_name" : display_name as Any,
            "href" : href,
            "id" : id,
            "imgURL": imgURL as Any
        ]
    }
    
}
