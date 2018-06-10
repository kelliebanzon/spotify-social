//
//  OpenChannelChatViewController.swift
//  FinalProject
//
//  Created by Kellie Banzon on 06/09/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import UIKit
import SendBirdSDK

class OpenChannelChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SBDChannelDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentChannelURL: String!
    var currentChannel: SBDOpenChannel!
    var previousMessages: [SBDBaseMessage]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            SBDOpenChannel.getWithUrl(self.currentChannelURL) { (openChannel, error) in
                if error != nil {
                    // Error!
                    return
                }
                
                self.currentChannel = openChannel
                self.navigationItem.title = self.currentChannel.name
                openChannel?.enter(completionHandler: { (error) in
                    if error != nil {
                        NSLog("Error: %@", error!)
                        return
                    }
                })
                let previousMessageQuery = self.currentChannel.createPreviousMessageListQuery()
                previousMessageQuery?.loadPreviousMessages(withLimit: 30, reverse: true, completionHandler: { (messages, error) in
                    if error != nil {
                        NSLog("Error: %@", error!)
                        return
                    }
                    
                    self.currentChannel.getPreviousMessages(byTimestamp: Int64.max, limit: 30, reverse: false, messageType: SBDMessageTypeFilter.user, customType: "", completionHandler: { (messages, error) in
                        print(messages)
                        self.previousMessages = messages
                        self.tableView.reloadData()
                    })
                })
            }
            
            
        }

        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "SPTDarkGray")
        // fix back button name
        let backButton = UIBarButtonItem(image: UIImage(named: "btn_back"), style: UIBarButtonItemStyle.done, target: self, action: #selector(back))
        backButton.tintColor = UIColor(named: "SPTWhite")
        self.navigationItem.leftBarButtonItem = backButton
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.previousMessages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tempMessageTVCell", for: indexPath) as! TempMessageTableViewCell
        let msg = self.previousMessages![indexPath.row] as! SBDUserMessage
        cell.messageTextLabel.text = msg.message
        cell.senderNameLabel.text = msg.sender?.nickname
        if let profileURL = msg.sender?.profileUrl {
            cell.senderProfileImageView.defaultOrDownloadedFrom(linkString: profileURL, defaultName: "defaultUserProfilePicture")
        }
        else {
            cell.senderProfileImageView.image = UIImage(named: "defaultUserProfilePicture")
        }
        cell.senderProfileImageView.roundCorners()
        if msg.sender?.userId == Constants.currentUserSBD?.userId {
            cell.backgroundColor = UIColor(named: "SPTDarkGray")
        }
        
        return cell
    }
    
    // MARK: - Navigation
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
