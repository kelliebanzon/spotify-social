//
//  SPTArtistViewController.swift
//  FinalProject
//
//  Created by Kellie Banzon on 06/10/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import UIKit

class SPTArtistViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var artistProfileImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
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
                        self.artistNameLabel.text = self.currentArtist?.name
                        if let followerCount = self.currentArtist?.followers?.total.withCommas() {
                            self.followersLabel.text = String(followerCount) + " followers"
                        }
                        else {
                            self.followersLabel.text = ""
                        }
                        self.artistProfileImageView.defaultOrDownloadedFrom(imageList: self.currentArtist?.images, defaultName: "defaultArtistProfilePicture")
                        self.artistProfileImageView.roundCorners()
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
                        self.collectionView.reloadData()
                    }
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
                
            }
        }
        taskTopTracks.resume()
        
        var requestAlbums = URLRequest(url: URL(string: self.artistID + "/albums", relativeTo: self.apiArtistURL)!)
        requestAlbums.addValue("Bearer \(Constants.authKey)", forHTTPHeaderField: "Authorization")
        print(requestAlbums as Any)
        let taskAlbums: URLSessionDataTask = session.dataTask(with: requestAlbums){ (receivedData, response, error) -> Void in
            if error != nil {
                print(error as Any)
            }
            else if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    let albums = try decoder.decode(SPTAlbumList.self, from: data)
                    self.albums = albums.items
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
                
            }
        }
        taskAlbums.resume()
        
        
        self.navBar.setBackgroundImage(UIImage(), for: .default)
        self.navBar.shadowImage = UIImage()
    }
    
    
    // MARK: - Collection View
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! ArtistHeaderCollectionReusableView
            switch indexPath.section {
            case 0:
                header.titleLabel.text = "Top Tracks"
            case 1:
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width, height: 50)
        case 1:
            return CGSize(width: (UIScreen.main.bounds.width/2)-10, height: 200)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 {
            let totalCellWidth = Int((UIScreen.main.bounds.width/2)-10) * collectionView.numberOfItems(inSection: 1)
            let totalSpacingWidth = 10 * (collectionView.numberOfItems(inSection: 1) - 1)
            
            let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
            let rightInset = leftInset
            
            return UIEdgeInsetsMake(0, leftInset, 0, rightInset)
        }
        else{
            return UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }*/
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trackCell", for: indexPath) as! TopTrackCollectionViewCell
            let track = self.topTracks![indexPath.row]
            cell.albumImageView.defaultOrDownloadedFrom(imageList: track.album.images, defaultName: "defaultSongPictureSquare")
            cell.trackNameLabel.text = track.name
            cell.yearLabel.text = track.album.release_date
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! AlbumCollectionViewCell
            let album = self.albums![indexPath.row]
            cell.albumImageView.defaultOrDownloadedFrom(imageList: album.images, defaultName: "defaultSongPictureSquare")
            cell.albumNameLabel.text = album.name
            cell.albumYearLabel.text = album.release_date
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trackCell", for: indexPath) as! UICollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            if let trackCount = self.topTracks?.count {
                return min(trackCount, 5)
            }
            else {
                return 0
            }
        case 1:
            return self.albums?.count ?? 0
        default:
            return 0
        }
    }
    
    /*func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Top Tracks"
        case 1:
            return "Albums"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.topTracks?.count ?? 0
        case 1:
            return self.albums?.count ?? 0
        default:
            return 0
        }
    }*/
    

    
    // MARK: - Navigation
     
     @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
     }
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
