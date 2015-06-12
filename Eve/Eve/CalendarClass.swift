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
    
    var monthInView: NSDate
    
    
    var currentDayValue: Int
    var currentMonthValue: Int
    var currentYearValue: Int
    
    init()
    {
        self.todayDate = NSDate()
        
        self.thisMonth = self.todayDate.daysInMonth()
        
        self.currentCalendar = NSCalendar.currentCalendar()
        
        self.currentDayValue = self.todayDate.day()
        self.currentMonthValue = self.todayDate.month()
        self.currentYearValue = self.todayDate.year()
        
        self.firstDayThisMonth = NSDateComponents()
        
        self.firstDayThisMonth.day = 1
        self.firstDayThisMonth.month = self.currentMonthValue
        self.firstDayThisMonth.year = self.currentYearValue
        
        self.firstDayOfMonthObject = NSDate()
//        self.firstDayOfMonthObject = currentCalendar.dateFromComponents(self.firstDayThisMonth)!
        
        self.daysInCurrentYear = todayDate.daysInYear()
        self.monthValuesList = []
        self.dateList = []
        self.monthNameList = self.currentCalendar.monthSymbols
        self.monthInView = NSDate()
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
    
    func monthDays() -> [Int]
    {
        var monthValuesDays: [Int] = []
        
        for index in 1...12
        {
            self.firstDayThisMonth.month = index
            self.firstDayOfMonthObject = currentCalendar.dateFromComponents(firstDayThisMonth)!
            var monthDays = self.firstDayOfMonthObject.daysInMonth()
            monthValuesDays.append(monthDays)
        }
        
        return monthValuesDays
    }
    
    func makeFirstDayMonth()
    {
        self.firstDayOfMonthObject = self.currentCalendar.dateBySettingUnit(NSCalendarUnit.CalendarUnitDay, value: 1, ofDate: self.todayDate, options: NSCalendarOptions.MatchStrictly)!
    }
  
    
    func dateValue()
    {
        for month in monthValuesList
        {
            var days: Int = month[1] as! Int

            for var index = 1; index < days; ++index
            {
                dateList.append(index)
            }
        }

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
            var monthObject = self.currentCalendar.dateBySettingUnit(NSCalendarUnit.CalendarUnitDay, value: 1, ofDate: self.todayDate, options: NSCalendarOptions())
            
            var amountDaysInMonth = monthObject?.daysInMonth()

            var datesInMonth = [Int]()
            
            for var index = 1; index <= amountDaysInMonth!; ++index
            {
                datesInMonth.append(index)
            }
            
            self.allDates.append([monthValue, datesInMonth])
        }
    }

    
    func printValues()
    {
        
        self.makeFirstDayMonth()
        self.monthValues()
        println("monthvalues\(self.monthValuesList)")
        println("firstdayMonthObject DAY \(self.firstDayOfMonthObject.day())")
        println("firstdayMonthObject MONTH\(self.firstDayOfMonthObject.month())")
        println("firstdayMonthObject YEAR \(self.firstDayOfMonthObject.year())")
        println("today! \(self.todayDate)")
        println("today day \(self.todayDate.day())")
        println("today month \(self.todayDate.month())")
        println("today year \(self.todayDate.year())")
        
        println("firstdayMonthObject \(self.firstDayOfMonthObject)")
        
        println("CDV\(self.currentDayValue)")
        println("CDV\(self.currentMonthValue)")
        println("CDV\(self.currentYearValue)")
        
        println("new Object \(self.firstDayOfMonthObject)")
    }
}


