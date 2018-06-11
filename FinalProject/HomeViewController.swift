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
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var usersRef: DatabaseReference!
    var postsRef: DatabaseReference!
    
    var constraints = [NSLayoutConstraint]()
    var authKey: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersRef = Database.database().reference(withPath: "users")
        postsRef = Database.database().reference(withPath: "posts")
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeFeedItem", for: indexPath) as UITableViewCell
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
            self.tableView.reloadData()
        }
    }

    
    // MARK: - Navigation

    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }*/

}
