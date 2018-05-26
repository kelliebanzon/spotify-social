//
//  ProfileTimelineTabViewController.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/25/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//
import Foundation
import XLPagerTabStrip

class ProfileTimelineTabViewControllerOld: UITableViewController, IndicatorInfoProvider {
    
    //let cellIdentifier = "postCell"
    var blackTheme = false
    var itemInfo = IndicatorInfo(title: "View")
    
    init(style: UITableViewStyle, itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(ProfileTimelineTableViewCell.self, forCellReuseIdentifier: "cellk")

        //tableView.register(UINib(nibName: "PostCell", bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false
        if blackTheme {
            tableView.backgroundColor = UIColor(red: 15/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1.0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    /*override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataProvider.sharedInstance.postsData.count
    }*/
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellk", for: indexPath) as! ProfileTimelineTableViewCell
        cell.randomLabel.text = String(12)
        
        /*if blackTheme {
            cell.backgroundColor = UIColor(red: 15/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1.0)
        }*/
        
        return cell
        
        
        /*guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PostCell,
            let data = DataProvider.sharedInstance.postsData.object(at: indexPath.row) as? NSDictionary else { return PostCell() }
        
        cell.configureWithData(data)
        if blackTheme {
            cell.changeStylToBlack()
        }
        return cell*/
        
        
    }
    
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    
    
    /*var blackTheme = false
    var itemInfo = IndicatorInfo(title: "Favorites")
    
    init(style: UITableViewStyle, itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        print("viewDidLoad(): ProfileTimelineTabViewController")
        
        super.viewDidLoad()
        if blackTheme {
            self.view.backgroundColor = UIColor(red: 15/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1.0)
        }
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        // the title for this child
        // to be used for the title of the tab (aka. ButtonBar)
        return IndicatorInfo(title: "Timeline")
    }*/
    
    
}
