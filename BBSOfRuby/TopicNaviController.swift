//
//  TopicNaviController.swift
//  BBSOfRuby
//
//  Created by gxw on 14/9/24.
//  Copyright (c) 2014年 gxw. All rights reserved.
//

import UIKit

class TopicNaviController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarItem.title = "topics"
        self.tabBarItem.image = UIImage(named: "topics.png")
        
        var topicsCtr = TopicTableViewController(nibName: "TopicTableViewController", bundle: nil);
        self.viewControllers = [topicsCtr];
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
