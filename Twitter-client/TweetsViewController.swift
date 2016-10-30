//
//  TweetsViewController.swift
//  Twitter-client
//
//  Created by Xiomara on 10/30/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]!
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        self.getHomeTimeLine()
        
        refreshControl = UIRefreshControl(frame: CGRect.zero)
        refreshControl.addTarget(self,
            action: #selector(refreshAction),
            for: .allEvents
        )
        
        tableView.tableHeaderView = refreshControl
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Selector Methods
    func refreshAction(sender: AnyObject) {
        self.getHomeTimeLine()
        self.refreshControl.endRefreshing()
    }
    
    // MARK: - Helper Methods
    func getHomeTimeLine() {
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            
            }, failure: { (error) in
                print("Error: \(error.localizedDescription)")
        })
    }
}

extension TweetsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        
        let tweet = tweets[indexPath.row]
        cell.tweetText.text = tweet.text
        cell.username.text = tweet.user?.name
        cell.screenName.text = tweet.user?.screenName
        
        if let profileURL = tweet.user?.profileURL {
            cell.profileImageView.setImageWith(profileURL as URL)
        }
        
        return cell
    }
    
}
