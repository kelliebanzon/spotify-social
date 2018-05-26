//
//  ImageViewExtension.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/25/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func roundCorners(){
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        //return self
    }
    
}
