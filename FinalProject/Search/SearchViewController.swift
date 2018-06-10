//
//  SearchViewController.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/28/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var searchTerms: String!
    var results: SPTSearchResults?
    var resultsTracks: [SPTTrack]?
    var resultsArtists: [SPTArtist]?
    var resultsAlbums: [SPTAlbumSimple]?
    var resultsPlaylists: [SPTPlaylistSimple]?
    
    let apiSearchURL = URL(string: "https://api.spotify.com/v1/search")!


    override func viewDidLoad() {
        super.viewDidLoad()
        //displaySearchBar()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*func displaySearchBar(){
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    }*/
    
    @IBAction func clickCancel(_ sender: UIButton) {
        searchTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("didEndEditing " + String(describing: self.searchTextField))
        if let searchText = searchTextField.text?.replacingOccurrences(of: " ", with: "%20") {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let requestSearchTermsURL = URL(string: "?q=" + searchText + "*", relativeTo: self.apiSearchURL)
            print(requestSearchTermsURL as Any)
            let fullRequestSearchURL = URL(string: "?q=" + searchText + "*" + "&type=track%2Cartist%2Calbum%2Cplaylist&limit=10", relativeTo: self.apiSearchURL)
            print(fullRequestSearchURL as Any)
            var requestSearch = URLRequest(url: fullRequestSearchURL!)
            requestSearch.addValue("Bearer \(Constants.authKey)", forHTTPHeaderField: "Authorization")
            print(requestSearch)
            let taskSearch: URLSessionDataTask = session.dataTask(with: requestSearch)
            { (receivedData, response, error) -> Void in
                if error != nil {
                    print(error as Any)
                }
                else if let data = receivedData {
                    do {
                        let decoder = JSONDecoder()
                        let resultsList = try decoder.decode(SPTSearchResults.self, from: data)
                        self.results = resultsList
                        self.resultsTracks = resultsList.tracks?.items
                        self.resultsArtists = resultsList.artists?.items
                        self.resultsAlbums = resultsList.albums?.items
                        self.resultsPlaylists = resultsList.playlists?.items
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            if let numTracks = self.resultsTracks?.count, numTracks > 0{
                                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                            }
                        }
                        
                    } catch {
                        print("Exception on Decode: \(error)")
                    }
                }
            }
            taskSearch.resume()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let requestSearchTermsURL = URL(string: "?q=" + searchText + "*", relativeTo: self.apiSearchURL)
            let fullRequestSearchURL = URL(string: "?q=" + searchText + "*" + "&type=track%2Cartist%2Calbum%2Cplaylist&limit=1", relativeTo: self.apiSearchURL)
            print(fullRequestSearchURL)
            var requestSearch = URLRequest(url: fullRequestSearchURL!)
            requestSearch.addValue("Bearer \(Constants.authKey)", forHTTPHeaderField: "Authorization")
            print(requestSearch)
            let taskSearch: URLSessionDataTask = session.dataTask(with: requestSearch)
            { (receivedData, response, error) -> Void in
                if error != nil {
                    print(error as Any)
                }
                else if let data = receivedData {
                    do {
                        let decoder = JSONDecoder()
                        let resultsList = try decoder.decode(SPTSearchResults.self, from: data)
                        print(resultsList)
                        self.results = resultsList
                        self.resultsTracks = resultsList.tracks?.items
                        self.resultsArtists = resultsList.artists?.items
                        self.resultsAlbums = resultsList.albums?.items
                        self.resultsPlaylists = resultsList.playlists?.items
                        //let trackList = try decoder.decode(SPTTrackList.self, from: data)
                        //print(trackList)
                        //self.resultsTracks = trackList.items
                        /*self.currentUserTopTracks = trackList.items
                        let artistList = try decoder.decode(SPTArtistList.self, from: data)
                        self.currentUserTopArtists = artistList.items*/
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    } catch {
                        print("Exception on Decode: \(error)")
                    }
                }
            }
            taskSearch.resume()
        }
    }
    
    
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Tracks"
        case 1:
            return "Artists"
        case 2:
            return "Albums"
        case 3:
            return "Playlists"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return resultsTracks?.count ?? 0
        case 1:
            return resultsArtists?.count ?? 0
        case 2:
            return resultsAlbums?.count ?? 0
        case 3:
            return resultsPlaylists?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tempSearchResultTVCell", for: indexPath) as! TempSearchResultTableViewCell
        switch indexPath.section {
        case 0:
            cell.tempLabel.text = self.resultsTracks?[indexPath.row].name
        case 1:
            cell.tempLabel.text = self.resultsArtists?[indexPath.row].name
        case 2:
            cell.tempLabel.text = self.resultsAlbums?[indexPath.row].name
        case 3:
            cell.tempLabel.text = self.resultsPlaylists?[indexPath.row].name
        default:
            cell.tempLabel.text = "unrecognized"
        }
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
