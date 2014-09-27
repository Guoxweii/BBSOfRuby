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
    var body: String?
    var replies_count: Int?
    var created_at: String?
    var comments: Array<Comment> = []
    
    class func list(success: (AnyObject!) -> Void) {
        var TopListUrl = "https://ruby-china.org/api/topics.json"
        self.get(TopListUrl, success: {(responseBody: AnyObject!) -> Void in
            success(self.parseTopicList(responseBody))
        })
    }
    
    class func find(id: NSNumber, success: (AnyObject!) -> Void) {
        var url = "https://ruby-china.org/api/topics/\(id).json"
        self.get(url, success: {(responseBody: AnyObject!) -> Void in
            success(self.parseTopicDetail(responseBody))
        })
    }
    
    class func parseTopicList(responseBody: AnyObject!) -> Array<Topic> {
        var responseArray = responseBody as Array<Dictionary<String, AnyObject>>
        var result = Array<Topic>()
        
        for item in responseArray{
            var topic = self.initializeTopic(item) as Topic
            result.append(topic)
        }
        
        return result
    }
    
    class func parseTopicDetail(responseBody: AnyObject!) -> Topic {
        var responseHash = responseBody as Dictionary<String, AnyObject>
        var topic = self.initializeTopic(responseHash)
        
        var commentsObject: AnyObject? = responseHash["replies"]
        var commentsArray = commentsObject as? Array<Dictionary<String, AnyObject>>
        topic.comments = self.createComments(commentsArray!)
        
        return topic
    }
    
    class func initializeTopic(item: Dictionary<String, AnyObject>) -> Topic {
        var topic = Topic()
        
        var id: AnyObject? = item["id"]
        topic.id = id as NSNumber?
        
        var title: AnyObject? = item["title"]
        topic.title = title as String?
        
        var replies_count: AnyObject? = item["replies_count"]
        topic.replies_count = replies_count as Int?
        
        var created_at: AnyObject? = item["created_at"]
        topic.created_at = created_at as String?
        
        var body: AnyObject? = item["body"]
        topic.body = body as String?
        
        var tmpUser: AnyObject? = item["user"]
        var user = tmpUser as? Dictionary<String, AnyObject>
        
        var name: AnyObject? = user?["login"]
        topic.name = name as String?
        
        var avatar: AnyObject? = user?["avatar_url"]
        topic.avatar = avatar as String?
        
        return topic
    }
    
    class func createComments(commentsArray: Array<Dictionary<String, AnyObject>>) -> Array<Comment>{
        var comments = Array<Comment>()
        
        for item in commentsArray {
            var comment = Comment()
            
            var body: AnyObject? = item["body"]
            comment.body = body as String?
            
            var tmpUser: AnyObject? = item["user"]
            var user = tmpUser as? Dictionary<String, AnyObject>
            
            var name: AnyObject? = user?["login"]
            comment.name = name as String?
            
            var avatar: AnyObject? = user?["avatar_url"]
            comment.avatar = avatar as String?
            
            comments.append(comment)
        }
        
        return comments
    }
}
