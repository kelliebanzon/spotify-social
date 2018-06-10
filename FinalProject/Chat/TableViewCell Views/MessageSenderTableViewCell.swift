//
//  MessageSenderTableViewCell.swift
//  FinalProject
//
//  Created by Kellie Banzon on 06/10/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import UIKit

class MessageSenderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myProfileImageView: UIImageView!
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var myMessageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
