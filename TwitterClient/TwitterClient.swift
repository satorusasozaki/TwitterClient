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
}
