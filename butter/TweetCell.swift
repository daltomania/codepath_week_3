//
//  TweetCell.swift
//  butter
//
//  Created by Will Dalton on 9/11/15.
//  Copyright (c) 2015 daltomania. All rights reserved.
//

import UIKit

protocol TweetCellProtocol {
    func replyTo(tweet: Tweet)
}

class TweetCell: UITableViewCell {

    var delegate: TweetCellProtocol?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBAction func replyButton(sender: AnyObject) {
        if let delegate = self.delegate, tweet = tweet {
            delegate.replyTo(tweet)
        }
    }
    
    @IBAction func retweetButton(sender: AnyObject) {
        let id: String = "\(tweet!.id!)"
        let params: [String: String] = ["id": id]
        TwitterClient.sharedInstance.retweetTweet(params) { (success, error) -> () in
            println("retweet!!!!!!")
        }
    }
    
    @IBAction func favoriteButton(sender: AnyObject) {
        let id: String = "\(tweet!.id!)"
        let params: [String: String] = ["id": id]
        TwitterClient.sharedInstance.createFavorite(params, completion: { (success, error) -> () in
            println("favorite created!!!!!!!!")
        })
    }
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
