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
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBAction func replyButton(sender: AnyObject) {
        if let delegate = self.delegate, tweet = tweet {
            delegate.replyTo(tweet)
        }
    }
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBAction func retweetButton(sender: AnyObject) {
        let id: String = "\(tweet!.id!)"
        let params: [String: String] = ["id": id]
        TwitterClient.sharedInstance.retweetTweet(params) { (success, error) -> () in
            let image = UIImage(named: "retweet_on")
            self.retweetButton.setImage(image, forState: .Normal)
        }
    }
    
    @IBAction func favoriteButton(sender: AnyObject) {
        let id: String = "\(tweet!.id!)"
        let params: [String: String] = ["id": id]
        if (tweet!.favorited == 1) {
            tweet!.favorited == 0
            let image = UIImage(named: "favorite")
            self.favoriteButton.setImage(image, forState: .Normal)
        } else {
            TwitterClient.sharedInstance.createFavorite(params, completion: { (success, error) -> () in
                let image = UIImage(named: "favorite_on")
                self.favoriteButton.setImage(image, forState: .Normal)
            })
        }

    }
    
    @IBAction func profileButton(sender: AnyObject) {
        print("OMG")
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
            if (tweet.favoriteCount == 0) {
                favoriteCountLabel.text = ""
            } else {
                favoriteCountLabel.text = "\(tweet.favoriteCount!)"
            }
            
            if (tweet.retweetedCount == 0) {
                retweetCountLabel.text = ""
            } else {
                retweetCountLabel.text = "\(tweet.retweetedCount!)"
            }

            if (tweet.favorited == 1) {
                let image = UIImage(named: "favorite_on")
                favoriteButton.setImage(image, forState: .Normal)
            }
            if (tweet.retweeted == 1) {
                let image = UIImage(named: "retweet_on")
                retweetButton.setImage(image, forState: .Normal)
            }
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
