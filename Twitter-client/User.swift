//
//  User.swift
//  Twitter-client
//
//  Created by Xiomara on 10/29/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: String?
    var screenName: String?
    var profileURL: NSURL?
    var tagLine: String?

    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        tagLine = dictionary["description"] as? String
        
        let profileURLString = dictionary["profile_image_url_https"]
        if let profileURLString = profileURLString {
            profileURL = NSURL(string: profileURLString as! String)
        }
    }
}
