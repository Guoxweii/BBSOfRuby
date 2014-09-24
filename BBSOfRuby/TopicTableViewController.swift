//
//  TopicTableViewController.swift
//  BBSOfRuby
//
//  Created by gxw on 14/9/24.
//  Copyright (c) 2014年 gxw. All rights reserved.
//

import UIKit

class TopicTableViewController: UITableViewController {
    
    var tableData: Array<Dictionary<String,AnyObject>>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "精华贴"
        
        self.tableData = nil
        
        let baseName = "TopicCell"
        let nib = UINib(nibName: baseName, bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: baseName)
        
        let url = NSURL(string: "https://ruby-china.org/api/topics.json")
        var request = NSURLRequest(URL: url)
        var operation = AFHTTPRequestOperation(request: request)
        operation.responseSerializer = AFJSONResponseSerializer()
        operation.setCompletionBlockWithSuccess(
            { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) -> Void in
                self.tableData = responseObject as? Array<Dictionary<String, AnyObject>>
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
        return (self.tableData? != nil) ? self.tableData!.count : 0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 105
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let baseName = "TopicCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(baseName, forIndexPath: indexPath) as TopicCell
        if let dataArray = self.tableData {
            var data = dataArray[indexPath.row]
            
            var titleObject: AnyObject? = data["title"]
            var title = titleObject as String?
            cell.title.text = title?
            
            var createdAtObject: AnyObject? = data["created_at"]
            var created_at = createdAtObject as String?
            cell.createTime.text = created_at?
            
            var reliesCountObject: AnyObject? = data["replies_count"]
            var replies_count = reliesCountObject as Int!
            cell.replyNumber.text = "\(replies_count)"
            
            var userInfo: AnyObject? = data["user"]
            var userDic = userInfo as Dictionary<String, AnyObject>
            var nameObject: AnyObject? = userDic["login"]
            var name = nameObject as String?
            cell.name.text = name
            
            var avatarObject: AnyObject? = userDic["avatar_url"]
            var avatar = avatarObject as String?
        }
        
        return cell
    }
    
}