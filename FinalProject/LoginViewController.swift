//
//  LoginViewController.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/26/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation
import SafariServices
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    let apiStringCurrentUser = "https://api.spotify.com/v1/me"
    var authKey: String!
    var currentUser: SPTUser!
    var ref: DatabaseReference!
    var usersRef: DatabaseReference!
    
    
    @IBOutlet weak var loginButton: UIButton!
    var spotifyAuthWebView: SFSafariViewController?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        ref = Database.database().reference()
        usersRef = Database.database().reference(withPath: "users")
        
        
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let appURL = SPTAuth.defaultInstance().spotifyAppAuthenticationURL()!
        let webURL = SPTAuth.defaultInstance().spotifyWebAuthenticationURL()!
        
        // Before presenting the view controllers we are going to start watching for the notification
        NotificationCenter.default.addObserver(self, selector: #selector(receievedUrlFromSpotify(_:)), name: NSNotification.Name.Spotify.authURLOpened, object: nil)
        
        //Check to see if the user has Spotify installed
        if SPTAuth.supportsApplicationAuthentication() {
            //Open the Spotify app by opening its url
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        } else {
            //Present a web browser in the app that lets the user sign in to Spotify
            spotifyAuthWebView = SFSafariViewController(url: webURL)
            present(spotifyAuthWebView!, animated: true, completion: nil)
        }
        
    }
    
    @objc func receievedUrlFromSpotify(_ notification: Notification) {
        guard let url = notification.object as? URL else { return }
        
        // Close the web view if it exists
        spotifyAuthWebView?.dismiss(animated: true, completion: nil)
        
        
        // Remove the observer from the Notification Center
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.Spotify.authURLOpened, object: nil)
        
        SPTAuth.defaultInstance().handleAuthCallback(withTriggeredAuthURL: url) { (error, session) in
            if let error = error {
                // Pass our error onto another method which will determine how to show it
                self.displayErrorMessage(error: error)
                return
            }
            
            if let session = session {
                // The streaming login is asyncronious and will alert us if the user
                // was logged in through a delegate, so we need to implement those methods
                SPTAudioStreamingController.sharedInstance().delegate = self
                SPTAudioStreamingController.sharedInstance().login(withAccessToken: session.accessToken)
                self.authKey = session.accessToken!
                Constants.authKey = self.authKey
            }
        }
    }
    
    func displayErrorMessage(error: Error) {
        // When changing the UI, all actions must be done on the main thread,
        // since this can be called from a notification which doesn't run on
        // the main thread, we must add this code to the main thread's queue
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: "Something went wrong! Please try again." /*error.localizedDescription*/, preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alertController.addAction(okayAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func successfulLogin() {
        // When changing the UI, all actions must be done on the main thread,
        // since this can be called from a notification which doesn't run on
        // the main thread, we must add this code to the main thread's queue
        DispatchQueue.main.async {
    
            let session = URLSession(configuration: URLSessionConfiguration.default)
            var request = URLRequest(url: URL(string: self.apiStringCurrentUser)!)
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
                        
                        /*var tempUserDict = ["href": Constants.currentUser!.href, "id": Constants.currentUser!.id]
                        if let nickname = Constants.currentUser!.display_name {
                            tempUserDict["display_name"] = nickname
                        }
                        if let imgURL = Constants.currentUser!.images?[0].url {
                            tempUserDict["profile_pic_url"] = imgURL
                        }
                        print(tempUserDict)*/
                        let tempUser = FBUser(display_name: Constants.currentUser!.display_name, href: Constants.currentUser!.href, id: Constants.currentUser!.id, imgURL: Constants.currentUser!.images?[0].url)
                        self.usersRef.child(Constants.currentUser!.id).setValue(tempUser.toAnyObject())
                        
                    } catch {
                        print("Exception on Decode: \(error)")
                    }
                }
            }
            task.resume()
            
            self.performSegue(withIdentifier: "successfulLoginShow", sender: self)
        }
    }
    
    
}


// Spotify-provided functions
extension LoginViewController: SPTAudioStreamingDelegate {
    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
        self.successfulLogin()
    }
    
    func audioStreaming(_ audioStreaming: SPTAudioStreamingController!, didReceiveError error: Error!) {
        displayErrorMessage(error: error)
    }
}
