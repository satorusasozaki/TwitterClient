//
//  TwitterClient.swift
//  TwitterClient
//
//  Created by Satoru Sasozaki on 10/30/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "O2sRlvGCz5zbX2i7Y08bjQwwP", consumerSecret: "2PRcOD4jAFGHL88CvFwWD3J2NIIWt1gxsX263AZnGhYLiZI3w8")!
    
    // this method can be called on sharedInstance but not TwitterClient class
    func currentAccount() {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (_ , response: Any?) in
            print(response!)
            let userDictionary = response as! [String:AnyObject]
            let user = User(dictionary: userDictionary)
            print("name: \(user.name!)")
            print("screen_name: \(user.screenname!)")
            print("profile_url: \(user.profileUrl)")
            print("description: \(user.tagline)")
            
        }, failure: { (task: URLSessionDataTask?, error :Error) in
            print(error.localizedDescription)
        })
    }
    
    // @escaping is needed when a block of code passes as a parameter execute after the function returns 
    // https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (_, response: Any?) in
            let tweets = Tweet.tweetsWithArray(dictionaries: response as! [AnyObject])
            success(tweets)
        }, failure: { (_, error: Error) in
            failure(error)
        })
    }
}
