//
//  dateStruct.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 15/06/15 W25.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import Foundation

class newCalendarManager
{
    var currentDate: NSDate
    
    var currentCalendar: NSCalendar
    
    var monthNames: [AnyObject]
    
    var menstruationDates: [NSDate]
    
    
    
    init()
    {
        self.currentDate = NSDate()
        
        self.currentCalendar = NSCalendar.currentCalendar()
        
        self.monthNames = self.currentCalendar.monthSymbols
        
        self.menstruationDates = [NSDate]()
    }
    
    
    // function to get dateobjects Start en end to show in calendar view
    func yearsToView() -> [NSDate]
    {
        var yearsToShow = [NSDate]()
        
        var firstDateThisMonth = self.currentDate.firstYearDate()
        
        var firstYearFirstDay = firstDateThisMonth.dateBySubtractingYears(1)
        yearsToShow.append(firstYearFirstDay)
        
        var secondYearFirstDay = firstDateThisMonth
        yearsToShow.append(secondYearFirstDay)
        
        var thirdYearFirstDay = firstDateThisMonth.dateByAddingYears(1)
        yearsToShow.append(thirdYearFirstDay)
        
        println("new CalendarClass today = \(yearsToShow)")
        
        return yearsToShow
        
    }
    
    
    // function to get the month values of the years
    func getMonthValues(yearsList:[NSDate]) -> [[NSDate]]
    {
        var monthValuesForView = [[NSDate]]()
        
        var days = 0
        
        // for every year in the year list TOTAL IS 3
        for year in yearsList
        {
//            var datesInYear = [[NSDate]]()
            
            // in every year there are 12 months
            var monthsInYear = 12
            
            
            // for all 12 month in the year
            for var index = 0; index < monthsInYear; index++
            {
                
                // start with first month in year. go to next month after eacht loop
                var month = year.dateByAddingMonths(index)
                
                // for eacht month calculate amount of days in the month
                var daysInMonth = month.daysInMonth()
                
                // make a list to hold all the dateObjects for 1 month
                var datesInMonth = [NSDate]()
                
                // itterate through every day in a month
                for var index = 0; index < daysInMonth; index++
                {
                    // make a date object for every day in the month
                    var date = month.dateByAddingDays(index)
                    
                    // add the day dateObject to the month list
                    datesInMonth.append(date)
                }
                
                // add the monthlist to the big monthValuesList
                monthValuesForView.append(datesInMonth)
//                println("dates in Month = \(datesInMonth)")
//                
//                datesInYear.append(datesInMonth)
                
            }
            
//            
//            println("dates in year = \(datesInYear)")
//            monthValuesForView.append(datesInYear)
        }
        
        println("monthValueList = \(monthValuesForView)")
        
        return monthValuesForView
    }
    
    func setMenstruationDate(selectedDate: NSDate)
    {
        self.menstruationDates.append(selectedDate)

        self.sortMenstruationDates()
        
        println("mentstruation date = \(self.menstruationDates)")
    }
    
    
    func removeMenstruationDate(unselectedDates: NSDate)
    {
        self.menstruationDates  = self.menstruationDates.filter( {$0 != unselectedDates})
        
        self.sortMenstruationDates()
        
        self.calculateMenstruation()
        
        println("mentstruation date = \(self.menstruationDates)")
    }
    
    
    func sortMenstruationDates()
    {
        self.menstruationDates.sort({ $0.day() < $1.day() })
        self.menstruationDates.sort({ $0.month() < $1.month() })
        self.menstruationDates.sort({ $0.year() < $1.year() })
    }
    
    
    func calculateMenstruation()
    {   // working progress
//        var nextDayList = [NSDate]()
//        for date in self.menstruationDates
//        {
//            var nextDay = date.dateByAddingDays(1)
//            nextDayList.append(nextDay)
//        }
//        
//        var firstPeriod  = self.menstruationDates
//        self.menstruationDates.filter( {$0 != unselectedDates})
//        
//        
//        for index in 1...self.menstruationDates.count
//        {
//            var firstElement = self.menstruationDates[index].dateByAddingDays(1)
//            var secondElement = self.menstruationDates[index + 1]
//            
//            if firstElement != secondElement
//            {
//                var startDate = self.menstruationDates.first
//                var endDate = self.menstruationDates[index]
//                var lengthOfMenstruation = startDate?.daysFrom(endDate)
//                println("length period = \(lengthOfMenstruation)")
//            }
//        }
    }
}
