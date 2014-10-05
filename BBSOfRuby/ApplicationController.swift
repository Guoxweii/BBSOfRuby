//
//  ApplicationController.swift
//  BBSOfRuby
//
//  Created by gxw on 14/9/24.
//  Copyright (c) 2014年 gxw. All rights reserved.
//

import UIKit

class ApplicationController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var TopicBaseCtr = TopicNaviController()
        TopicBaseCtr.tabBarItem.title = "时间线"
        TopicBaseCtr.tabBarItem.image = UIImage(named: "topics.png")
        
        var JobBaseCtr = JobNaviController()
        JobBaseCtr.tabBarItem.title = "招聘ing"
        JobBaseCtr.tabBarItem.image = UIImage(named: "jobs.png")
        
        self.viewControllers = [TopicBaseCtr, JobBaseCtr];
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
