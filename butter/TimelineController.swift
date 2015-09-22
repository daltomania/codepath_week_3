//
//  TimelineController.swift
//  butter
//
//  Created by Will Dalton on 9/10/15.
//  Copyright (c) 2015 daltomania. All rights reserved.
//

import UIKit

class TimelineController: UIViewController, UITableViewDataSource,
    UITableViewDelegate, TweetCellProtocol {

    var refreshControl: UIRefreshControl!
    var tweets: [Tweet]!
    var sourceTweet: Tweet?
    var timelineType: String!
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // pull to reload
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "loadTweets", forControlEvents: UIControlEvents.ValueChanged)
        let dummyTableVC = UITableViewController()
        dummyTableVC.tableView = tableView
        dummyTableVC.refreshControl = refreshControl

        loadTweets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadTweets() {
        if timelineType == "mentions" {
            TwitterClient.sharedInstance.mentionsTimelineWithParams(nil, completion: { (tweets, error) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            })
        } else {
            TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            })
        }

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func replyTo(tweet: Tweet) {
        sourceTweet = tweet
        performSegueWithIdentifier("composeSegue", sender: self)
    }
    
    /*
    // MARK: - Navigation
    */

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "composeSegue" {
            let vc = segue.destinationViewController as! ComposeController
            vc.tweet = self.sourceTweet
        } else if segue.identifier == "profileSegue" {
            let vc = segue.destinationViewController as! ProfileController
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! TweetCell
            vc.user = tweets[tableView.indexPathForCell(cell)!.row].user
        } else {
            let vc = segue.destinationViewController as! TweetDetailController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            vc.tweet = tweets[indexPath!.row]
        }
    }

}
