//
//  CalendarClass.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 10/06/15 W24.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import Foundation

class Calendar
{
    var todayDate: NSDate
    
    var thisMonth: Int
    
    var currentCalendar : NSCalendar

    var numberDaysInYear = 0
    
    var firstDayOfMonthObject: NSDate
    
    var firstDayThisMonth: NSDateComponents
    
    var daysInCurrentYear: Int
    
    var monthValuesList: [NSArray]
    
    var dateList: [Int]
    
    var monthNameList: [AnyObject]
    
    var allDates = [NSArray]()
    
    
    init()
    {
        self.todayDate = NSDate()
        self.thisMonth = self.todayDate.daysInMonth()
        self.currentCalendar = NSCalendar.currentCalendar()
        self.firstDayThisMonth = NSDateComponents()
        self.firstDayThisMonth.day = 1
        self.firstDayOfMonthObject = currentCalendar.dateFromComponents(firstDayThisMonth)!
        self.daysInCurrentYear = todayDate.daysInYear()
        self.monthValuesList = []
        self.dateList = []
        self.monthNameList = self.currentCalendar.monthSymbols
    }
    
    
    func monthValues()
    {
        for index in 1...12
        {
            self.firstDayThisMonth.month = index
            self.firstDayOfMonthObject = currentCalendar.dateFromComponents(firstDayThisMonth)!
            var monthDays = self.firstDayOfMonthObject.daysInMonth()
            self.monthValuesList.append([index,monthDays])
        }
        
    }
    
  
    
    func dateValue()
    {
        for month in monthValuesList
        {
            println("monthObject= \(month)")
            var days: Int = month[1] as! Int
            println("days= \(days)")
            for var index = 1; index < days; ++index
            {
                dateList.append(index)
            }
        }
        println("dateList= \(dateList)")
        self.yearDates()
    }
    
    func yearDates()
    {
        var monthValue = 0
        
        for month in monthNameList
        {
            // the value of the month in NSCalendar
            monthValue += 1
            
            // create a NSDateComponents for the 1st for each month
            self.firstDayThisMonth.month = monthValue
            
            // create an NSDateObject for each month 
            var monthObject = currentCalendar.dateFromComponents(self.firstDayThisMonth)
            
            var amountDaysInMonth = monthObject?.daysInMonth()

            var datesInMonth = [Int]()
            
            for var index = 1; index <= amountDaysInMonth!; ++index
            {
                datesInMonth.append(index)
            }
            
            self.allDates.append([monthValue, datesInMonth])
        }
        println("datesInMonth = \(self.allDates)")
        
  
    }

}


