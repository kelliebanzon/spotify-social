//
//  ProfileViewController.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/08/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    @IBOutlet weak var profileDisplayNameLabel: UILabel!
    
    let apiStringCurrentUser = "https://api.spotify.com/v1/me"
    var authKey: String!
    var currentUser: SPTUserPrivate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayNavBar()
        
        
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var request = URLRequest(url: URL(string: apiStringCurrentUser)!)
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(Constants.authKey)", forHTTPHeaderField: "Authorization")
        let task: URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in
            if error != nil {
                print(error as Any)
            }
            else if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    self.currentUser = try decoder.decode(SPTUserPrivate.self, from: data)
                    Constants.currentUser = self.currentUser
                    
                    DispatchQueue.main.async {
                        self.displayProfilePicture()
                        self.displayDisplayName()
                    }
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        task.resume()
        
        
        
    }
    
    func displayProfilePicture(){
        /*self.profilePictureImageView.layer.cornerRadius = self.profilePictureImageView.frame.size.width / 2
         self.profilePictureImageView.clipsToBounds = true*/
        print(Constants.currentUser)
        if let imgList = Constants.currentUser?.images, imgList.count > 0 {
            print("if let")
            if verifyUrl(urlString: imgList[0]?.url) == true {
                //try profilePictureImageView.downloadedFrom(url: URL(string: imgObject.url)!)
                print("attempt photo download")
                profilePictureImageView.downloadedFrom(url: URL(string: imgList[0]!.url)!, contentMode: .scaleAspectFill)
            }
        }
        else{
            profilePictureImageView.image = UIImage(named: "defaultprofilepic.png")
        }
        //profilePictureImageView.roundCorners()
    }

    
    func displayDisplayName(){
        if let displayName = Constants.currentUser!.display_name {
            profileDisplayNameLabel.text = displayName
        }
        else {
            profileDisplayNameLabel.text = Constants.currentUser!.id
        }
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
}
