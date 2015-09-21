//
//  TweetDetailController.swift
//  butter
//
//  Created by Will Dalton on 9/14/15.
//  Copyright (c) 2015 daltomania. All rights reserved.
//

import UIKit

class TweetDetailController: UIViewController {

    var tweet: Tweet?
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBAction func retweetButton(sender: AnyObject) {
        retweet()
    }
    @IBAction func favoriteButton(sender: AnyObject) {
        favorite()
    }
    @IBAction func replyButton(sender: AnyObject) {
        reply()
    }
    @IBOutlet weak var retweenButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createdAtLabel.text = tweet?.createdAtString
        tweetLabel.text = tweet?.text
        usernameLabel.text = "@\(tweet!.user!.screenname!)"
        nameLabel.text = tweet?.user?.name
        if (tweet?.favoriteCount == 0) {
            favoriteCountLabel.text = ""
        } else {
            favoriteCountLabel.text = "\(tweet!.favoriteCount!)"
        }
        if (tweet?.retweetedCount == 0) {
            retweetCountLabel.text = ""
        } else {
            retweetCountLabel.text = "\(tweet!.retweetedCount!)"
        }
        
        avatarImageView.setImageWithURL(tweet?.user?.profileImageUrl)
        avatarImageView.layer.cornerRadius = 3
        avatarImageView.clipsToBounds = true
        if (tweet?.favorited == 1) {
            let image = UIImage(named: "favorite_on")
            favoriteButton.setImage(image, forState: .Normal)
        }
        if (tweet?.retweeted == 1) {
            let image = UIImage(named: "retweet_on")
            retweenButton.setImage(image, forState: .Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func retweet() {
        let id: String = "\(tweet!.id!)"
        let params: [String: String] = ["id": id]
        TwitterClient.sharedInstance.retweetTweet(params) { (success, error) -> () in
            print("retweet!!!!!!")
        }
    }
    
    func favorite() {
        let id: String = "\(tweet!.id!)"
        let params: [String: String] = ["id": id]
        if (tweet?.favorited == 1) {
            let image = UIImage(named: "favorite")
            self.favoriteButton.setImage(image, forState: .Normal)
        } else {
            TwitterClient.sharedInstance.createFavorite(params, completion: { (success, error) -> () in
                let image = UIImage(named: "favorite_on")
                self.favoriteButton.setImage(image, forState: .Normal)
            })
        }
    }
    
    func reply() {
        print("you should do something here")
        performSegueWithIdentifier("replaySegue", sender: self)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
