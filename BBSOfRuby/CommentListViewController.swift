//
//  CommentListViewController.swift
//  BBSOfRuby
//
//  Created by gxw on 14/9/25.
//  Copyright (c) 2014年 gxw. All rights reserved.
//

import UIKit

class CommentListViewController: UITableViewController {
    
    var topicId: NSNumber!
    var tableData: Dictionary<String, AnyObject>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "提问详情"

        let headerName = "TopicHeaderCell"
        let nib = UINib(nibName: headerName, bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: headerName)
        
        let commentName = "CommentCell"
        let commentNib = UINib(nibName: commentName, bundle: nil)
        self.tableView.registerNib(commentNib, forCellReuseIdentifier: commentName)
        
        let url = NSURL(string: "https://ruby-china.org/api/topics/\(self.topicId).json")
        var request = NSURLRequest(URL: url)
        var operation = AFHTTPRequestOperation(request: request)
        operation.responseSerializer = AFJSONResponseSerializer()
        operation.setCompletionBlockWithSuccess(
            { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) -> Void in
                self.tableData = responseObject as? Dictionary<String, AnyObject>
                println(self.tableData)
                self.tableView.reloadData()
            },
            failure: {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error happen")
            }
        )
        NSOperationQueue.mainQueue().addOperation(operation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataHash = self.tableData {
            var commentsObject: AnyObject? = dataHash["replies"]
            var commentsArray = commentsObject as? Array<Dictionary<String, AnyObject>>
            
            if let comments = commentsArray {
                return comments.count + 1
            }
        }
        
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return self.setHeaderHeight()
        } else {
            return self.setCommentHeight(indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            return self.createHeaderCell(indexPath)
        } else {
            return self.createCommentCell(indexPath)
        }
    }
    
    func createHeaderCell(indexPath: NSIndexPath) -> UITableViewCell! {
        let headerName = "TopicHeaderCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(headerName, forIndexPath: indexPath) as TopicHeaderCell
        
        if let dataHash = self.tableData {
            var titleObject: AnyObject? = dataHash["title"]
            var title = titleObject as String?
            cell.title.text = title?
            
            var bodyObject: AnyObject? = dataHash["body"]
            var body = bodyObject as String?
            cell.body.text = body?
        }
        return cell
    }
    
    func createCommentCell(indexPath: NSIndexPath) -> UITableViewCell! {
        let commentName = "CommentCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(commentName, forIndexPath: indexPath) as CommentCell
        
        if let dataHash = self.tableData {
            var commentsObject: AnyObject? = dataHash["replies"]
            var commentsArray = commentsObject as? Array<Dictionary<String, AnyObject>>
            
            if let comments = commentsArray {
                var comment = comments[indexPath.row - 1]
                
                var bodyObject: AnyObject? = comment["body"]
                var body = bodyObject as String?
                cell.comment.text = body
                
                var userInfo: AnyObject? = comment["user"]
                var user = userInfo as Dictionary<String, AnyObject>
                
                var nameObject: AnyObject? = user["login"]
                var name = nameObject as String?
                cell.name.text = name
                
                var avatarObject: AnyObject? = user["avatar_url"]
                var avatar = avatarObject as String?
                if let logo_url = avatar {
                    cell.avatar.sd_setImageWithURL(NSURL(string: logo_url), placeholderImage: UIImage(named: "user.png"))
                }
            }
        }
        
        return cell
    }
    
    func setHeaderHeight() -> CGFloat {
        if self.tableData == nil {
            return 0
        }
        var width = UIScreen.mainScreen().applicationFrame.size.width - 34
        
        var titleObject: AnyObject? = self.tableData?["title"]
        var title = titleObject as NSString?
        var titleattributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 15 )]
        var titleRect = title?.boundingRectWithSize(CGSize(width: width, height: 10000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: titleattributes, context: nil)
        var titleHeight = titleRect?.height as CGFloat!
        
        var bodyObject: AnyObject? = self.tableData?["body"]
        var body = bodyObject as NSString?
        var bodyattributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 14 )]
        var bodyRect = body?.boundingRectWithSize(CGSize(width: width, height: 10000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: bodyattributes, context: nil)
        var bodyHeight = bodyRect?.height as CGFloat!
        
        return titleHeight + bodyHeight + 64
    }
    
    func setCommentHeight(indexPath: NSIndexPath) -> CGFloat {
        
        if self.tableData == nil {
            return 0
        }
        var width = UIScreen.mainScreen().applicationFrame.size.width - 31
        
        if let dataHash = self.tableData {
            var commentsObject: AnyObject? = dataHash["replies"]
            var commentsArray = commentsObject as? Array<Dictionary<String, AnyObject>>
            
            if let comments = commentsArray {
                var comment = comments[indexPath.row - 1]
                
                var bodyObject: AnyObject? = comment["body"]
                var body = bodyObject as String?
                
                var bodyattributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 14 )]
                var bodyRect = body?.boundingRectWithSize(CGSize(width: width, height: 10000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: bodyattributes, context: nil)
                var bodyHeight = bodyRect?.height as CGFloat!
                
                return bodyHeight + 60
            }
        }
        
        return 105
    }
}
