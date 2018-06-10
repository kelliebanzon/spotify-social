//
//  ProfileTimelineTableViewController.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/26/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation
import XLPagerTabStrip
import UIKit

class ProfileTimelineTableViewController: UITableViewController, IndicatorInfoProvider {
    
    let apiURLCurrentUserTop = URL(string: "https://api.spotify.com/v1/me/top/")!

    var itemInfo: IndicatorInfo!
    var blackTheme = false
    var currentUserTopArtists: [SPTArtist]?
    var currentUserTopTracks: [SPTTrack]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var requestTracks = URLRequest(url: URL(string: "tracks?time_range=short_term&limit=10", relativeTo: apiURLCurrentUserTop)!)
        requestTracks.addValue("Bearer \(Constants.authKey)", forHTTPHeaderField: "Authorization")
        let taskTracks: URLSessionDataTask = session.dataTask(with: requestTracks)
        { (receivedData, response, error) -> Void in
            if error != nil {
                print(error as Any)
            }
            else if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    let trackList = try decoder.decode(SPTTrackList.self, from: data)
                    self.currentUserTopTracks = trackList.items
                    //let artistList = try decoder.decode(SPTArtistList.self, from: data)
                    //self.currentUserTopArtists = artistList.items
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        taskTracks.resume()
        
        var requestArtists = URLRequest(url: URL(string: "artists?time_range=short_term&limit=10", relativeTo: apiURLCurrentUserTop)!)
        requestArtists.addValue("Bearer \(Constants.authKey)", forHTTPHeaderField: "Authorization")
        let taskArtists: URLSessionDataTask = session.dataTask(with: requestArtists)
        { (receivedData, response, error) -> Void in
            if error != nil {
                print(error as Any)
            }
            else if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    let artistList = try decoder.decode(SPTArtistList.self, from: data)
                    self.currentUserTopArtists = artistList.items
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
            }
        }
        taskArtists.resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    /*override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ["Recently Played Tracks", "Recently Played Artists"]
    }*/
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Top Tracks"
        case 1:
            return "Top Artists"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return (currentUserTopTracks?.count) ?? 0
        case 1:
            return (currentUserTopArtists?.count) ?? 0
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "trackDynamicTVCell") as! TrackDynamicTableViewCell
            let currentTrack = self.currentUserTopTracks![indexPath.row]
            cell.trackImageView.defaultOrDownloadedFrom(imageList: currentTrack.album.images, defaultName: "defaultSongPictureSquare")
            cell.trackImageView.roundCorners()
            cell.trackNameLabel.text = currentTrack.name
            cell.artistNameLabel.text = currentTrack.artists[0].name
            cell.albumNameLabel.text = currentTrack.album.name
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "artistDynamicTVCell") as! ArtistDynamicTableViewCell
            let currentArtist = self.currentUserTopArtists![indexPath.row]
            cell.artistImageView.defaultOrDownloadedFrom(imageList: currentArtist.images, defaultName: "defaultArtistProfilePicture")
            cell.artistNameLabel.text = currentArtist.name
            return cell
        }
    }
    
    /*override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            var cell = Bundle.main.loadNibNamed("trackTVCell", owner: self, options: nil)?.first as? TrackTableViewCell
            if (cell == nil) {
                tableView.register(UINib(nibName: "TrackTableViewCell", bundle: nil), forCellReuseIdentifier: "trackTVCell")
                cell = tableView.dequeueReusableCell(withIdentifier: "trackTVCell") as? TrackTableViewCell
            }
            let currentTrack = self.currentUserTopTracks![indexPath.row]
            cell?.trackProfileImageView.defaultOrDownloadedFrom(imageList: currentTrack.album.images, defaultName: "defaultSongPictureSquare")
            cell?.trackProfileImageView.roundCorners()
            cell?.trackNameLabel.text = currentTrack.name
            if currentTrack.artists.count == 1 {
                cell?.trackArtistLabel.text = currentTrack.artists[0].name
            }
            else if currentTrack.artists.count > 1 {
                var artists = currentTrack.artists[0].name
                for i in 1...currentTrack.artists.count {
                    artists.append(", " + currentTrack.artists[i].name)
                }
                cell?.trackArtistLabel.text = artists
            }
            cell?.trackAlbumLabel.text = currentTrack.album.name
            return cell!
        case 1:
            var cell = Bundle.main.loadNibNamed("artistTVCell", owner: self, options: nil)?.first as? ArtistTableViewCell
            if (cell == nil) {
                tableView.register(UINib(nibName: "ArtistTableViewCell", bundle: nil), forCellReuseIdentifier: "artistTVCell")
                cell = tableView.dequeueReusableCell(withIdentifier: "artistTVCell") as? ArtistTableViewCell
            }
            let currentArtist = self.currentUserTopArtists![indexPath.row]
            cell?.artistProfileImageView.defaultOrDownloadedFrom(imageList: currentArtist.images, defaultName: "defaultArtistProfilePicture")
            cell?.artistNameLabel.text = currentArtist.name
            return cell!
        default:
            let cell = Bundle.main.loadNibNamed("artistTVCell", owner: self, options: nil)?.first as! ArtistTableViewCell
            let currentArtist = self.currentUserTopArtists![indexPath.row]
            cell.artistProfileImageView.defaultOrDownloadedFrom(imageList: currentArtist.images, defaultName: "defaultArtistProfilePicture")
            cell.artistNameLabel.text = currentArtist.name
            return cell
        }
    }*/
    
    /*override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "garbage", for: indexPath) as! ProfileTimelineTableViewCell
        switch indexPath.section {
        case 0:
            let currentTrack = currentUserTopTracks![indexPath.row]
            cell.titleLabel.text = currentTrack.name
            cell.profileImageView.defaultOrDownloadedFrom(linkString: (currentTrack.album.images?[0].url)!, defaultName: "defaultSongPictureSquare")
            cell.profileImageView.roundCorners()
        case 1:
            let currentArtist = currentUserTopArtists![indexPath.row]
            cell.titleLabel.text = currentArtist.name
            cell.profileImageView.defaultOrDownloadedFrom(linkString: (currentArtist.images?[0].url)!, defaultName: "defaultArtistProfilePicture")
        default:
            cell.titleLabel.text = "unrecognized"
        }
        cell.titleLabel.textColor = UIColor(named: "SPTWhite")
        
        return cell
    }*/
    
    /* OLD OLD
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PTimelineTrackTVCell", for: indexPath) as! ProfileTimelineTrackTVCell
            let track = currentUserTopTracks![indexPath.row]
            cell.titleLabel.text = track.name
            cell.titleLabel.textColor = UIColor(named: "SPTWhite")
            cell.artistLabel.text = track.artists.description
            cell.titleLabel.textColor = UIColor(named: "SPTWhite")
            //cell.titleLabel.text = track.description
            //cell.titleLabel.textColor = .white
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PTimelineArtistTVCell", for: indexPath) as! ProfileTimelineArtistTVCell
            let artist = currentUserTopArtists![indexPath.row]
            cell.artistNameLabel.text = artist.name
            cell.artistProfilePictureImageView.defaultOrDownloadedFrom(imageList: artist.images, defaultName: Constants.defaultArtistProfilePictureName)
            //cell.titleLabel.text = artist.description
            //cell.titleLabel.textColor = .white
            return cell
        default:
            return UITableViewCell()
        }
        
    }*/
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Recent Activity")
    }
    
    
    
}
