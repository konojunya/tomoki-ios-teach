//
//  ViewController.swift
//  tomoki-ios-teach
//
//  Created by konojunya on 2018/01/23.
//  Copyright © 2018年 konojunya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tweets = Api.Feed.getTweets()
        print(tweets.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

