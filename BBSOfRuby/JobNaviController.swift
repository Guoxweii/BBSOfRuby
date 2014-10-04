//
//  JobNaviController.swift
//  BBSOfRuby
//
//  Created by gxw on 14/10/4.
//  Copyright (c) 2014年 gxw. All rights reserved.
//

import UIKit

class JobNaviController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var jobsCtr = JobTableViewController(nibName: "JobTableViewController", bundle: nil)
        self.viewControllers = [jobsCtr]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
