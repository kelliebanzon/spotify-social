//
//  AppDelegate.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/08/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import UIKit
import SafariServices
import Firebase
import SendBirdSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupSpotify()
        FirebaseApp.configure()
        SBDMain.initWithApplicationId(Constants.sendBirdAppID)
        
        // Override point for customization after application launch.
        // set up your background color view
        let colorView = UIView()
        colorView.backgroundColor = UIColor(named: "SPTBlack")
        
        // use UITableViewCell.appearance() to configure the default appearance of all UITableViewCells
        UITableViewCell.appearance().backgroundColor = UIColor(named: "SPTBlack")
        UITableViewCell.appearance().selectedBackgroundView = colorView
        UITableView.appearance().backgroundColor = UIColor(named: "SPTBlack")
        UINavigationBar.appearance().backgroundColor = UIColor(named: "SPTDarkGray")
        
        // TODO: change keyboard to dark background
        
        return true
    }
    
    
    func setupSpotify() {
        SPTAuth.defaultInstance().clientID = Constants.clientID
        SPTAuth.defaultInstance().redirectURL = Constants.redirectURI
        SPTAuth.defaultInstance().sessionUserDefaultsKey = Constants.sessionKey
        
        //For this application we just want to stream music, so we will only request the streaming scope
        SPTAuth.defaultInstance().requestedScopes = [SPTAuthStreamingScope, SPTAuthUserFollowModifyScope, SPTAuthUserFollowReadScope, SPTAuthUserReadPrivateScope, SPTAuthUserReadTopScope, SPTAuthUserReadBirthDateScope, SPTAuthUserReadEmailScope]
        
        // Start the player
        do {
            try SPTAudioStreamingController.sharedInstance().start(withClientId: Constants.clientID)
        } catch {
            fatalError("Couldn't start Spotify SDK")
        }
    }
    
    
    //This function is called when the app is opened by a URL
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        //Check if this URL was sent from the Spotify app or website
        if SPTAuth.defaultInstance().canHandle(url) {
            
            //Send out a notification which we can listen for in our sign in view controller
            NotificationCenter.default.post(name: NSNotification.Name.Spotify.authURLOpened, object: url)
            
            return true
        }
        
        return false
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

