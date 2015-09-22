//
//  ProfileController.swift
//  butter
//
//  Created by Will Dalton on 9/21/15.
//  Copyright © 2015 daltomania. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    var user: User?
    
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if user == nil {
            user = User.currentUser
        }
        
        followingCountLabel.text = "\(user!.followingCount!)"
        followersCountLabel.text = "\(user!.followersCount!)"
        tweetCountLabel.text = "\(user!.tweetCount!)"
        profileImage.setImageWithURL(user!.profileImageUrl)
        if user!.profileBannerImageUrl != nil {
            backgroundImage.setImageWithURL(User.currentUser?.profileBannerImageUrl)
        }
        profileImage.layer.cornerRadius = 3
        profileImage.clipsToBounds = true
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
