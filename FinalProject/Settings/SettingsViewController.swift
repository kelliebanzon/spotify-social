//
//  SettingsViewController.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/28/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import UIKit
import SendBirdSDK

class SettingsViewController: UIViewController, SBDConnectionDelegate {

    @IBOutlet weak var currentUserLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUserLabel.text = Constants.currentUser!.display_name ?? Constants.currentUser!.id

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    
    @IBAction func logOut(){
        
        SBDMain.disconnect {
            Constants.currentUserSBD = nil
            Constants.currentUser = nil
            Constants.authKey = ""
            self.dismiss(animated: true, completion: nil)
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
