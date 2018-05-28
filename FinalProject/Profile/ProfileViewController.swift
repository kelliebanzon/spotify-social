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
    var currentUser: SPTUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //displayNavBar()
        
        self.profilePictureImageView.defaultOrDownloadedFrom(imageList: Constants.currentUser?.images, defaultName: Constants.defaultCurrentUserProfilePictureName)
        self.displayDisplayName()
        
        
        /*let session = URLSession(configuration: URLSessionConfiguration.default)
        var request = URLRequest(url: URL(string: apiStringCurrentUser)!)
        request.addValue("Bearer \(Constants.authKey)", forHTTPHeaderField: "Authorization")
        let task: URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in
            if error != nil {
                print(error as Any)
            }
            else if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    self.currentUser = try decoder.decode(SPTUser.self, from: data)
                    Constants.currentUser = self.currentUser
                    print(Constants.currentUser as Any)
                    
                    DispatchQueue.main.async {
                        self.profilePictureImageView.defaultOrDownloadedFrom(imageList: Constants.currentUser?.images, defaultName: Constants.defaultCurrentUserProfilePictureName)
                        self.displayDisplayName()
                    }
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        task.resume()*/
        
    }
    
/* TODO: escaping closure?
    mutating func sptQuery(urlString: String, decodeDestination: Any, decodeType: Any, asyncActions: () -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var request = URLRequest(url: URL(string: urlString)!)
        request.addValue("Bearer \(Constants.authKey)", forHTTPHeaderField: "Authorization")
        let task: URLSessionDataTask = session.dataTask(with: request)
        { (receivedData, response, error) -> Void in
            if error != nil {
                print(error as Any)
            }
            else if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    decodeDestination = try decoder.decode(decodeType.self, from: data)
                    Constants.currentUser = self.currentUser
                    
                    DispatchQueue.main.async {
                        self.profilePictureImageView.defaultOrDownloadedFrom(imageList: Constants.currentUser?.images, defaultName: Constants.defaultCurrentUserProfilePictureName)
                        self.displayDisplayName()
                    }
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        task.resume()
    }*/

    
    func displayDisplayName(){
        if let displayName = Constants.currentUser!.display_name {
            profileDisplayNameLabel.text = displayName
        }
        else {
            profileDisplayNameLabel.text = Constants.currentUser!.id
        }
    }
    
    
    
}
