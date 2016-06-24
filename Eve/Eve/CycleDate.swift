//
//  MenstruationCycleDate.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 25/06/15.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import Foundation
import UIKit

class CycleDate: NSObject
{
    var type: NSString
    var date: NSDate

    init(date: NSDate)
    {
        self.date = date
        self.type = ""
    }
    
    required init(coder aDecoder: NSCoder)
    {
        self.date = aDecoder.decodeObjectForKey("date") as! NSDate
        self.type = aDecoder.decodeObjectForKey("type") as! NSString
    }
    
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(date, forKey: "date")
        aCoder.encodeObject(type, forKey: "type")
    }
    
    // NSObjectProtocol
    override func isEqual(object: AnyObject?) -> Bool
    {
        if let object = object as? CycleDate
        {
            return self.date == object.date && self.type == object.type
        }
        else
        {
            return false
        }
    }
}