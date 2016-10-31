//
//  ComposeViewController.swift
//  Twitter-client
//
//  Created by Xiomara on 10/30/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var tweetTextField: UITextView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var tweetCountdown: UILabel!
    
    var currentUser: User!
    
    var isReply: Bool = false
    var tweetID: Int?
    var replyTo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImageView.layer.cornerRadius = 5.0
        profileImageView.layer.masksToBounds = true
        
        tweetTextField.delegate = self
        
        TwitterClient.sharedInstance?.currentAccount(
        success: { user in
            self.currentUser = user
            self.populateViews()
            
        }, failure: { error in
            // HANDLE ERROR
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("reply: \(isReply)")
        print("tweetID: \(tweetID)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tweetTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Selector Methods
    @IBAction func onTweetButton(_ sender: AnyObject) {
        if let text = tweetTextField.text {
            if isReply {
                TwitterClient.sharedInstance?.replyTweet(
                tweet: text,
                tweetID: tweetID!,
                success: { newTweet in
                    self.dismiss(animated: true, completion: nil)
                    
                }, failure: { error in
                    print("error: \(error.localizedDescription)")
                })
            } else {
                TwitterClient.sharedInstance?.composeTweet(
                tweet: text,
                success: { newTweet in
                    self.dismiss(animated: true, completion: nil)
                    
                }, failure: { (error) in
                    print("error: \(error.localizedDescription)")
                })
            }
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
        
        if let replyTo = replyTo {
            tweetTextField.text = "@\(replyTo) "
        }
    }
}

extension ComposeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if 140 - (tweetTextField.text?.characters.count)! < 0 {
            tweetCountdown.textColor = UIColor.red
        } else {
            tweetCountdown.textColor = UIColor.gray
        }
        
        tweetCountdown.reloadInputViews()
        tweetCountdown.text = "\(140 - (tweetTextField.text?.characters.count)!)"
    }
    
}




