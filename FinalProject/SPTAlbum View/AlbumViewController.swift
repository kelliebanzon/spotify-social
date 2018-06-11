//
//  AlbumViewController.swift
//  FinalProject
//
//  Created by Kellie Banzon on 06/11/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var albumID: String!
    var currentAlbum: SPTAlbumFull?
    var albumTracks: [SPTTrack]?
    
    let apiAlbumURL = URL(string: "https://api.spotify.com/v1/albums/")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = URLSession(configuration: .default)
        var requestAlbum = URLRequest(url: URL(string: self.albumID, relativeTo: self.apiAlbumURL)!)
        requestAlbum.addValue("Bearer \(Constants.authKey)", forHTTPHeaderField: "Authorization")
        print(requestAlbum as Any)
        let taskAlbum: URLSessionDataTask = session.dataTask(with: requestAlbum){ (receivedData, response, error) -> Void in
            if error != nil {
                print(error as Any)
            }
            else if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    let album = try decoder.decode(SPTAlbumFull.self, from: data)
                    self.currentAlbum = album
                    self.albumTracks = album.tracks.items
                    
                    DispatchQueue.main.async {
                        self.albumNameLabel.text = self.currentAlbum?.name
                        /*var artistsText = self.currentAlbum?.artists[0].name
                        if let numArtists = self.currentAlbum?.artists.count, numArtists >= 1 {
                            for i in 1...numArtists {
                                artistsText?.append(", " + (self.currentAlbum?.artists[i].name)!)
                            }
                        }*/
                        self.artistNameLabel.text = self.currentAlbum?.artists[0].name //artistsText
                        self.yearLabel.text = self.currentAlbum?.release_date
                        self.albumImageView.defaultOrDownloadedFrom(imageList: self.currentAlbum?.images, defaultName: "defaultSongPictureSquare")
                        self.tableView.reloadData()
                    }
                    
                } catch {
                    print("Exception on Decode: \(error)")
                }
                
            }
        }
        taskAlbum.resume()

        self.navBar.setBackgroundImage(UIImage(), for: .default)
        self.navBar.shadowImage = UIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumTracks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumTrackCell") as! AlbumTrackTableViewCell
        let currentTrack = self.albumTracks![indexPath.row]
        if let trackNum = currentTrack.track_number {
            cell.numLabel.text = String(trackNum)
        }
        else {
            cell.numLabel.text = ""
        }
        cell.nameLabel.text = currentTrack.name
        if let duration = currentTrack.duration_ms {
            cell.durationLabel.text = duration.minsAndSecs()
        }
        else {
            cell.durationLabel.text = ""
        }
        return cell
    }
    
    
    // MARK: - Navigation
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
