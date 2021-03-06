//
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by Satoru Sasozaki on 10/31/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit
import MBProgressHUD

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
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
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        print("isAuthrized: \(TwitterClient.sharedInstance.isAuthorized)")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //let tweetVC = storyboard?.instantiateViewController(withIdentifier: "TweetViewController")
        //navigationController?.pushViewController(tweetVC!, animated: true)
        let tweet = tweets?[indexPath.row]
        let id = tweet?.id

        
    }
    
    func pullToRefresh(refreshControl: UIRefreshControl) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        TwitterClient.sharedInstance.homeTimeline(success: { (tweets: [Tweet]) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.tweets = tweets
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        }, failure: {(error: Error) -> () in
            MBProgressHUD.hide(for: self.view, animated: true)
            refreshControl.endRefreshing()
            print(error.localizedDescription)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tweetSegue" {
            let tweetVC = segue.destination as! TweetViewController
            let indexPath = tableView.indexPathForSelectedRow
            tweetVC.tweet = tweets?[(indexPath?.row)!]
        }
    }
    
}
