//
//  HomeViewController.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/26/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var usersRef: DatabaseReference!
    var postsRef: DatabaseReference!
    var timelinePosts: [Post]?
    var currentFBUsers: [String: FBUser]?
    
    var constraints = [NSLayoutConstraint]()
    var authKey: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersRef = Database.database().reference(withPath: "users")
        postsRef = Database.database().reference(withPath: "posts")
        
        
        self.setRetrieveCallback()
        // Do any additional setup after loading the view.
        //displayNavBar()
        
        /*let navBarHeight = displayNavBar()
        constraints.append(NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: navBarHeight))
        NSLayoutConstraint.activate([NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: navBarHeight)])*/
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setRetrieveCallback() {
        
        DispatchQueue.global(qos: .background).async {
            self.postsRef.queryOrdered(byChild: "posts").observe(.value, with:
                { snapshot in
                    var newPosts = [Post]()
                    for item in snapshot.children {
                        let tempPost = Post(snapshot: item as! DataSnapshot)
                        newPosts.append(tempPost)
                    }
                    DispatchQueue.main.async {
                        // Update the UI to indicate the work has been completed
                        self.timelinePosts = newPosts
                    }
                    
            })
            self.usersRef.queryOrdered(byChild: "users").observe(.value, with:
                { snapshot in
                    var newUsers = [String: FBUser]()
                    for item in snapshot.children {
                        let tempUser = FBUser(snapshot: item as! DataSnapshot)
                        newUsers[tempUser.id] = tempUser
                    }
                    DispatchQueue.main.async {
                        self.currentFBUsers = newUsers
                        print(self.currentFBUsers)
                        
                        self.tableView.rowHeight = UITableViewAutomaticDimension
                        //self.tableView.estimatedRowHeight = 115
                        self.tableView.reloadData()
                    }
            })
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.timelinePosts?.count ?? 0
    }
    
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }*/
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeFeedItem", for: indexPath) as! PostTableViewCell
        let currentPost = self.timelinePosts![indexPath.row]
        let postSender = self.currentFBUsers![currentPost.senderID]
        print(postSender?.description)
        print("postSender imgURL")
        print(postSender?.imgURL)
        if let imageURL = postSender?.imgURL {
            cell.senderImageView.defaultOrDownloadedFrom(linkString: imageURL, defaultName: "defaultUserProfilePicture")
        }
        else {
            cell.senderImageView.image = UIImage(named: "defaultUserProfilePicture")
        }
        cell.senderImageView.roundCorners()
        cell.senderNameLabel.text = postSender?.display_name ?? postSender?.id
        cell.messageText.text = currentPost.content
        return cell
    }
    
    @IBAction func writePost(){
        self.textView.resignFirstResponder()
        if self.textView.hasText {
            let timestamp = (Int(NSDate().timeIntervalSince1970.rounded(.down)))
            let postToSubmit = Post(senderID: Constants.currentUser!.id, timestamp: timestamp, content: self.textView.text)
            print(timestamp)
            self.postsRef.child(String(timestamp)).setValue(postToSubmit.toAnyObject())
            self.textView.text = ""
            self.setRetrieveCallback()
            self.tableView.reloadData()
        }
    }
    
    @IBAction func cancelPost(){
        self.textView.resignFirstResponder()
    }

    
    // MARK: - Navigation

    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }*/

}
