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
    

    /*func displayNavBar() /*-> CGFloat*/ {
        let navController = self.navigationController
        let navBar = navController?.navigationBar
        navBar?.barStyle = .blackTranslucent
        
        /*let settingsButtonImageView = UIImageView(image: UIImage(named: "settings_transparent.png"))
        settingsButtonImageView.contentMode = .scaleAspectFit
        let profileButtonImageView = UIImageView(image: UIImage(named: "profile_transparent.png"))
        profileButtonImageView.contentMode = .scaleAspectFit
        let homeButtonImageView = UIImageView(image: UIImage(named: "home_transparent.png"))
        homeButtonImageView.contentMode = .scaleAspectFit
        let chatButtonImageView = UIImageView(image: UIImage(named: "chat_transparent.png"))
        chatButtonImageView.contentMode = .scaleAspectFit
        let searchButtonImageView = UIImageView(image: UIImage(named: "search_transparent.png"))
        searchButtonImageView.contentMode = .scaleAspectFit*/
        
        //let settingsButton = UIBarButtonItem(customView: settingsButtonImageView)
        let settingsButton = UIBarButtonItem(image: UIImage(named: "settings_transparent"), style: .plain, target: self, action: #selector(segueToSettings(_:)))
        let profileButton = UIBarButtonItem(image: UIImage(named: "profile_transparent"), style: .plain, target: self, action: #selector(segueToProfile(_:)))
        let homeButton = UIBarButtonItem(image: UIImage(named: "home_transparent"), style: .plain, target: self, action: #selector(segueToHome(_:)))
        let chatButton = UIBarButtonItem(image: UIImage(named: "chat_transparent"), style: .plain, target: self, action: #selector(segueToChat(_:)))
        let searchButton  = UIBarButtonItem(image: UIImage(named: "search_transparent"), style: .plain, target: self, action: #selector(segueToSearch(_:)))
        //settingsButton.tintColor = UIColor(named: "SPTWhite")
        /*let profileButton = UIBarButtonItem(customView: profileButtonImageView)
        let homeButton = UIBarButtonItem(customView: homeButtonImageView)
        let chatButton = UIBarButtonItem(customView: chatButtonImageView)
        let searchButton = UIBarButtonItem(customView: searchButtonImageView)*/
        navigationItem.setLeftBarButtonItems([homeButton, searchButton], animated: true)
        navigationItem.setRightBarButtonItems([settingsButton, profileButton, chatButton], animated: true)
        
        //return (navBar?.frame.height)!
        
    }
    
    @objc func segueToChat(_ sender: UIBarButtonItem!){
        print("segueToChat")
        performSegue(withIdentifier: "showChatVC", sender: sender)
    }
    
    @objc func segueToHome(_ sender: UIBarButtonItem!){
        print("segueToHome")
        performSegue(withIdentifier: "showHomeVC", sender: sender)
    }
    
    @objc func segueToProfile(_ sender: UIBarButtonItem!){
        print("segueToProfile")
        performSegue(withIdentifier: "showProfileVC", sender: sender)
    }
    
    @objc func segueToSearch(_ sender: UIBarButtonItem!){
        print("segueToSearch")
        performSegue(withIdentifier: "showSearchVC", sender: sender)
    }
    
    @objc func segueToSettings(_ sender: UIBarButtonItem!){
        print("segueToSettings")
        performSegue(withIdentifier: "showSettingsVC", sender: sender)
    }*/
    
    
    
    
    
    
    
    
}
