//
//  Post.swift
//  FinalProject
//
//  Created by Kellie Banzon on 06/11/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Post: Codable {
    
    var senderID: String
    var timestamp: Int
    var content: String
    
    init(senderID: String, timestamp: Int, content: String){
        self.senderID = senderID
        self.timestamp = timestamp
        self.content = content
    }
    
    init(snapshot: DataSnapshot) {
        timestamp = Int(snapshot.key)!
        let snapvals = snapshot.value as! [String : AnyObject]
        print("snapvals: \(snapvals)")
        senderID = snapvals["senderID"] as! String
        content = snapvals["content"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "senderID" : senderID,
            "timestamp" : timestamp,
            "content" : content
        ]
    }
    
}
