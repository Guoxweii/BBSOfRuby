//
//  Topic.swift
//  BBSOfRuby
//
//  Created by gxw on 14/9/27.
//  Copyright (c) 2014年 gxw. All rights reserved.
//

/* function list
    
    class func list(success: () -> Void) -> Void //async

*/

import UIKit

class Topic: ActiveRecord {
    
    var id: NSNumber?
    var name: String?
    var avatar: String?
    var title: String?
    var replies_count: Int?
    var created_at: String?
    
    class func list(success: (AnyObject!) -> Void) {
        var TopListUrl = "https://ruby-china.org/api/topics.json"
        self.get(TopListUrl, success: {(responseBody: AnyObject!) -> Void in
            success(self.parseTopicList(responseBody))
        })
    }
    
    class func parseTopicList(responseBody: AnyObject!) -> AnyObject {
        var responseArray = responseBody as Array<Dictionary<String, AnyObject>>
        var result = Array<Topic>()
        
        for item in responseArray{
            var topic = Topic()

            var id: AnyObject? = item["id"]
            topic.id = id as NSNumber?
            
            var title: AnyObject? = item["title"]
            topic.title = title as String?
            
            var replies_count: AnyObject? = item["replies_count"]
            topic.replies_count = replies_count as Int?
            
            var created_at: AnyObject? = item["created_at"]
            topic.created_at = created_at as String?
            
            var tmpUser: AnyObject? = item["user"]
            var user = tmpUser as? Dictionary<String, AnyObject>
            
            var name: AnyObject? = user?["login"]
            topic.name = name as String?
            
            var avatar: AnyObject? = user?["avatar_url"]
            topic.avatar = avatar as String?
            
            result.append(topic)
        }
        
        return result
    }
}
