//
//  TwitterClient.swift
//  butter
//
//  Created by Will Dalton on 9/10/15.
//  Copyright (c) 2015 daltomania. All rights reserved.
//

import UIKit

let twConsumerKey = "aXyVrkZGTAhQtDn7zzq24Rghd"
let twConsumerSecret = "FxXa7t9a1HuWBOge7je3mzewSTPXlYNSnwHtpXhUQTxDXxGe3K"
let twBaseUrl = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(
                baseURL: twBaseUrl,
                consumerKey: twConsumerKey,
                consumerSecret: twConsumerSecret
            )
        }
        
        return Static.instance
    }
    
    func createTweet(params: NSDictionary?, completion: (success: String?, error: NSError?) -> ()) {
        POST("1.1/statuses/update.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            completion(success: "yay", error: nil)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error creating tweet")
                println(error.description)
                completion(success: nil, error: error)
        }
    }
    
    func retweetTweet(params: [String:String], completion: (success: String?, error: NSError?) -> ()) {
        let tweetId: String = params["id"]!
        POST("1.1/statuses/retweet/\(tweetId).json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            completion(success: "yay", error: nil)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error creating tweet")
                println(error.description)
                completion(success: nil, error: error)
        }
    }
    
    func createFavorite(params: NSDictionary?, completion: (success: String?, error: NSError?) -> ()) {
        POST("1.1/favorites/create.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            completion(success: "yay", error: nil)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error creating tweet")
                println(error.description)
                completion(success: nil, error: error)
        }
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error getting home timeline")
                completion(tweets: nil, error: error)
        }
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        // fetch request token & redirect ot auth page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil,
            success: { (requestToken: BDBOAuth1Credential!) -> Void in
                println("omg token")
                var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
                UIApplication.sharedApplication().openURL(authURL)
            }) { (error: NSError!) -> Void in
                println("failed to get request token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            println("GOT AN ACCESS TOKEN!!!!!!!!!")
            
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                // println("user: \(response)")
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                println("\(user.name)")
                self.loginCompletion?(user: user, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })
            
            }) { (error: NSError!) -> Void in
                println("FAILED TO GET AN ACCESS TOKEN :(")
                self.loginCompletion?(user: nil, error: error)
        }
    }
}
