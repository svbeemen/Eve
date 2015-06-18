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
    
    
    // adds selected date to menstruation array
    func setMenstruationDate(selectedDate: NSDate)
    {
        self.menstruationDates.append(selectedDate)

        self.sortMenstruationDates()
        
        println("mentstruation date = \(self.menstruationDates)")
    }
    
    
    // removes nsdate from array when deselected in calnedarview
    func removeMenstruationDate(unselectedDates: NSDate)
    {
        self.menstruationDates  = self.menstruationDates.filter( {$0 != unselectedDates})
        
        self.sortMenstruationDates()
        
        self.calculateMenstruation()
        
        println("mentstruation date = \(self.menstruationDates)")
    }
    
    // sort dates
    func sortMenstruationDates()
    {
        self.menstruationDates.sort({ $0.day() < $1.day() })
        self.menstruationDates.sort({ $0.month() < $1.month() })
        self.menstruationDates.sort({ $0.year() < $1.year() })
    }
    
    
    
    
    func calculateMenstruation() -> [(NSDate, NSDate)]
    {   // working progress
        
        var listIsCopyOfOrignal = self.menstruationDates
        
        var listWithOutFirstElement = listIsCopyOfOrignal.removeAtIndex(0)
        
        var listForNextDAteObject = listIsCopyOfOrignal.generate()
        
        var listToEnumarate = self.menstruationDates
        
        
        var startEndDatesPeriods = [NSDate:NSDate]()
        
        
        var startDate = listToEnumarate[0]
        
        for (index, value) in enumerate(listToEnumarate)
        {
            if let nextDate = listForNextDAteObject.next()
            {
                println("INDEX = \(index)")
                println("VALUE = \(value)")
                println("NEXT DATE \(nextDate)")
                
                println("date difference = \(nextDate.daysFrom(value))")
                if nextDate.daysFrom(value) != 1
                {
                    var endDate = value
                    
                    startEndDatesPeriods[startDate] = endDate
                    
                    println("START DATE = \(startDate)")
                    println("END DATE = \(endDate)")
                    
                    println("NEXTDATE new START DATE = \(nextDate)")
                    
                    startDate = nextDate
                    

                }
            }
            else
            {
                var endDate = value
                startEndDatesPeriods[startDate] = endDate
            }
        }
        
        println("MENSTRUATIONDATES ORIGINAL = \(self.menstruationDates)")
        println("START END DATES  = \(startEndDatesPeriods)")
        
        var test = sorted(startEndDatesPeriods) { $0.0 < $1.0 }
        
        println("TEST REORDER DIC = \(test)")
        
        calculateFertileDays(test)
        
        return test
    }
    
    
    func calculateFertileDays(var periods: [(NSDate, NSDate)])
    {
        
        var (startLastPeriod, endLastPeriod) = periods.last!
        
        var startDateNextPeriod = endLastPeriod.dateByAddingDays(28)
        
        var startDateFertilePeriod = endLastPeriod.dateByAddingDays(11)
        
        var endDateFertilePeriod = startDateFertilePeriod.dateByAddingDays(5)
        

        
        
    
        var periodListEnumarate = periods
        
        var totalDaysBetweenPeriods = 0
//       
        periods.removeAtIndex(0)
        
        var nextPeriod = periods.generate()
        
        
        
        
        for (start, end) in periodListEnumarate
        {
            println("START = \(start)")
            println("END = \(end)")
            if let nextDateStartEnd = nextPeriod.next()
            {
                println("NEXT PERIOD>NEXT = \(nextDateStartEnd)")
                println("NEXT START \(nextDateStartEnd.0)")
                println("NEXT END \(nextDateStartEnd.1)")
                
                
                var daysBetweenPeriod = nextDateStartEnd.0.daysFrom(end)
                totalDaysBetweenPeriods += daysBetweenPeriod
                
                println("DAYS BETWEEN @ PERIODS = \(daysBetweenPeriod)")
            }

        }
        
        println("days of period total = \(totalDaysBetweenPeriods)")
        
    
    }
    
        
    
//        
//        var startEndDatesPeriods = [NSDate:NSDate]()
//        
//        var listOfPeriodDates = self.menstruationDates
//        
//        var listOfPeriodDatesMutate = self.menstruationDates.removeAtIndex(0)
//        
//        
//        
//        var firstStartDate: NSDate = listOfPeriodDates[0]
//        
//        for (indexItem, dateItem) in enumerate(listOfPeriodDates)
//        {
//            while let nextDate = listOfPeriodDatesMutate.next()
//            {
//                println("NEXTDATE =\(nextDate)")
//                println("dateITme =\(dateItem)")
//                println("item index \(indexItem)")
//                
//                println("days from this day = \(nextDate.daysFrom(dateItem))")
//                
//                if nextDate.daysFrom(dateItem) != 1 || nextDate.daysFrom(dateItem) != 0
//                {
//                    
//                    println("make start end")
//                    var startDate: NSDate = firstStartDate
//                    var endDate = dateItem
//                    startEndDatesPeriods[startDate] = endDate
//                    
//                    listOfPeriodDates.re
//                    
//                    
//                }
//            }
//        }
//        
//        println("periodStartEND \(startEndDatesPeriods)")

        
        
        

//        var newList = self.menstruationDates.generate()
//
//        var onePeriod = [NSDate]()
//        
//        while let x = newList.next()
//        {
//            for (index, item) in enumerate(self.menstruationDates)
//            {
//                if item.daysFrom(x) == 1
//                {
//                    onePeriod.append(item)
//                }
//            }
//        }
//        
//
//        println("ONE PERIOD = \(onePeriod)")
//
    
//        
//        var lastIndex = self.menstruationDates.endIndex - 1
//        
//        for 1...lastIndex in self.menstrautionDates
//        {
//            
//        }
//        
//        for (index, value) in enumerate(self.menstruationDates)
//        {
//            if self.menstruationDates[index].day + 1 == self.menstruationDates[index+1]
//            {
//                newList.append(value)
//            }
//        }
//        
//        
//        
//        
//        for item in self.menstruationDates
//        {
//            var nextDay = item.dateByAddingDays(1)
//            newList.filter({$0 == nextDay})
//            
//        }
//        
//        println("newlist = \(newList)")
//    }
        
        
//        var newList = self.menstruationDates.filter({$0 > self.currentDate})
//        
//        ( {$0 < $1} )
//        self.menstruationDates<($0, $1)
//            {
//                
//        }
//        
//        @infix func < (let left:NSDate, let right: NSDate) -> Bool {
//            var result:NSComparisonResult = left.compare(right)
//            var isEarlier = false
//            if (result == NSComparisonResult.OrderedAscending) {
//                isEarlier = true
//            }
//            return isEarlier
//        }
//        
//        
//        var nextDays = [NSDate]()
//        for date in self.menstruationDates
//        {
//            var nextDay = date.dateByAddingDays(1)
//        }
//        
//        for date in menstruationDates
//        {
//            for nextDay in nextDays
//            {
////                self.menstruationDates.
//            }
//        }
//        
//        self.currentCalendar.
        
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
