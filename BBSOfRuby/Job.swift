//
//  Job.swift
//  BBSOfRuby
//
//  Created by gxw on 14/10/4.
//  Copyright (c) 2014年 gxw. All rights reserved.
//

import UIKit

class Job: Topic {
    override class func list(success: (AnyObject!) -> Void) {
        var TopListUrl = "https://ruby-china.org/api/topics/node/25.json"
        self.get(TopListUrl, success: {(responseBody: AnyObject!) -> Void in
            success(self.parseTopicList(responseBody))
        })
    }
}
