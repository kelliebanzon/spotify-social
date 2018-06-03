//
//  ChatViewController.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/28/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import UIKit
import SendBirdSDK

class ChatViewController: UIViewController, SBDConnectionDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        SBDMain.connect(withUserId: Constants.currentUser!.id, completionHandler: { (user, error) in
            print("Connected to SendBird database")
            Constants.currentUserSBD = SBDMain.getCurrentUser()
            if (Constants.currentUserSBD?.profileUrl != Constants.currentUser?.images?[0].url) || (Constants.currentUserSBD?.nickname != Constants.currentUser!.display_name) {
                SBDMain.updateCurrentUserInfo(withNickname: (Constants.currentUser!.display_name ?? Constants.currentUser!.id), profileUrl: (Constants.currentUser?.images?[0].url ?? Constants.defaultCurrentUserProfilePictureName), completionHandler: { (error) in
                    print("Updated nickname and profile picture")
                })
            }
        })
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
