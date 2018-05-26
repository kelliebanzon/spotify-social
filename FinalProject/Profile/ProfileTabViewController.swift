//
//  ProfileTabController.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/25/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation
import XLPagerTabStrip
import UIKit


class ProfileTabViewController: ButtonBarPagerTabStripViewController {
    
    let graySpotifyColor = UIColor(red: 21/255.0, green: 21/255.0, blue: 24/255.0, alpha: 1.0)
    let darkGraySpotifyColor = UIColor(red: 19/255.0, green: 20/255.0, blue: 20/255.0, alpha: 1.0)

    override func viewDidLoad() {
        
        // change selected bar color
        settings.style.buttonBarBackgroundColor = graySpotifyColor
        settings.style.buttonBarItemBackgroundColor = graySpotifyColor
        settings.style.selectedBarBackgroundColor = UIColor(red: 33/255.0, green: 174/255.0, blue: 67/255.0, alpha: 1.0)
        settings.style.buttonBarItemFont = UIFont(name: "HelveticaNeue-Light", size:14) ?? UIFont.systemFont(ofSize: 14)
        settings.style.selectedBarHeight = 3.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        
        settings.style.buttonBarLeftContentInset = 20
        settings.style.buttonBarRightContentInset = 20
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor(red: 138/255.0, green: 138/255.0, blue: 144/255.0, alpha: 1.0)
            newCell?.label.textColor = .white
        }
        super.viewDidLoad()
    }
    
    
    /*override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let timeline = ProfileTimelineTableViewController(style: .plain, itemInfo: IndicatorInfo(title: "TIMELINE"))
        let favorites = ProfileTimelineTableViewController(style: .plain, itemInfo: IndicatorInfo(title: "FAVORITES"))
        
        /*let timeline = ProfileTimelineTableViewController(style: )
        let timeline = ProfileTimelineTableViewController(style: .plain, itemInfo: IndicatorInfo(title: "TIMELINE"))
        timeline.blackTheme = true
        
        let favorites = ProfileTimelineTableViewController(style: .plain, itemInfo: "FAVORITES")
        favorites.blackTheme = true*/
        return [timeline, favorites]
        
        
        /*let child_1 = TableChildExampleViewController(style: .plain, itemInfo: IndicatorInfo(title: "FRIENDS"))
        child_1.blackTheme = true
        let child_2 = TableChildExampleViewController(style: .plain, itemInfo: IndicatorInfo(title: "FEATURED"))
        child_2.blackTheme = true
        return [child_1, child_2]*/
    }*/
    
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let timeline = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child1")
        let favorites = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child2")
        let following = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child3")
        //let following = ProfileFollowTableViewController(style: .plain, itemInfo: IndicatorInfo(title: "Following"))
        //let followers = ProfileFollowTableViewController(style: .plain, itemInfo: IndicatorInfo(title: "Followers"))
        
        return [timeline, favorites, following/*, followers*/]
    }
    
    
}
