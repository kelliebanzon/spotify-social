//
//  ArtistCollectionViewController.swift
//  FinalProject
//
//  Created by Kellie Banzon on 06/10/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ArtistCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var artistID: String!
    var currentArtist: SPTArtist?
    var topTracks: [SPTTrack]?
    var albums: [SPTAlbumSimple]?
    
    
    let apiArtistURL = URL(string: "https://api.spotify.com/v1/artists/")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = URLSession(configuration: .default)
        var requestArtist = URLRequest(url: URL(string: self.artistID, relativeTo: self.apiArtistURL)!)
        requestArtist.addValue("Bearer \(Constants.authKey)", forHTTPHeaderField: "Authorization")
        print(requestArtist as Any)
        let taskArtist: URLSessionDataTask = session.dataTask(with: requestArtist){ (receivedData, response, error) -> Void in
            if error != nil {
                print(error as Any)
            }
            else if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    let artist = try decoder.decode(SPTArtist.self, from: data)
                    self.currentArtist = artist
                    
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
                
            }
        }
        taskArtist.resume()
        
        var requestTopTracks = URLRequest(url: URL(string: self.artistID + "/top-tracks?country=US", relativeTo: self.apiArtistURL)!)
        requestTopTracks.addValue("Bearer \(Constants.authKey)", forHTTPHeaderField: "Authorization")
        print(requestTopTracks as Any)
        let taskTopTracks: URLSessionDataTask = session.dataTask(with: requestTopTracks){ (receivedData, response, error) -> Void in
            if error != nil {
                print(error as Any)
            }
            else if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    let topTracks = try decoder.decode(SPTTrackListBasic.self, from: data)
                    self.topTracks = topTracks.tracks
                    
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
                
            }
        }
        taskTopTracks.resume()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "SPTBlack")
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        if let navHeight = self.navigationController?.navigationBar.frame.height {
            self.collectionView?.frame = CGRect(x: 0, y: navHeight, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - navHeight))
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if let trackCount = self.topTracks?.count{
                return 5
            }
            else {
                return 0
            }
        case 2:
            return self.albums?.count ?? 0
        default:
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! ArtistHeaderCollectionReusableView
            switch indexPath.section {
            case 1:
                header.titleLabel.text = "Top Tracks"
            case 2:
                header.titleLabel.text = "Albums"
            default:
                header.titleLabel.text = ""
            }
            return header
        default:
            let reView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! UICollectionReusableView
            return reView
        }
    }
    
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileInfo", for: indexPath) as! ArtistProfileCollectionViewCell
            cell.artistNameLabel.text = self.currentArtist?.name
            if let followerCount = self.currentArtist?.followers?.total.withCommas() {
                cell.followersLabel.text = String(followerCount) + " followers"
            }
            else {
                cell.followersLabel.text = ""
            }
            cell.artistProfileImageView.defaultOrDownloadedFrom(imageList: self.currentArtist?.images, defaultName: "defaultArtistProfilePicture")
            cell.artistProfileImageView.roundCorners()
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trackCell", for: indexPath) as! TopTrackCollectionViewCell
            let track = self.topTracks![indexPath.row]
            cell.albumImageView.defaultOrDownloadedFrom(imageList: track.album?.images, defaultName: "defaultSongPictureSquare")
            cell.trackNameLabel.text = track.name
            cell.yearLabel.text = track.album?.release_date
            return cell
        default:
            // TODO
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileInfo", for: indexPath) as! ArtistProfileCollectionViewCell
            cell.artistNameLabel.text = self.currentArtist?.name
            if let followerCount = self.currentArtist?.followers?.total.withCommas() {
                cell.followersLabel.text = String(followerCount) + " followers"
            }
            else {
                cell.followersLabel.text = ""
            }
            cell.artistProfileImageView.defaultOrDownloadedFrom(imageList: self.currentArtist?.images, defaultName: "defaultArtistProfilePicture")
            cell.artistProfileImageView.roundCorners()
            return cell
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    
    // MARK: - Navigation
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }

}
