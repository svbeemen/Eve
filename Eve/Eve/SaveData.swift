//
//  SaveData.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 24/06/15.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.


import Foundation
import UIKit

//struct AlertDate {
//    var type: String
//    var date: NSDate
//    var UUID: String
//    
//    init(deadline: NSDate, title: String, UUID: String) {
//        self.date = deadline
//        self.type = title
//        self.UUID = UUID
//    }
//}
//


class Settings
{
    class var sharedInstance : Settings
    {
        struct Static
        {
            static let instance : Settings = Settings()
        }
        return Static.instance
    }
    
    let savedData = NSUserDefaults.standardUserDefaults()
    
    
    private let ALERTDATE_KEY = "alertDates"
    
    private let PAST_KEY = "pastCycleDates"
    
    private let PREDICTED_KEY = "predictedCycleDates"
    
    private let SETTINGS_KEY = "userSettings"
    
    
//    func refreshAlertDates(AlertDates: [CycleDate])
//    {
//        var alertDateDictionary = savedData.dictionaryForKey(ALERTDATE_KEY)
//        
//        if alertDateDictionary!.count >= 64
//        {
//            return
//        }
//        
//        while alertDateDictionary!.count <= 64
//        {
//            addAlertDate(<#item: CycleDate#>)
//        }
//    }
//    
    
    
    
    func addAlertDate(item: CycleDate)
    { // persist a representation of this todo item in NSUserDefaults
        
        var alertDateDictionary = savedData.dictionaryForKey(ALERTDATE_KEY) ?? Dictionary()
        // if todoItems hasn't been set in user defaults, initialize todoDictionary to an empty dictionary using nil-coalescing operator (??)
        
        if alertDateDictionary.count > 64
        {
            return
        }
        
        alertDateDictionary[item.UUID] = ["alertDate": item.date, "title": item.type, "UUID": item.UUID]
        // store NSData representation of todo item in dictionary with UUID as key
        
        savedData.setObject(alertDateDictionary, forKey: ALERTDATE_KEY)
        // save/overwrite todo item list
        
        // create a corresponding local notification
        var notification = UILocalNotification()
        
        notification.alertBody = "\(item.type)\" It's time to watch out and be safe. If can't resist just think of crying babies, dirty nappies and no alcohol for 9 months. Have a great day! "
        // text that will be displayed in the notification
        
        notification.alertAction = "open"
        // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        
        notification.fireDate = item.date
        // todo item due date (when notification will be fired)
        
        
        notification.soundName = UILocalNotificationDefaultSoundName
        // play default sound
        
        
        notification.userInfo = ["UUID": item.UUID, ]
        // assign a unique identifier to the notification so that we can retrieve it later
        
        
        notification.category = "EVE_CATEGORY"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    
    func savePastDates(pastDates: [CycleDate])
    {
        var pastDateObjects: Void = savedData.setObject(pastDates, forKey: PAST_KEY)
    }
    
    func savePredictedDates(predictedDates: [CycleDate])
    {
        var predictedDateObjects: Void = savedData.setObject(predictedDates, forKey: PREDICTED_KEY)
    }
    
    func getPastCycleDates() -> [CycleDate]
    {
        var pastDateObjects = savedData.objectForKey(PAST_KEY) as? [CycleDate] ?? [CycleDate]()
        return pastDateObjects
    }
    
    func getPredictedDateObjects() -> [CycleDate]
    {
        var predictedDateObjects = savedData.objectForKey(PREDICTED_KEY) as? [CycleDate] ?? [CycleDate]()
        return predictedDateObjects
    }
    
    
    
   //REMOVE A NOTIFICATION WHEN THE DATE GETS CHANGED. USSER SELECTS AND DESELECTS
//    func removeItem(item: TodoItem) {
//        for notification in UIApplication.sharedApplication().scheduledLocalNotifications as! [UILocalNotification] { // loop through notifications...
//            if (notification.userInfo!["UUID"] as! String == item.UUID) { // ...and cancel the notification that corresponds to this TodoItem instance (matched by UUID)
//                UIApplication.sharedApplication().cancelLocalNotification(notification) // there should be a maximum of one match on UUID
//                break
//            }
//        }
//        
//        if var todoItems = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) {
//            todoItems.removeValueForKey(item.UUID)
//            NSUserDefaults.standardUserDefaults().setObject(todoItems, forKey: ITEMS_KEY) // save/overwrite todo item list
//        }
//    }
}

