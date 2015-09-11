//
//  TimelineController.swift
//  butter
//
//  Created by Will Dalton on 9/10/15.
//  Copyright (c) 2015 daltomania. All rights reserved.
//

import UIKit

class TimelineController: UIViewController {

    var tweets: [Tweet]?
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
        })
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
