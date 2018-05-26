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
    
    var blackTheme = false
    var itemInfo: IndicatorInfo!
    
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
        self.tableView.backgroundView?.backgroundColor = UIColor.SpotifyColor.gray
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PFTVCell", for: indexPath) as! ProfileFollowTableViewCell
        cell.nameLabel.text = "some person"
        return cell
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Following")
    }
    
}
