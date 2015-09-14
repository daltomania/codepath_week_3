//
//  ComposeController.swift
//  butter
//
//  Created by Will Dalton on 9/14/15.
//  Copyright (c) 2015 daltomania. All rights reserved.
//

import UIKit

class ComposeController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
