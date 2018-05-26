//
//  ProfileViewController.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/08/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        displayNavBar()
        
        /*self.profilePictureImageView.layer.cornerRadius = self.profilePictureImageView.frame.size.width / 2
        self.profilePictureImageView.clipsToBounds = true*/
        //profilePictureImageView = profilePictureImageView
        profilePictureImageView.roundCorners()
        
        super.viewDidLoad()
    }
    

    
}
