//
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by Satoru Sasozaki on 10/31/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit
import MBProgressHUD

class TweetsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        MBProgressHUD.showAdded(to: self.view, animated: true)
        TwitterClient.sharedInstance.homeTimeline(success: { (tweets: [Tweet]) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: {(error: Error) -> () in
            MBProgressHUD.hide(for: self.view, animated: true)
            print(error.localizedDescription)
        })
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
    }

    @IBAction func onLogoutButton(_ sender: UIBarButtonItem) {
        TwitterClient.sharedInstance.logout()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.tweets?.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell" ) as! TweetCell
        cell.usernameLabel.text = tweets?[indexPath.row].username
        cell.bodyTextLabel.text = tweets?[indexPath.row].text
        cell.timestampLabel.text = tweets?[indexPath.row].timestamp?.description
        cell.profileImageView.setImageWith((tweets?[indexPath.row].profileImageUrl)!)
        return cell
    }
}
