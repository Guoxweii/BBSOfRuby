//
//  TopicTableViewController.swift
//  BBSOfRuby
//
//  Created by gxw on 14/9/24.
//  Copyright (c) 2014年 gxw. All rights reserved.
//

import UIKit

class TopicTableViewController: UITableViewController {
    
    @IBOutlet var refreshButton: UIButton!
    var tableData: Array<Topic>?
    
    @IBAction func refresh(sender: UIButton) {
        self.refreshDataFromApi()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "精华贴"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.refreshButton!)
        
        self.tableData = nil
        
        let baseName = "TopicCell"
        let nib = UINib(nibName: baseName, bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: baseName)
        
        self.refreshDataFromApi()
    }
    
    func refreshDataFromApi() {
        Topic.list({ (responseObject: AnyObject!) -> Void in
            self.tableData = responseObject as? Array<Topic>
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
        return (self.tableData? != nil) ? self.tableData!.count : 0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let dataArray = self.tableData {
            var topic = dataArray[indexPath.row]
            var title = topic.title
            
            var attributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 15 )]
            var width = UIScreen.mainScreen().applicationFrame.size.width - 42//TODO 需重写
            
            var rect = title?.boundingRectWithSize(CGSize(width: width, height: 105), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)

            if(rect?.height < 34) {
                return 87
            }
        }
        return 105
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let baseName = "TopicCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(baseName, forIndexPath: indexPath) as TopicCell
        if let dataArray = self.tableData {
            var topic = dataArray[indexPath.row] as Topic
            
            cell.title.text = topic.title
            cell.createTime.text = topic.created_at
            cell.replyNumber.text = "\(topic.replies_count!)"
            cell.name.text = topic.name
            if let avatar_url = topic.avatar {
                cell.avatar.sd_setImageWithURL(NSURL(string: avatar_url), placeholderImage: UIImage(named: "user.png"))
            }
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var commentListCtr = CommentListViewController(nibName: "CommentListViewController", bundle: nil)
        
        if let dataArray = self.tableData {
             var topic = dataArray[indexPath.row]
            commentListCtr.topicId = topic.id
        }
        
        self.navigationController?.pushViewController(commentListCtr, animated: true)
    }
    
}