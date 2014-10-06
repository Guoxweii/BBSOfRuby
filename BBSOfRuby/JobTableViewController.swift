//
//  JobTableViewController.swift
//  BBSOfRuby
//
//  Created by gxw on 14/10/4.
//  Copyright (c) 2014年 gxw. All rights reserved.
//

import UIKit

class JobTableViewController: UITableViewController, EGORefreshTableHeaderDelegate {
    
    var refreshHeaderView: EGORefreshTableHeaderView!
    var reloading: Bool!
    var tableData: Array<Topic>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "招聘贴"
        
        self.reloading = false
        self.edgesForExtendedLayout = UIRectEdge.None;
        
        
        var screenHeight = self.tableView.frame.size.height
        var screenWidth = self.tableView.frame.width
        self.refreshHeaderView = EGORefreshTableHeaderView(frame: CGRectMake(0, -screenHeight, screenWidth, screenHeight))
        refreshHeaderView.delegate = self
        refreshHeaderView.refreshLastUpdatedDate()
        self.view.addSubview(self.refreshHeaderView)

        let baseName = "TopicCell"
        let nib = UINib(nibName: baseName, bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: baseName)
        
        refreshDataFromApi()
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
            var width = UIScreen.mainScreen().applicationFrame.size.width - 44//TODO 需重写
            
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
    
    func egoRefreshTableHeaderDidTriggerRefresh(view: EGORefreshTableHeaderView!) {
        self.reloading = true
        
        refreshDataFromApi()
    }
    
    func egoRefreshTableHeaderDataSourceIsLoading(view: EGORefreshTableHeaderView!) -> Bool {
        return reloading
    }
    
    func egoRefreshTableHeaderDataSourceLastUpdated(view: EGORefreshTableHeaderView!) -> NSDate! {
        return NSDate.date()
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        self.refreshHeaderView.egoRefreshScrollViewDidScroll(scrollView)
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.refreshHeaderView.egoRefreshScrollViewDidEndDragging(scrollView)
    }
    
    func refreshDataFromApi() {
        Job.list({ (responseObject: AnyObject!) -> Void in
            self.reloading = false;
            self.refreshHeaderView.egoRefreshScrollViewDataSourceDidFinishedLoading(self.tableView)
            
            self.tableData = responseObject as? Array<Topic>
            self.tableView.reloadData()
        })
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
