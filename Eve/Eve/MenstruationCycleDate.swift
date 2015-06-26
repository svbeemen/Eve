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
    var UUID: NSString
    
    var shouldAlert: Bool {
        return NSCalendar.currentCalendar().isDateInToday(self.date) // deadline is earlier than current date
    }
    
    
    init(date: NSDate)
    {
        self.date = date
        self.type = ""
        self.UUID = ""
        

    }
}



