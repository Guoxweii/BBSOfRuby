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
    var tableData: Topic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "提问详情"

        let headerName = "TopicHeaderCell"
        let nib = UINib(nibName: headerName, bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: headerName)
        
        let commentName = "CommentCell"
        let commentNib = UINib(nibName: commentName, bundle: nil)
        self.tableView.registerNib(commentNib, forCellReuseIdentifier: commentName)
        
        Topic.find(self.topicId, success: { (responseBody: AnyObject!) -> Void in
            self.tableData = responseBody as? Topic
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let topic = self.tableData {
            return topic.comments.count + 1
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
        
        if let topic = self.tableData {
            cell.title.text = topic.title?
            cell.body.text = topic.body?
        }
        return cell
    }
    
    func createCommentCell(indexPath: NSIndexPath) -> UITableViewCell! {
        let commentName = "CommentCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(commentName, forIndexPath: indexPath) as CommentCell
        
        if let topic = self.tableData {
            var comments = topic.comments
            var comment = comments[indexPath.row - 1]
            
            cell.comment.text = comment.body
            cell.name.text = comment.name
            if let logo_url = comment.avatar {
                cell.avatar.sd_setImageWithURL(NSURL(string: logo_url), placeholderImage: UIImage(named: "user.png"))
            }
        }
        
        return cell
    }
    
    func setHeaderHeight() -> CGFloat {
        if self.tableData == nil {
            return 0
        }
        var topic = self.tableData
        var width = UIScreen.mainScreen().applicationFrame.size.width - 34
        
        var title = topic?.title
        var titleattributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 15 )]
        var titleRect = title?.boundingRectWithSize(CGSize(width: width, height: 10000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: titleattributes, context: nil)
        var titleHeight = titleRect?.height as CGFloat!
        
        var body = topic?.body
        var bodyattributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 14 )]
        var bodyRect = body?.boundingRectWithSize(CGSize(width: width, height: 10000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: bodyattributes, context: nil)
        var bodyHeight = bodyRect?.height as CGFloat!
        
        return titleHeight + bodyHeight + 75
    }
    
    func setCommentHeight(indexPath: NSIndexPath) -> CGFloat {
        
        if self.tableData == nil {
            return 0
        }
        var width = UIScreen.mainScreen().applicationFrame.size.width - 31
        
        if let topic = self.tableData {
            var comments = topic.comments
            var comment = comments[indexPath.row - 1]
            var body = comment.body
            
            var bodyattributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 14 )]
            var bodyRect = body?.boundingRectWithSize(CGSize(width: width, height: 10000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: bodyattributes, context: nil)
            var bodyHeight = bodyRect?.height as CGFloat!
            
            return bodyHeight + 60
        }
        
        return 105
    }
}
