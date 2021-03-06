//
//  ImageViewExtension.swift
//  FinalProject
//
//  Created by Kellie Banzon on 05/25/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func roundCorners(){
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        //return self
    }
    

    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    
    func defaultOrDownloadedFrom(imageList: [SPTImage]?, defaultName: String){
        if let imgList = imageList, imgList.count > 0 {
            if ConstantFuncs().verifyUrl(urlString: imgList[0].url) == true {
                self.downloadedFrom(url: URL(string: imgList[0].url)!, contentMode: .scaleAspectFill)
            }
        }
        else{
            self.image = UIImage(named: defaultName)
        }
    }
    
    func defaultOrDownloadedFrom(linkString: String, defaultName: String){
       if ConstantFuncs().verifyUrl(urlString: linkString) {
            self.downloadedFrom(url: URL(string: linkString)!, contentMode: .scaleAspectFill)
        }
        else {
            self.image = UIImage(named: defaultName)
        }
    }
    
}
