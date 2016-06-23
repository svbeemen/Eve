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
    
    // Calculate dates for calendar
    func getDates()
    {
        let startCalendarDate = CycleDate(date: self.firstCalendarDate)
        let endCalendarDate = CycleDate(date: self.lastCalendarDate)
        self.calenderDates = [[CycleDate]]()
        
        while startCalendarDate.date.isEarlierThanOrEqualTo(endCalendarDate.date)
        {
            let daysInMonth = startCalendarDate.date.daysInMonth()
            var datesInMonth = [CycleDate]()
            
            for _ in 0 ..< daysInMonth
            {
                let date = CycleDate(date: startCalendarDate.date)
                datesInMonth.append(date)
        
                startCalendarDate.date = startCalendarDate.date.dateByAddingDays(1)
            }
            self.calenderDates.append(datesInMonth)
        }
    }

    // Adds and deletes selected date to menstruation array.
    func setSelectedDate(selectedDate: CycleDate)
    {
        if self.selectedDates.contains(selectedDate)
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
    
    // Calls function to calculate cycle in menstrualCycleClass
    // Sets the type date of the predicted dates to the calendar dates.
    func setDateTypes()
    {
        let datesTypes = self.menstruationCycle.predictedCycleDates + self.menstruationCycle.pastMenstruationDates + self.menstruationCycle.pastCycleDates

        // reset date type
        for months in calenderDates
        {
            for days in months
            {
                days.type = ""
            }
        }
        
        // set date type
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
    }
    
    // Retrieve selected date and set type.
    func getSelectedDate()
    {
        // reset date type
        for months in calenderDates
        {
            for days in months
            {
                days.type = ""
            }
        }
        
        // set selected date type
        for dates in self.selectedDates
        {
            for months in self.calenderDates
            {
                for calandardays in months
                {
                    if currentCalendar.isDate(dates.date, inSameDayAsDate: calandardays.date)
                    {
                        calandardays.type = "menstruation"
                    }
                }
            }
        }
    }
    
    // Remove pased dates from predicted cycle dates, add to pastPredicted dates array.
    func refreshPastedDates()
    {
        if self.menstruationCycle.predictedCycleDates.isEmpty
        {
            return
        }
        
        menstruationCycle.predictedCycleDates = menstruationCycle.sortDates(self.menstruationCycle.predictedCycleDates)
        
        for cycleDates in self.menstruationCycle.predictedCycleDates
        {
            if cycleDates.date.isEarlierThan(self.currentDate)
            {
                self.menstruationCycle.pastCycleDates.append(cycleDates)
                
                if cycleDates.type == "menstruation"
                {
                    self.menstruationCycle.pastMenstruationDates.append(cycleDates)
                }
            }
        }
        
        SavedDataManager.sharedInstance.savePastMenstruationDates(self.menstruationCycle.pastMenstruationDates)
        SavedDataManager.sharedInstance.savePastCycleDates(self.menstruationCycle.pastCycleDates)
    }
}

   


