//
//  TweetDetailsViewController.swift
//  Twitter-client
//
//  Created by Xiomara on 10/30/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var retweetsCount: UILabel!
    @IBOutlet weak var favoritesCount: UILabel!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        username.text = tweet.user?.name
        tweetText.text = tweet.text
        retweetsCount.text = "\(tweet.retweetCount)"
        favoritesCount.text = "\(tweet.favoritesCount)"
        
        print("xio: \(tweet.retweetCount)")
        print("xio: \(tweet.favoritesCount)")
        
        if let screenname = tweet.user?.screenName {
            screenName.text = "@\(screenname)"
        }
        
        if let time = tweet.timestamp {
            timestamp.text = "\(time)"
        }
        
        if let profileURL = tweet.user?.profileURL {
            profileImageView.layer.cornerRadius = 5.0
            profileImageView.layer.masksToBounds = true
            
            profileImageView.setImageWith(profileURL as URL)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
