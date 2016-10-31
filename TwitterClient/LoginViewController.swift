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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLoginButton(_ sender: UIButton) {
        TwitterClient.sharedInstance.login(succeess: {() -> () in
            print("Logged In")
            TwitterClient.sharedInstance.currentAccount()
            // be sure to connect segue from LoginVC to TweetsVC but not login button to TweetsVC, otherwise transition will happen imediately 
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }, failure: {(error: Error) -> () in
            print("Error: \(error.localizedDescription)")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
