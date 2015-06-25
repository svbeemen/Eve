//
//  CalendarClass.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 23/06/15.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import Foundation


class CalendarClass
{
    var currentDate: NSDate

    var currentCalendar: NSCalendar

    var monthNames: [AnyObject]

    
    var selectedDates: [NSDate]

//
    var cycleManager: MenstruationCycle



    var firstCalendarDate: NSDate!

    var lastCalendarDate: NSDate!
    
    var previousMenstruationDates: [NSDate]!
    var previousFertileDate: [NSDate]!
    
    var menstruation: MenstrualCycle



    init()
    {
        self.currentDate = NSDate()

        self.currentCalendar = NSCalendar.currentCalendar()

        self.monthNames = self.currentCalendar.monthSymbols
        
        
        self.selectedDates = [NSDate]()

        self.cycleManager = MenstruationCycle()
        
        
        self.menstruation = MenstrualCycle(currentDate: self.currentDate)

//
//        if let selectedDates = savedSettings.objectForKey("setDates") as? [NSDate]
//        {
//            self.selectedDates = savedSettings.objectForKey("setDates") as! [NSDate]
//        }
//        else
//        {
//            self.selectedDates = [NSDate]()
//        }

    }
    



    // function to get dateobjects Start en end to show in calendar view
    func getYearDates() -> [NSDate]
    {
        var yearDateObjects = [NSDate]()

        var firstDateThisMonth = self.currentDate.firstYearDate()

        var firstYearFirstDay = firstDateThisMonth.dateBySubtractingYears(1)
        yearDateObjects.append(firstYearFirstDay)

        var secondYearFirstDay = firstDateThisMonth
        yearDateObjects.append(secondYearFirstDay)

        var thirdYearFirstDay = firstDateThisMonth.dateByAddingYears(1)
        yearDateObjects.append(thirdYearFirstDay)
        
        return yearDateObjects

    }


    // function to get date objects for days in years
    func getDates() -> [[NSDate]]
    {
        var yearsList = self.getYearDates()

        var dates = [[NSDate]]()

        var days = 0

        // for every year in the year list TOTAL IS 3
        for year in yearsList
        {
//            var datesInYear = [NSDate]()

            // in every year there are 12 months
            var monthsInYear = self.monthNames.count


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

                dates.append(datesInMonth)

            }

        }



        self.firstCalendarDate = dates[0].first

        if let lastCalanderDate = dates.last?.last
        {
            self.lastCalendarDate = dates.last?.last
            self.lastCalendarDate.compare(self.firstCalendarDate)
        }


        var test = NSDate()
        println("comapre = \(test.compare(lastCalendarDate))")
    
        
        println("testing = \(self.lastCalendarDate.compare(self.firstCalendarDate))")
        
        return dates
    }

    
    
    func calculateValues()
    {
        cycleManager.getLengthOfMenstruation()
        cycleManager.getLengthOfPeriodBetweenMenstruations()
        
        cycleManager.getPredictedMenstruations(self.lastCalendarDate)
        cycleManager.getPredictedFertileDate(self.lastCalendarDate)

        
        println("IN CALCULATE lenghtOfMen =  \(cycleManager.lengthOfMenstruation)")
        println("IN CALCULATE period between nelgth =  \(cycleManager.lengthOfPeriodBetweeMenstraution)")
        println("IN CALCULATE predicted dates  =  \(cycleManager.predictedMenstrautionDates)")

        println("IN CALCULATE fertile predicted dates =  \(cycleManager.predictedFertileDates)")
        println("IN CALCULATE past men dates  =  \(cycleManager.pastMenstruationDates)")
        println("IN CALCULATE predicted start end dates men  =  \(cycleManager.predictedMenstrautionStartEndDates)")
        



    }
    

    // adds and deletes selected date to menstruation array
    func setSelectedDate(selectedDate: NSDate)
    {
        
        if contains(self.selectedDates, selectedDate)
        {
            self.selectedDates = self.selectedDates.filter( {$0 != selectedDate} )
        }
        else
        {
            self.selectedDates.append(selectedDate)
        }
        
        self.selectedDates.sort({$0 < $1})
        
        if contains(selectedDates, selectedDate.dateByAddingMinutes(3))
        {
                    println("yesy")
        }
        

    }
    
    
    

//        self.selectedDates.append(selectedDate)
//        
//        println(" selected dates before sort = \(self.selectedDates)")
//
////
////        self.sortMenstruationDates()
//        
//        self.menstruation.sortDates(self.selectedDates)
//        println(" selected dates after old sort sort = \(self.selectedDates)")
//        
//        var newSort = self.menstruation.sortDates(self.selectedDates)
//        
//        println(" new sort = \(newSort)")
//
//        self.cycleManager.setMenstruationDate(selectedDate)
//
//        println("mentstruation date = \(self.selectedDates)")
//    }

}


extension NSDate{
    typealias MyDateRange = (year: Int, month: Int, day: Int)
    
    func myDateRange() -> MyDateRange
    {
        let calendar = NSCalendar.currentCalendar()
        
        let comps = calendar.allComponentsFromDate(self)
        
        return (comps.year, comps.month, comps.day)
    }
    
    typealias myString = String

    
}


