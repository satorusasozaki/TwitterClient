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
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetLabel.text = tweet?.text
        // Do any additional setup after loading the view.
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
