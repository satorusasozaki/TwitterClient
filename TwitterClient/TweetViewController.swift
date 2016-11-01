//
//  TweetViewController.swift
//  TwitterClient
//
//  Created by Satoru Sasozaki on 10/31/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    var tweet: Tweet?
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetLabel.text = tweet?.text
    }
    
    @IBAction func onRetweetButton(_ sender: UIButton) {
        let id = tweet?.id
        TwitterClient.sharedInstance.retweet(id: id!)
        sender.setTitle("Retweeted", for: UIControlState.normal)
    }
    
    @IBAction func onLikeButton(_ sender: UIButton) {
        let id = tweet?.id
        TwitterClient.sharedInstance.favorite(id: id!)
        sender.setTitle("Liked", for: UIControlState.normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "replySegue" {
            let replyNVC = segue.destination as! UINavigationController
            let replyVC = replyNVC.viewControllers[0] as! ReplyViewController
            replyVC.tweet = tweet
        }
    }

}
