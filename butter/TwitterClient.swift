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
            
            TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                for tweet in tweets {
                    println("text: \(tweet.text) \(tweet.createdAt)")
                }
                }) { (operation: AFHTTPRequestOperation!, reponse: NSError!) -> Void in
                    println("error getting home timeline")
            }
            
            }) { (error: NSError!) -> Void in
                println("FAILED TO GET AN ACCESS TOKEN :(")
                self.loginCompletion?(user: nil, error: error)
        }
    }
}
