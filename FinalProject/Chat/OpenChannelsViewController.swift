//
//  OpenChannelsViewController.swift
//  FinalProject
//
//  Created by Kellie Banzon on 06/09/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import UIKit
import SendBirdSDK
import AFNetworking

class OpenChannelsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var openChannelListQuery: SBDOpenChannelListQuery?
    var openChannelList: [SBDOpenChannel] = []
    
    var channelToSegue: SBDOpenChannel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "SPTDarkGray")
        
        let backButton = UIBarButtonItem(image: UIImage(named: "btn_back"), style: UIBarButtonItemStyle.done, target: self, action: #selector(back))
        backButton.tintColor = UIColor(named: "SPTWhite")
        self.navigationItem.leftBarButtonItem = backButton

    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.refreshOpenChannelList()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - SendBird
    
    func refreshOpenChannelList(){
        openChannelListQuery = SBDOpenChannel.createOpenChannelListQuery()
        self.openChannelListQuery?.loadNextPage(completionHandler: { (channels, error) in
            
            if error != nil {
                print(error as Any)
            }
            
            else{
                self.openChannelList.removeAll()
                for channel in channels! {
                    self.openChannelList.append(channel)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return openChannelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OpenChannelTVCell", for: indexPath) as! OpenChannelTableViewCell
        let currentChannel = openChannelList[indexPath.row]
        cell.chatNameLabel.text = currentChannel.name
        var participantString = " participant"
        if currentChannel.participantCount != 1 {
            participantString.append("s")
        }
        cell.participantNumberLabel.text = String(currentChannel.participantCount) + participantString
        cell.chatProfilePictureImageView.defaultOrDownloadedFrom(linkString: currentChannel.coverUrl!, defaultName: "defaultChatPicture")
        cell.chatProfilePictureImageView.roundCorners()
        //cell.chatProfilePictureImageView.setImageWith(URL(string: currentChannel.coverUrl!)!, placeholderImage: UIImage(named: "defaultChatPicture"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.channelToSegue = openChannelList[indexPath.row]
        SBDOpenChannel.getWithUrl(self.channelToSegue.channelUrl) { (openChannel, error) in
            if error != nil {
                // Error!
                return
            }
            self.performSegue(withIdentifier: "showOpenChannelChatVC", sender: self)
            // Successfully fetched the channel.
            // Do something with openChannel.
        }
    }
    

    
    // MARK: - Navigation
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "showOpenChannelChatVC"){
            let navVC = segue.destination as? UINavigationController
            let destVC = navVC?.topViewController as? OpenChannelChatViewController
            destVC?.currentChannelURL = self.channelToSegue.channelUrl
        }
    }
    

}
