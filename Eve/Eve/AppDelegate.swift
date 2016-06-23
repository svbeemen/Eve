//
//  AppDelegate.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 10/06/15 W24.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        let savedDates = SavedDataManager.sharedInstance.getPastMenstruationDates()
        if !savedDates.isEmpty
        {
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewControllerWithIdentifier("userCalendar")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()

        }
        else
        {
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewControllerWithIdentifier("emptyCalendar")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
                
        }

        // Register app for local notifications and specify type of notifications
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        application.registerUserNotificationSettings(settings)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication)
    {

    }

    func applicationDidEnterBackground(application: UIApplication)
    {

    }

    func applicationWillEnterForeground(application: UIApplication)
    {
        
    }

    func applicationDidBecomeActive(application: UIApplication)
    {
        NSNotificationCenter.defaultCenter().postNotificationName("CycleNotificationsShouldRefresh", object: self)
    }

    func applicationWillTerminate(application: UIApplication)
    {
        
    }
    
    // Receive a notification that a cycleNotification has been fired. Send notification in app.
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification)
    {
        NSNotificationCenter.defaultCenter().postNotificationName("CycleNotificationsShouldRefresh", object: self)
    }
}

