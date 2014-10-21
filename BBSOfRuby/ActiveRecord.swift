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
        let manager = AFHTTPRequestOperationManager()
        manager.GET(url,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                success(responseObject)
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
            }
        )
    }
}
