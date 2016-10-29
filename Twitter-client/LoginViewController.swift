//
//  LoginViewController.swift
//  Twitter-client
//
//  Created by Xiomara on 10/28/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: AnyObject) {
        let twitterClient = BDBOAuth1SessionManager(
            baseURL: NSURL(string: "https://api.twitter.com") as URL!,
            consumerKey: "VtX3yrwwrJlJlYHJitnA2Vl92",
            consumerSecret: "Z1xUeFcGFrqcQliFp4mj61WkWrJDewGLDA3SaKbnKNgVYraGRQ"
        )
        
        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(
            withPath: "oauth/request_token",
            method: "GET",
            callbackURL: NSURL(string: "twitterdemo://oauth") as URL!,
            scope: nil,
            success: { (requestToken) -> Void in
                let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                
            }, failure: { error in
                print(error)
            }
        )
    }

}
