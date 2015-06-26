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
    }

    
    func getDates() -> [[CycleDate]]
    {
        var startCalendarDate = CycleDate(date: NSDate())
        var endCalendarDate = CycleDate(date: NSDate())
    
        startCalendarDate.date = getEqualTimeDateObject(self.currentDate.firstYearDate().dateBySubtractingYears(1))
        endCalendarDate.date = getEqualTimeDateObject(startCalendarDate.date.dateByAddingYears(3).lastYearDate())
        
        self.lastCalendarDate = endCalendarDate.date
        self.firstCalendarDate = startCalendarDate.date
        
        self.menstruationCycle = MenstrualCycle(currentDate: self.currentDate, endPredictionDate: self.lastCalendarDate)

        while startCalendarDate.date.isEarlierThanOrEqualTo(endCalendarDate.date)
        {
            var daysInMonth = startCalendarDate.date.daysInMonth()
            var datesInMonth = [CycleDate]()

            for var index = 0; index < daysInMonth; index++
            {
                var date = CycleDate(date: startCalendarDate.date)
                date.date = getEqualTimeDateObject(date.date)
                datesInMonth.append(date)
                
                startCalendarDate.date = startCalendarDate.date.dateByAddingDays(1)
            }
            
            self.calenderDates.append(datesInMonth)
        }
        
        return self.calenderDates
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
    func getAndSetCycleDates()
    {
        self.menstruationCycle.calculateCycle()
        
        for dates in self.menstruationCycle.predictedCycleDates
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
    }
    
    
    // remove pased predicted dates to pastPredicted dates
    func refreshDates()
    {
        if self.menstruationCycle.predictedCycleDates.isEmpty
        {
            return
        }
        
        for cycleDates in self.menstruationCycle.predictedCycleDates
        {
            while cycleDates.date.isEarlierThan(self.currentDate) || currentCalendar.isDateInToday(cycleDates.date)
            {
                self.menstruationCycle.pastCycleDates.append(cycleDates)
            }
        }
        menstruationCycle.sortDates(self.menstruationCycle.pastCycleDates)
    }
    
    
    // create dateObjects with equal timestaps to make calculations easier/ more pratical
    func getEqualTimeDateObject(dateObject: NSDate) -> NSDate
    {
        var dateComponents: NSDateComponents = currentCalendar.components(NSCalendarUnit.CalendarUnitYear|NSCalendarUnit.CalendarUnitMonth|NSCalendarUnit.CalendarUnitDay, fromDate: dateObject)
        
        return currentCalendar.dateFromComponents(dateComponents)!
    }
}

   


