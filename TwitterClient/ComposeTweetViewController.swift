//
//  ComposeTweetViewController.swift
//  TwitterClient
//
//  Created by Satoru Sasozaki on 10/31/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {

    @IBOutlet weak var tweetField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onTweetButton(_ sender: UIBarButtonItem) {
        if let tweet = tweetField.text {
            TwitterClient.sharedInstance.tweet(text: tweet)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
