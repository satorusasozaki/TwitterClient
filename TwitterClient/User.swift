//
//  User.swift
//  TwitterClient
//
//  Created by Satoru Sasozaki on 10/30/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var tagline: String?
    
    init(dictionary: [String:AnyObject]) {
        // de-serialization
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        
        tagline = dictionary["description"] as? String
    }
}
