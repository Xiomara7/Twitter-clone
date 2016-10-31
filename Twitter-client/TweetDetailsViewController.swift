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
    
    @IBOutlet weak var retweetImage: UIButton!
    @IBOutlet weak var favoriteImage: UIButton!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        username.text = tweet.user?.name
        tweetText.text = tweet.text
    
        retweetsCount.text = "\(tweet.retweetCount)"
        favoritesCount.text = "\(tweet.favoritesCount)"
        
        if let favorited = tweet.favorited {
            if favorited {
                favoritesCount.text = "\(tweet.favoritesCount + 1)"
                favoriteImage.isSelected = true
            }
        }
        
        if let retweeted = tweet.retweeted {
            if retweeted {
                retweetsCount.text = "\(tweet.retweetCount + 1)"
                retweetImage.isSelected = true
            }
        }
        
        if let screenname = tweet.user?.screenName {
            screenName.text = "@\(screenname)"
        }
        
        if let time = tweet.timestamp {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy HH:mm a"
            formatter.amSymbol = "AM"
            formatter.pmSymbol = "PM"
            
            timestamp.text = formatter.string(from: time as Date)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationNC = segue.destination as! UINavigationController
        let destination = destinationNC.topViewController as! ComposeViewController
        destination.isReply = true
        destination.tweetID = tweet.id
        destination.replyTo = tweet.user?.screenName
    }
    
    // MARK: - Selector Methods
    @IBAction func onReplyButton(_ sender: AnyObject) {
        
    }
    
    @IBAction func onRetweetButton(_ sender: AnyObject) {
        if !retweetImage.isSelected {
            TwitterClient.sharedInstance?.retweet(
            tweetID: tweet.id!,
            success: { tweet in
                self.retweetsCount.text = "\(tweet.retweetCount + 1)"
                self.retweetImage.isSelected = true
                
                self.navigationController?.popViewController(animated: true)
                
            }, failure: { error in
                print(error.localizedDescription)
            })
            
        }
    }
    
    @IBAction func onStarButton(_ sender: AnyObject) {
        if !favoriteImage.isSelected {
            TwitterClient.sharedInstance?.favorite(
            tweetID: tweet.id!,
            success: { tweet in
                self.favoritesCount.text = "\(tweet.favoritesCount + 1)"
                self.favoriteImage.isSelected = true
                
                self.navigationController?.popViewController(animated: true)
                
            }, failure: { error in
                print(error.localizedDescription)
            })
        }
    }
}
