//
//  ComposeController.swift
//  butter
//
//  Created by Will Dalton on 9/14/15.
//  Copyright (c) 2015 daltomania. All rights reserved.
//

import UIKit

class ComposeController: UIViewController {

    @IBAction func onTweet(sender: AnyObject) {
        createTweet(tweetTextField.text)
    }
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var tweetTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = "@\(User.currentUser!.screenname!)"
        nameLabel.text = User.currentUser?.name
        avatarImageView.setImageWithURL(User.currentUser?.profileImageUrl)
        avatarImageView.layer.cornerRadius = 3
        avatarImageView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createTweet(status: String) {
        let params: [String:String] = ["status": status]
        TwitterClient.sharedInstance.createTweet(params, completion: { (tweets, error) -> () in
            println("tweet created")
        })
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
