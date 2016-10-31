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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            TwitterClient.sharedInstance?.composeTweet(tweet: text, success: { (newTweet) in
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("error:\(error.localizedDescription)")
            })
        }
    }

    @IBAction func onCancelButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
