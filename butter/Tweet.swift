//
//  Tweet.swift
//  butter
//
//  Created by Will Dalton on 9/11/15.
//  Copyright (c) 2015 daltomania. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var id: Int?
    var favorited: Int?
    var retweeted: Int?
    var favoriteCount: Int?
    var retweetedCount: Int?
    
    init(dictionary: NSDictionary) {
        //print(dictionary)
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        id = dictionary["id"] as? Int
        favorited = dictionary["favorited"] as? Int
        retweeted = dictionary["retweeted"] as? Int
        favoriteCount = dictionary["favorite_count"] as? Int
        retweetedCount = dictionary["retweet_count"] as? Int
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}
