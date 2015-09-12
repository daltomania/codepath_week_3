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
    @IBOutlet weak var retweeterLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var tweet: Tweet! {
        didSet {
            nameLabel.text = tweet.text
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
