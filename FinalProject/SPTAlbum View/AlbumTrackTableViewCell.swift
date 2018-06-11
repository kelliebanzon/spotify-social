//
//  AlbumTrackTableViewCell.swift
//  FinalProject
//
//  Created by Kellie Banzon on 06/11/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import UIKit

class AlbumTrackTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
