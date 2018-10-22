//
//  ProfileFavoritesTabViewController.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/25/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import XLPagerTabStrip
import FirebaseDatabase

class ProfileFavoritesTabViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var postsRef: DatabaseReference!
    var timelinePosts: [Post]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsRef = Database.database().reference(withPath: "posts")
        
        self.postsRef.queryOrdered(byChild: "posts").observe(.value, with:
                { snapshot in
                    var newPosts = [Post]()
                    for item in snapshot.children {
                        let tempPost = Post(snapshot: item as! DataSnapshot)
                        if tempPost.senderID == Constants.currentUser!.id {
                            newPosts.append(tempPost)
                        }
                    }
                    DispatchQueue.main.async {
                        // Update the UI to indicate the work has been completed
                        self.timelinePosts = newPosts
                        self.tableView.reloadData()
                    }
                    
            })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.timelinePosts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timelineFeedItem") as! PostTableViewCell
        let currentPost = self.timelinePosts![indexPath.row]
        if (Constants.currentUser!.images?.count)! >= 1 {
            cell.senderImageView.defaultOrDownloadedFrom(linkString: (Constants.currentUser!.images?[0].url)!, defaultName: "defaultUserProfilePicture")
        }
        else {
            cell.senderImageView.image = UIImage(named: "defaultUserProfilePicture")
        }
        cell.senderImageView.roundCorners()
        let time = Date(timeIntervalSince1970: TimeInterval(currentPost.timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        cell.timestampLabel.text = dateFormatter.string(from: time)
        cell.senderNameLabel.text = Constants.currentUser?.display_name ?? Constants.currentUser?.id
        cell.messageText.text = currentPost.content
        return cell
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
        // the title for this child
        // to be used for the title of the tab (aka. ButtonBar)
        return IndicatorInfo(title: "Recent Activity")
    }
    
    
}
