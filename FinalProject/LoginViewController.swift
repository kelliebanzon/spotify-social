//
//  LoginViewController.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/26/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation
import SafariServices

class LoginViewController: UIViewController {
    
    var spotifyAuthWebView: SFSafariViewController?
    
    override func viewDidLoad(){
        super.viewDidLoad()
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
            }
        }
    }
    
    func displayErrorMessage(error: Error) {
        // When changing the UI, all actions must be done on the main thread,
        // since this can be called from a notification which doesn't run on
        // the main thread, we must add this code to the main thread's queue
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: "Something went wrong! Please try again." /*error.localizedDescription*/, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func successfulLogin() {
        // When changing the UI, all actions must be done on the main thread,
        // since this can be called from a notification which doesn't run on
        // the main thread, we must add this code to the main thread's queue
        print("successfulLogin")
        DispatchQueue.main.async {
            print("should present")
            // Present next view controller or use performSegue(withIdentifier:, sender:)
            self.performSegue(withIdentifier: "successfulLoginShow", sender: self)
            //self.present(HomeViewController(), animated: true, completion: nil)
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
