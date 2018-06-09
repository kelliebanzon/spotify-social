//
//  OpenChannelTableViewCell.swift
//  FinalProject
//
//  Created by Kellie Banzon on 06/09/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import UIKit

class OpenChannelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var chatProfilePictureImageView: UIImageView!
    @IBOutlet weak var chatNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
