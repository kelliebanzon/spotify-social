//
//  IntExtension.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/27/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation

extension Int {
    
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value: self))!
    }
    
    func minsAndSecs() -> String {
        let mins = Float(self) / 60000
        let minsInt = Int(mins.rounded(.down))
        let secs = Float(self - (minsInt*60000)) / 1000
        let secsInt = Int(secs.rounded(.down))
        if secsInt < 10 {
            return String(minsInt) + ":0" + String(secsInt)
        }
        else {
            return String(minsInt) + ":" + String(secsInt)
        }
        
    }
}
