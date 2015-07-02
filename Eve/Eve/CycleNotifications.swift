//
//  CycleNotifications.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 29/06/15.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import Foundation
import UIKit

class CycleNotifications
{
    class var sharedInstance: CycleNotifications
    {
        struct Static
        {
            static let instance : CycleNotifications = CycleNotifications()
        }
        return Static.instance
    }

    
    let savedInformationManager = SavedDataManager.sharedInstance
    
    var includeMenstruationNotifications: Bool
    var includeOvulationNotifications: Bool
    var includeCautionNotifications: Bool
    var notificationDates: [CycleDate]
    
    var menstruationDates: [CycleDate]!
    var ovulationDates: [CycleDate]!
    var cautionDates: [CycleDate]!
    
    
    
    init()
    {
        self.includeMenstruationNotifications = false
        self.includeOvulationNotifications = true
        self.includeCautionNotifications = true
        
        self.notificationDates = [CycleDate]()
    }
    
    
    
    // get saved information
    func loadNotificationSettings()
    {
        if let includeMenstruationDates = self.savedInformationManager.defaults.objectForKey("menstruationBool") as? Bool
        {
            self.includeMenstruationNotifications = self.savedInformationManager.defaults.boolForKey("menstruationBool")
            println("MENS =\(self.includeMenstruationNotifications)")
            
        }
        
        if let includeOvulationDates = self.savedInformationManager.defaults.objectForKey("ovulationBool") as? Bool
        {
            self.includeOvulationNotifications = self.savedInformationManager.defaults.boolForKey("ovulationBool")
            println("OVU = \(self.includeOvulationNotifications)")

        }
        
        if let includeCautionNotifications = self.savedInformationManager.defaults.objectForKey("cautionBool") as? Bool
        {
            self.includeCautionNotifications = self.savedInformationManager.defaults.boolForKey("cautionBool")
            println("CAUT \(self.includeCautionNotifications)")

        }
        
        if let notificationDates: NSData = self.savedInformationManager.defaults.objectForKey("notificationDates") as? NSData
        {
            let encodedNotificationDates = self.savedInformationManager.defaults.objectForKey("notificationDates") as! NSData
            
            self.notificationDates = NSKeyedUnarchiver.unarchiveObjectWithData(encodedNotificationDates) as! [CycleDate]
        }
    }
    
    
    // sort which dates to include and then schedlue them. save the remaining dates
    func scheduleCycleNotifications(menstruationDates: [CycleDate], ovulationDates: [CycleDate], cautionDates: [CycleDate])
    {
        self.notificationDates = [CycleDate]()
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        if includeMenstruationNotifications
        {
            notificationDates += menstruationDates
        }
        
        if includeOvulationNotifications
        {
            notificationDates += ovulationDates
        }
        
        if includeCautionNotifications
        {
            notificationDates += cautionDates
        }
        
        self.notificationDates = self.sortNotificationDates(notificationDates)
        var counter = 0
        
        for notificationDate in notificationDates
        {
            if counter < 64
            {
                scheduleANotification(notificationDate)
                notificationDates = notificationDates.filter({$0.date != notificationDate.date })
                counter++
            }
        }
        
        println("DID SCHEDULE NOTIFICATION")
        
        println("SHEDULED NOTIFICATIONS =")
        println(UIApplication.sharedApplication().scheduledLocalNotifications.count)

    }

    
    func sortNotificationDates(var datesToSort: [CycleDate]) -> [CycleDate]
    {
        var sortedDates = datesToSort.sorted({ $0.date.compare($1.date) == NSComparisonResult.OrderedAscending })
        return sortedDates
    }
    
    
    func scheduleANotification(date: CycleDate)
    {
        var notification = UILocalNotification()
        notification.alertBody = self.getAlertBodyText(date)
        notification.alertAction = "open"
        notification.fireDate = date.date
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.category = "EVE_CATEGORY"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    
    func getAlertBodyText(alertDate: CycleDate) -> String
    {
        var bodyText = ""

        if alertDate.type == "menstruation"
        {
            bodyText = "MENSTRUATION DAY! It's not the most pleasant time of the month, but at least your changes of getting pregnant is pretty much zitch to non! Good luck with the cramps."
        }
        else if alertDate.type == "caution"
        {
            bodyText = "CAUTION DAY! It's time to watch out and be safe. If can't resist just think of crying babies, dirty nappies and no alcohol for 9 months. Have a great day!"
        }
        else if alertDate.type == "ovulation"
        {
            bodyText = "OVULATION DAY! What ever you do today, be safe!"
        }
        return bodyText
    }
    
    
    func refreshNotifications()
    {
        if let encodedNotificationDates = savedInformationManager.defaults.objectForKey("notificationdates") as? NSData
        {
            let encodedNotificationDates = savedInformationManager.defaults.objectForKey("notificationdates") as! NSData
            self.notificationDates = NSKeyedUnarchiver.unarchiveObjectWithData(encodedNotificationDates) as! [CycleDate]
        }
        
        if let newNotificationDate = notificationDates.first
        {
            while UIApplication.sharedApplication().scheduledLocalNotifications.count < 64
            {
                self.sortNotificationDates(notificationDates)
                let newNotificationDate = notificationDates.first!
                
                scheduleANotification(newNotificationDate)
            }
        }
        let encodedNotoficationDates = NSKeyedArchiver.archivedDataWithRootObject(notificationDates)
        savedInformationManager.defaults.setObject(encodedNotoficationDates, forKey: "notificationdates")
    }
    
    
    func saveNotificationSettings()
    {
        savedInformationManager.defaults.setBool(self.includeMenstruationNotifications, forKey: "menstruationBool")
        savedInformationManager.defaults.setBool(self.includeOvulationNotifications, forKey: "ovulationBool")
        savedInformationManager.defaults.setBool(self.includeCautionNotifications, forKey: "cautionBool")
    
        let encodedNotoficationDates = NSKeyedArchiver.archivedDataWithRootObject(notificationDates)
        savedInformationManager.defaults.setObject(encodedNotoficationDates, forKey: "notificationdates")
        
        println("SAVE")
    }
}
