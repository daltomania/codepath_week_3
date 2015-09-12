//
//  TweetCell.swift
//  butter
//
//  Created by Will Dalton on 9/11/15.
//  Copyright (c) 2015 daltomania. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = 3
        avatarImageView.clipsToBounds = true
    }
    
    var tweet: Tweet! {
        didSet {
            nameLabel.text = tweet.user?.name
            usernameLabel.text = "@\(tweet.user!.screenname!)"
            tweetLabel.text = tweet.text
            avatarImageView.setImageWithURL(tweet.user?.profileImageUrl)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
