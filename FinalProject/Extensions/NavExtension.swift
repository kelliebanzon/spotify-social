//
//  NavExtension.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/25/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    

    func displayNavBar() /*-> CGFloat*/ {
        let navController = self.navigationController
        let navBar = navController?.navigationBar
        navBar?.barStyle = .blackTranslucent
        
        let settingsButtonImageView = UIImageView(image: UIImage(named: "settings_transparent.png"))
        settingsButtonImageView.contentMode = .scaleAspectFit
        let profileButtonImageView = UIImageView(image: UIImage(named: "profile_transparent.png"))
        profileButtonImageView.contentMode = .scaleAspectFit
        let homeButtonImageView = UIImageView(image: UIImage(named: "home_transparent.png"))
        homeButtonImageView.contentMode = .scaleAspectFit
        let chatButtonImageView = UIImageView(image: UIImage(named: "chat_transparent.png"))
        chatButtonImageView.contentMode = .scaleAspectFit
        let searchButtonImageView = UIImageView(image: UIImage(named: "search_transparent.png"))
        searchButtonImageView.contentMode = .scaleAspectFit
        
        let settingsButton = UIBarButtonItem(customView: settingsButtonImageView)
        let profileButton = UIBarButtonItem(customView: profileButtonImageView)
        let homeButton = UIBarButtonItem(customView: homeButtonImageView)
        let chatButton = UIBarButtonItem(customView: chatButtonImageView)
        let searchButton = UIBarButtonItem(customView: searchButtonImageView)
        navigationItem.setLeftBarButtonItems([homeButton, searchButton], animated: true)
        navigationItem.setRightBarButtonItems([settingsButton, profileButton, chatButton], animated: true)
        
        //return (navBar?.frame.height)!
        
    }
    
    
}
