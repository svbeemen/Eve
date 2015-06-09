//
//  CalendarInfoClass.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 09/06/15 W24.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import Foundation

import CVCalendarKit

class CalendarInfo
{
    var currentCalendar : NSCalendar
    
    var currentDate: NSDate
    
    let monthsNames: [AnyObject]

    let theFirstDayOfMonth: NSDate

    var monthObjects: [NSDate]
    
    var numberDaysInYear = 0
    
//    var nameMonth: Int
//    var lengthMonth:
    
    init()
    {
        self.currentCalendar = NSCalendar.currentCalendar()
        self.currentDate = NSDate()
        self.monthsNames = self.currentCalendar.monthSymbols
        self.theFirstDayOfMonth = self.currentDate.day == 1
        self.monthObjects = []
    }
    
    
    // list of 1st of the month objects
    func monthDateObjects() -> [NSDate]
    {
        for index in 1...12
        {
            var monthobject = theFirstDayOfMonth.month == index
            self.monthObjects.append(monthobject)
        }
        return monthObjects
    }
    
    
    // days in year function
    func daysInYear() -> Int
    {
        for object in monthObjects
        {
            var daysInMonth = object.lastMonthDate()
            daysInMonth = daysInMonth.day
            numberDaysInYear += daysInMonth
        }
        return numberDaysInYear
    }
    
    
    var monthDictionary = [Int:Int]()
    
    func monthValues() -> [(Int,Int)]
    {
        for month in monthObjects
        {
            var monthDayValue = month.lastMonthDate().day
            var monthValue = month.month
            monthDictionary[monthValue] = monthDayValue
            //        var monthDic["monthValue"] = monthDayValue
            //        monthValuesList.append(monthDic)
        }
        
        var monthValuesList = sorted(monthDictionary) { $0.0 < $1.0 }
        return monthValuesList
    }
    
    
    func getMonthData()
    {
        // itirates through list of month names
        for index in self.monthsNames
        {
            // makes as NSDate object for the first of ever month that year
            var monthObject = self.theFirstDayOfMonth.month == Int(index as! NSNumber)
            
            // with new monthobject finds the length of the month year
            var monthLength = monthObject.lastMonthDate()
            
            // adds the monthnames as key and the monthlength as value to a dictionary 
            self.monthData[monthObject] = monthLength
        }
    }

    
    

    
    // list of 1st of the month objects
    func monthDateObjects() -> [NSDate]
    {
        for index in 1...12
        {
            var monthobject = theFirstDayOfMonth.month == index
            monthObjects.append(monthobject)
        }
        return monthObjects
    }
    
    var viewList = monthDateObjects()
    
    

    
    var view = daysInYear()
    
    //var monthValuesList = []

    
    var showMe = monthValues()
    var rangeList = [Int]()
    
    func getRange() -> [Int]
    {
        for (hello, world) in showMe
        {
            var range = world
            rangeList.append(range)
        }
        return rangeList
    }
    
    
    
    var showRange = getRange()

//    func todayDate() -> NSDate
//    {
//        self.currentDate = NSDate()
//        return self.currentDate
//    }
//    
//    func monthData(months: [Int])
//    {
//        for index in months
//        {
//            var monthObject = self.theFirstDayOfMonth.month == index
//            var monthDays = monthObject.lastMonthDate()
//            self.monthInfo.append(monthObject)
//        }
//    }
//    
}
