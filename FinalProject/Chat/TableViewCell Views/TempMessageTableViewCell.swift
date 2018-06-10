//
//  TempMessageTableViewCell.swift
//  FinalProject
//
//  Created by Kellie Banzon on 06/09/18.
//  Copyright © 2018 Kellie Banzon. All rights reserved.
//

import UIKit

class TempMessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var senderProfileImageView: UIImageView!
    @IBOutlet weak var senderNameLabel: UILabel!
    @IBOutlet weak var messageTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
