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
    
    var calenderDates: [[CycleDate]]

    var selectedDates: [CycleDate]
    
    var menstruationCycle: MenstrualCycle!
    
    var firstCalendarDate: NSDate!
    
    var lastCalendarDate: NSDate!


    init()
    {
        self.currentDate = NSDate()

        self.currentCalendar = NSCalendar.currentCalendar()
        
        self.calenderDates = [[CycleDate]]()
        
        self.selectedDates = [CycleDate]()
        
        self.firstCalendarDate = self.currentDate.firstYearDate().dateBySubtractingYears(1)
        self.lastCalendarDate = self.currentDate.lastYearDate().dateByAddingYears(1)
        self.menstruationCycle = MenstrualCycle(currentDate: self.currentDate, endPredictionDate: self.lastCalendarDate)
    }

    
    func getDates()
    {
        var startCalendarDate = CycleDate(date: self.firstCalendarDate)
        var endCalendarDate = CycleDate(date: self.lastCalendarDate)
        self.calenderDates = [[CycleDate]]()
        
        println("LAST CALENDAR in get dates!!! DATE = \(self.lastCalendarDate)")

        while startCalendarDate.date.isEarlierThanOrEqualTo(endCalendarDate.date)
        {
            var daysInMonth = startCalendarDate.date.daysInMonth()
            var datesInMonth = [CycleDate]()

            for var index = 0; index < daysInMonth; index++
            {
                var date = CycleDate(date: startCalendarDate.date)
                datesInMonth.append(date)
        
                startCalendarDate.date = startCalendarDate.date.dateByAddingDays(1)
            }
            self.calenderDates.append(datesInMonth)
        }
    }


    // adds and deletes selected date to menstruation array
    func setSelectedDate(selectedDate: CycleDate)
    {
        if contains(self.selectedDates, selectedDate)
        {
            self.selectedDates = self.selectedDates.filter( {$0 != selectedDate} )
            selectedDate.type = ""
        }
        else
        {
            self.selectedDates.append(selectedDate)
            selectedDate.type = "menstruation"
        }
    }
    
    
    // call the calculate cycle function menstrualCycleClass
    // set the type date of the predicted dates to the calendar dates.
    func setDateTypes()
    {
        var datesTypes = self.menstruationCycle.predictedCycleDates + self.menstruationCycle.pastMenstruationDates + self.menstruationCycle.pastCycleDates

        // reset date type
        for months in calenderDates
        {
            for days in months
            {
                days.type = ""
            }
        }
        
        // set date type to cycle date if it is one
        for dates in datesTypes
        {
            for months in self.calenderDates
            {
                for calandardays in months
                {
                    if currentCalendar.isDate(dates.date, inSameDayAsDate: calandardays.date)
                    {
                        calandardays.type = dates.type
                    }
                }
            }
        }
        
        
        println("IN CALENDAR CLASS")
    }
    
//    
//    func resetDateTypes()
//    {
//        for months in calenderDates
//        {
//            for days in months
//            {
//                days.type = ""
//            }
//        }
//    }
//    
    
    // remove pased predicted dates to pastPredicted dates
    func refreshPastedDates()
    {
//        if self.menstruationCycle.predictedCycleDates.isEmpty
//        {
//            return
//        }
//        
//        menstruationCycle.predictedCycleDates = menstruationCycle.sortDates(self.menstruationCycle.predictedCycleDates)
//        
//        for cycleDates in self.menstruationCycle.predictedCycleDates
//        {
//            if cycleDates.date.is
//                
//                
//                cycleDates.date.isEarlierThan(self.currentDate)
//            {
//                self.menstruationCycle.pastCycleDates.append(cycleDates)
//                
//                if cycleDates.type == "menstruation"
//                {
//                    self.menstruationCycle.pastMenstruationDates.append(cycleDates)
//                }
//            }
//        }
//        
//        SavedDataManager.sharedInstance.savePastMenstruationDates(self.menstruationCycle.pastMenstruationDates)
//        SavedDataManager.sharedInstance.savePastCycleDates(self.menstruationCycle.pastCycleDates)
    }
    
    
//    func getNextYearDates() -> [[CycleDate]]
//    {
//        println("SATRT NEXT YEAR DATES last calendare date at start")
//        println(self.lastCalendarDate)
//    
//        var lastDate = self.lastCalendarDate
//        var startCalendarDate = CycleDate(date: lastDate.dateByAddingMonths(1))
//        var endCalendarDate = CycleDate(date: startCalendarDate.date.dateByAddingYears(1))
//        var nextYearsDates = [[CycleDate]]()
//        
//        println("LAST CALENDAR DATE = \(self.lastCalendarDate)")
//        
//  
//        
//        self.menstruationCycle = MenstrualCycle(currentDate: self.currentDate, endPredictionDate: self.lastCalendarDate)
//        self.menstruationCycle.calculateCycle()
//        self.setDateTypes()
//
//        
//        while startCalendarDate.date.isEarlierThanOrEqualTo(endCalendarDate.date)
//        {
//            var daysInMonth = startCalendarDate.date.daysInMonth()
//            var datesInMonth = [CycleDate]()
//            
//            for var index = 0; index < daysInMonth; index++
//            {
//                var date = CycleDate(date: startCalendarDate.date)
//                datesInMonth.append(date)
//                
//                startCalendarDate.date = startCalendarDate.date.dateByAddingDays(1)
//            }
//            
//            nextYearsDates.append(datesInMonth)
//        }
//        
//        return nextYearsDates
//    }

}

   


