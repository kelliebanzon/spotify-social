//
//  SearchAlbumTableViewCell.swift
//  FinalProject
//
//  Created by Kellie Banzon on 06/10/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import UIKit

class SearchAlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
