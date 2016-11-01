//
//  LoginViewController.swift
//  TwitterClient
//
//  Created by Satoru Sasozaki on 10/29/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLoginButton(_ sender: UIButton) {
        TwitterClient.sharedInstance.login(succeess: {() -> () in
            print("Logged In")
            // be sure to connect segue from LoginVC to TweetsVC but not login button to TweetsVC, otherwise transition will happen imediately
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }, failure: {(error: Error) -> () in
            print("Error: \(error.localizedDescription)")
        })
    }
    
}
