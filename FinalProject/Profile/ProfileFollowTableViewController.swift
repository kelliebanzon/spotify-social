//
//  ProfileFollowingTableViewController.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/26/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class ProfileFollowTableViewController: UITableViewController, IndicatorInfoProvider {
    
    let apiStringCurrentUserFollowing = "https://api.spotify.com/v1/me/following?type=artist"
    
    var blackTheme = false
    var itemInfo: IndicatorInfo!
    var currentUserFollowingList: [SPTArtist]?
    
    /*init(style: UITableViewStyle, itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        
        //super.init(style: style)
    }
    
    convenience init(style: UITableViewStyle, itemInfo: IndicatorInfo){
        self.init(style: style)
        self.itemInfo = itemInfo
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/

    
    override func viewDidLoad() {
        //self.tableView.register(ProfileTimelineTableViewCell.self, forCellReuseIdentifier: "PFTVCell")
        
        super.viewDidLoad()
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var request = URLRequest(url: URL(string: apiStringCurrentUserFollowing)!)
        request.addValue("Bearer \(Constants.authKey)", forHTTPHeaderField: "Authorization")
        let task: URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in
            if error != nil {
                print(error as Any)
            }
            else if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    let artistListService = try decoder.decode(SPTArtistListService.self, from: data)
                    self.currentUserFollowingList = artistListService.artists.items
                    
                    DispatchQueue.main.async {
                        print(artistListService)
                        //print(self.currentUserFollowingList.description)
                        print(self.currentUserFollowingList)
                        self.tableView.reloadData()
                    }
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(currentUserFollowingList?.count)
        return (currentUserFollowingList?.count) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PFTVCell", for: indexPath) as! ProfileFollowTableViewCell
        let artist = currentUserFollowingList![indexPath.row]
        cell.artistNameLabel.text = artist.name
        cell.artistNameLabel.textColor = UIColor(named: "SPTWhite")
        cell.artistNumFollowersLabel.text = "\(artist.followers.total.withCommas()) Followers"
        cell.artistNumFollowersLabel.textColor = UIColor(named: "SPTWhite")
        cell.artistPictureImageView.image = UIImage(named: Constants.defaultArtistProfilePictureName)
        return cell
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Following")
    }
    
}
