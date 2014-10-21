//
//  AppDelegate.swift
//  BBSOfRuby
//
//  Created by gxw on 14/9/23.
//  Copyright (c) 2014年 gxw. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.whiteColor()
        self.setDefaultSetting()
        self.window!.rootViewController = ApplicationController();
        self.window!.makeKeyAndVisible()
        
        return true
    }
    
    func setDefaultSetting() {
        UITabBar.appearance().barTintColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1)
        
        let font: UIFont! = UIFont(name: "Helvetica", size: 12.0)
        let selectedAttributes: NSDictionary! = [NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor(red:0.13, green:0.55, blue:0.83, alpha:1.0)]
        
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, forState: UIControlState.Normal)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

