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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            self.getOpenChannelList()
            
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - SendBird
    
    func getOpenChannelList(){
        openChannelListQuery = SBDOpenChannel.createOpenChannelListQuery()
        self.openChannelListQuery?.loadNextPage(completionHandler: { (channels, error) in
            
            if error != nil {
                print(error as Any)
            }
            
            else{
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
        cell.chatProfilePictureImageView.defaultOrDownloadedFrom(linkString: currentChannel.coverUrl!, defaultName: "defaultChatPicture")
        //cell.chatProfilePictureImageView.setImageWith(URL(string: currentChannel.coverUrl!)!, placeholderImage: UIImage(named: "defaultChatPicture"))
        return cell
    }
    

    
    // MARK: - Navigation

    /*// In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
