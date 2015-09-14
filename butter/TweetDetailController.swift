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
    override func viewDidLoad() {
        super.viewDidLoad()
        createdAtLabel.text = tweet?.createdAtString
        tweetLabel.text = tweet?.text
        usernameLabel.text = tweet?.user?.screenname
        nameLabel.text = tweet?.user?.name
        avatarImageView.setImageWithURL(tweet?.user?.profileImageUrl)
        avatarImageView.layer.cornerRadius = 3
        avatarImageView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
