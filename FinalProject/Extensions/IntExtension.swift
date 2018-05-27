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
}
