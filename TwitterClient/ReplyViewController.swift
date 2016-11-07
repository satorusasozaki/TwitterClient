//
//  ReplyViewController.swift
//  TwitterClient
//
//  Created by Satoru Sasozaki on 10/31/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {
    @IBOutlet weak var replyField: UITextField!
    var tweet: Tweet?
    override func viewDidLoad() {
        super.viewDidLoad()
        replyField.text = "@" + (tweet?.screenname)! + " "
        // Do any additional setup after loading the view.
    }

    @IBAction func onReplyButton(_ sender: UIBarButtonItem) {
        let id = tweet?.id
        let text = replyField.text
        TwitterClient.sharedInstance.reply(text: text!, id: id!)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
