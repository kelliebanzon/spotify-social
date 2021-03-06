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

    override func viewDidLoad() {
        
        // change selected bar color
        settings.style.buttonBarBackgroundColor = UIColor(named: "SPTDarkGray")
        settings.style.buttonBarItemBackgroundColor = UIColor(named: "SPTDarkGray")
        settings.style.selectedBarBackgroundColor = UIColor(red: 33/255.0, green: 174/255.0, blue: 67/255.0, alpha: 1.0)
        settings.style.buttonBarItemFont = UIFont(name: "Circular Std-Bold", size:14) ?? UIFont.systemFont(ofSize: 14)
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
        let timeline = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child2")
        let favorites = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child1")
        let following = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child3")
        
        return [timeline, favorites, following]
    }
    
    
}
