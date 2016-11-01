//
//  TweetCell.swift
//  TwitterClient
//
//  Created by Satoru Sasozaki on 10/31/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bodyTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
