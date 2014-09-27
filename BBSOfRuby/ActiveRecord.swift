//
//  ActiveRecord.swift
//  BBSOfRuby
//
//  Created by gxw on 14/9/27.
//  Copyright (c) 2014年 gxw. All rights reserved.
//

/* function list

class func get(url: String) -> AnyObject! //sync

class func get(url: String, success: function() -> Void) -> Void //async

*/

import UIKit

class ActiveRecord: NSObject {
    class func get(url: String) -> AnyObject! {
        return "" //TODO
    }
    
    class func get(url: String, success: (AnyObject!) -> Void) -> Void {
        let url = NSURL(string: url)
        var request = NSURLRequest(URL: url)
        var operation = AFHTTPRequestOperation(request: request)
        operation.responseSerializer = AFJSONResponseSerializer()
        operation.setCompletionBlockWithSuccess(
            { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) -> Void in
                success(responseObject)
            },
            failure: {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("The Error Happen: \(error)")
            }
        )
        NSOperationQueue.mainQueue().addOperation(operation)
    }
}
