//
//  ProfileTimelineTableViewController.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/26/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation
import XLPagerTabStrip
import UIKit

class ProfileTimelineTableViewController: UITableViewController, IndicatorInfoProvider {
    
    var itemInfo: IndicatorInfo!
    var blackTheme = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PTimelineTVCell", for: indexPath) as! ProfileTimelineTableViewCell
        cell.titleLabel.text = "12"
        cell.titleLabel.textColor = .white
        return cell
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Recent Activity")
    }
    
    
    
}
