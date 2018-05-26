//
//  ProfileFavoritesTabViewController.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/25/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import XLPagerTabStrip

class ProfileFavoritesTabViewController: UIViewController, IndicatorInfoProvider {
    
    
    override func viewDidLoad() {
        print("viewDidLoad(): ProfileFavoritesTabViewController")
        super.viewDidLoad()
        
    }
    
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
        // the title for this child
        // to be used for the title of the tab (aka. ButtonBar)
        return IndicatorInfo(title: "Favorites")
    }
    
    
}
