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
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(succeess: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = succeess
        loginFailure = failure
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "TwitterClient://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\((requestToken?.token)!)")
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            
        }, failure: { (error: Error?) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })
    }
    
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken :BDBOAuth1Credential?) in
            // logged in
            
            self.currentAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: {(error: Error) -> () in
                self.loginFailure?(error)
            })
            
        }, failure: { (error :Error?) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })
    }
    
    func logout() {
        deauthorize()
        User.currentUser = nil
        NotificationCenter.default.post(name: User.userDidLogoutNotification, object: nil)
    }
    
    // this method can be called on sharedInstance but not TwitterClient class
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (_ , response: Any?) in
            print(response!)
            let userDictionary = response as! [String:AnyObject]
            let user = User(dictionary: userDictionary)
            success(user)
        }, failure: { (task: URLSessionDataTask?, error :Error) in
            failure(error)
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
    
    func tweet(text: String) {
        let status: [String:String] = ["status":text]
        post("1.1/statuses/update.json", parameters: status, progress: nil, success: {(_, response: Any?) -> Void in
            print("\(text) is tweeted")
        }, failure: {(_, error: Error) -> Void in
            print("\(text) is failed to tweet")
            print("Error:   \(error.localizedDescription)")
        })
    }
    
    func retweet(id: Int) {
        let path = "1.1/statuses/retweet/" + id.description + ".json"
        post(path, parameters: nil, progress: nil, success: {(_, response: Any?) -> Void in
            print("\(response) is retweeted")
        }, failure: {(_, error: Error) -> Void in
            print("failed to retweet")
            print("Error:   \(error.localizedDescription)")
        })
    }
    
    func favorite(id: Int) {
        let tweetId: [String:Int] = ["id":id]
        post("1.1/favorites/create.json", parameters: tweetId, progress: nil, success: {(_, response: Any?) -> Void in
            print("\(response) is favorited")
        }, failure: {(_, error: Error) -> Void in
            print("failed to favorite")
            print("Error:   \(error.localizedDescription)")
        })
    }
    
    func reply(text: String, id: Int) {
        let parameters: [String:String] = ["in_reply_to_status_id":text, "id":id.description]
        post("1.1/statuses/update.json", parameters: parameters, progress: nil, success: {(_, response: Any?) -> Void in
            print("\(text) is replied")
        }, failure: {(_, error: Error) -> Void in
            print("\(text) is failed to reply")
            print("Error:   \(error.localizedDescription)")
        })
    
    }
}
