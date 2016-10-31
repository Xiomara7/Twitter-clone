//
//  TwitterClient.swift
//  Twitter-client
//
//  Created by Xiomara on 10/29/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(
        baseURL: NSURL(string: "https://api.twitter.com") as URL!,
        consumerKey: "VtX3yrwwrJlJlYHJitnA2Vl92",
        consumerSecret: "Z1xUeFcGFrqcQliFp4mj61WkWrJDewGLDA3SaKbnKNgVYraGRQ"
    )
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error)-> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(
            withPath: "oauth/request_token",
            method: "GET",
            callbackURL: NSURL(string: "twitterdemo://oauth") as URL!,
            scope: nil,
            success: { (requestToken) -> Void in
                let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                
            }, failure: { error in
                self.loginFailure?(error!)
            }
        )
    }
    
    // Fetch the home timeline
    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json",
            parameters: nil,
            progress: nil,
            success: { (_, response) in
                let dictionaries = response as! [NSDictionary]
                let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
                success(tweets)
                
        }) { (_, error) in
            failure(error)
        }
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json",
            parameters: nil,
            progress: nil,
            success: { (_, response) in
                let userDict = response as! NSDictionary
                let user = User(dictionary: userDict)
                success(user)
                
        }, failure: { (_, error) in
            failure(error)
        })
    }
    
    func composeTweet(tweet: String, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        post("1.1/statuses/update.json",
             parameters: ["status":tweet],
             progress: nil,
             success: { (_, response) in
                print("response for new tweet: \(response)")
                let tweet = Tweet(dictionary: response as! NSDictionary)
                success(tweet)
            }) { (task, error) in
                failure(error)
        }
    }
    
    func replyTweet(tweet: String, tweetID: Int, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        print("reply twetID: \(tweetID)")
        
        post("1.1/statuses/update.json",
             parameters: ["status":tweet, "in_reply_to_status_id":tweetID],
             progress: nil,
             success: { (_, response) in
                
                print("reply response: \(response)")
                let tweet = Tweet(dictionary: response as! NSDictionary)
                success(tweet)
                
        }) { (task, error) in
            failure(error)
        }
    }
    
    func retweet(tweetID: Int, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        post("1.1/statuses/retweet/:\(tweetID).json",
             parameters: nil,
             progress: nil,
             success: { (_, response) in
                let tweet = Tweet(dictionary: response as! NSDictionary)
                success(tweet)
        }) { (task, error) in
            failure(error)
        }
    }
    
    func favorite(tweetID: Int, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        post("1.1/favorites/create.json?id=\(tweetID)",
            parameters: nil,
            progress: nil,
            success: { (_, response) in
                let tweet = Tweet(dictionary: response as! NSDictionary)
                success(tweet)
        }) { (task, error) in
            failure(error)
        }
    }
    
    func handleOpenURL(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(
            withPath: "oauth/access_token",
            method: "POST",
            requestToken: requestToken,
            success: { accessToken in
                self.currentAccount(success: { user in
                    User.currentUser = user
                    self.loginSuccess?()
                    
                }, failure: { error in
                    self.loginFailure?(error)
                })
        }) { (error) -> Void in
            self.loginFailure?(error!)
        }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
}
