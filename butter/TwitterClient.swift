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
    
}
