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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLoginButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.login(success: {
            // segue to the next view controller
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            
        }, failure: { (error) in
            print("Error \(error.localizedDescription)")
        })
    }
}
