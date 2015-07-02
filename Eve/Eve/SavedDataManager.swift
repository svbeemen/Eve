//
//  SaveData.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 24/06/15.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.


import Foundation
import UIKit

class SavedDataManager
{
    class var sharedInstance : SavedDataManager
    {
        struct Static
        {
            static let instance : SavedDataManager = SavedDataManager()
        }
        return Static.instance
    }
    
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    private let ALERTDATE_KEY = "alertDates"
    
    private let PAST_KEY = "pastCycleDates"
    
    private let PREDICTED_KEY = "predictedCycleDates"
    
    private let SETTINGS_KEY = "userSettings"
    
    private let PASTMENSTRUATIONS_KEY = "pastMenstruationDates"
    
    
    // PREDICTED CYCLE DATES
    // save predicted cycle dates
    func savePredictedCycleDates(predictedCycleDates: [CycleDate])
    {
        let myData = NSKeyedArchiver.archivedDataWithRootObject(predictedCycleDates)
        defaults.setObject(myData, forKey: PREDICTED_KEY)
    }
    
    
    // get saved predicted cycle dates or return empty array
    func getPredictedCycleDates() -> [CycleDate]
    {
        if let savedDated: NSData = defaults.objectForKey(PREDICTED_KEY) as? NSData
        {
            let savedDated: NSData = defaults.objectForKey(PREDICTED_KEY) as! NSData
            let myData = NSKeyedUnarchiver.unarchiveObjectWithData(savedDated) as! [CycleDate]
            return myData
        }
        
        return [CycleDate]()
    }

    
    // PAST CYCLE DATES
    // save past cycle dates
    func savePastCycleDates(pastCycleDates: [CycleDate])
    {
        let myData = NSKeyedArchiver.archivedDataWithRootObject(pastCycleDates)
        defaults.setObject(myData, forKey: PAST_KEY)
    }
    
    // get saved past cycle dates or return empty array
    func getPastCycleDates() -> [CycleDate]
    {
        if let savedDated: NSData = defaults.objectForKey(PAST_KEY) as? NSData
        {
            let savedDated: NSData = defaults.objectForKey(PAST_KEY) as! NSData
            let myData = NSKeyedUnarchiver.unarchiveObjectWithData(savedDated) as! [CycleDate]
            return myData
        }
        return [CycleDate]()
    }
    
    
    // PAST MENSTRUATIONDATES
    // save past menstruation date
    func savePastMenstruationDates(pastMenstruationDates: [CycleDate])
    {
        let myData = NSKeyedArchiver.archivedDataWithRootObject(pastMenstruationDates)
        defaults.setObject(myData, forKey: PASTMENSTRUATIONS_KEY)
    }
    
    // get past menstruation dates or return empty array
    func getPastMenstruationDates() -> [CycleDate]
    {
        if let savedDated: NSData = defaults.objectForKey(PASTMENSTRUATIONS_KEY) as? NSData
        {
            let savedDated: NSData = defaults.objectForKey(PASTMENSTRUATIONS_KEY) as! NSData
            let myData = NSKeyedUnarchiver.unarchiveObjectWithData(savedDated) as! [CycleDate]
            return myData
        }
        return [CycleDate]()
    }
}

