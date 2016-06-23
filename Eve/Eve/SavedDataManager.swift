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
    private let PAST_KEY = "pastCycleDates"
    private let PREDICTED_KEY = "predictedCycleDates"
    private let PASTMENSTRUATIONS_KEY = "pastMenstruationDates"
    
    // Save predicted cycle dates
    func savePredictedCycleDates(predictedCycleDates: [CycleDate])
    {
        let myData = NSKeyedArchiver.archivedDataWithRootObject(predictedCycleDates)
        defaults.setObject(myData, forKey: PREDICTED_KEY)
    }
    
    // Retrieve saved predicted cycle dates or return empty array if their are no saved dates.
    func getPredictedCycleDates() -> [CycleDate]
    {
        if (defaults.objectForKey(PREDICTED_KEY) as? NSData) != nil
        {
            let savedDated: NSData = defaults.objectForKey(PREDICTED_KEY) as! NSData
            let myData = NSKeyedUnarchiver.unarchiveObjectWithData(savedDated) as! [CycleDate]
            return myData
        }
        
        return [CycleDate]()
    }

    // Save past cycle dates.
    func savePastCycleDates(pastCycleDates: [CycleDate])
    {
        let myData = NSKeyedArchiver.archivedDataWithRootObject(pastCycleDates)
        defaults.setObject(myData, forKey: PAST_KEY)
    }
    
    // Retrieve saved past cycle dates or return empty array if their are no saved dates.
    func getPastCycleDates() -> [CycleDate]
    {
        if (defaults.objectForKey(PAST_KEY) as? NSData) != nil
        {
            let savedDated: NSData = defaults.objectForKey(PAST_KEY) as! NSData
            let myData = NSKeyedUnarchiver.unarchiveObjectWithData(savedDated) as! [CycleDate]
            return myData
        }
        return [CycleDate]()
    }
    
    // Save past menstruation date
    func savePastMenstruationDates(pastMenstruationDates: [CycleDate])
    {
        let myData = NSKeyedArchiver.archivedDataWithRootObject(pastMenstruationDates)
        defaults.setObject(myData, forKey: PASTMENSTRUATIONS_KEY)
    }
    
    // Retrieve past menstruation dates or return empty array if their are no saved dates.
    func getPastMenstruationDates() -> [CycleDate]
    {
        if (defaults.objectForKey(PASTMENSTRUATIONS_KEY) as? NSData) != nil
        {
            let savedDated: NSData = defaults.objectForKey(PASTMENSTRUATIONS_KEY) as! NSData
            let myData = NSKeyedUnarchiver.unarchiveObjectWithData(savedDated) as! [CycleDate]
            return myData
        }
        return [CycleDate]()
    }
}

