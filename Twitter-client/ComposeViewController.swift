//
//  ComposeViewController.swift
//  Twitter-client
//
//  Created by Xiomara on 10/30/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    
    @IBOutlet weak var tweetTextField: UITextField!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImageView.layer.cornerRadius = 5.0
        profileImageView.layer.masksToBounds = true
        
        TwitterClient.sharedInstance?.currentAccount(
        success: { user in
            self.currentUser = user
            self.populateViews()
            
        }, failure: { error in
            // HANDLE ERROR
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tweetTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onTweetButton(_ sender: AnyObject) {
        if let text = tweetTextField.text {
            TwitterClient.sharedInstance?.composeTweet(
                tweet: text,
                success: { newTweet in
                    print("new tweet: \(newTweet)")
                    self.dismiss(animated: true, completion: nil)
            
                }, failure: { (error) in
                    // HANDLE ERROR
                }
            )
        }
    }

    @IBAction func onCancelButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func populateViews() {        
        if currentUser != nil {
            username.text = currentUser.name
            screenName.text = currentUser.screenName
            
            if let profileURL = currentUser.profileURL {
                profileImageView.setImageWith(profileURL as URL)
            }
        }
    }
}
