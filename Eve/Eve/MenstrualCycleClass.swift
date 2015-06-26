//
//  MenstrualCycleClass.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 25/06/15.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import Foundation

class MenstrualCycle
{
    var lengthOfMenstruation: Int
    var lengthOfRestPeriod: Int

    var pastFirstLastDatesMenstruation: [NSDate:NSDate]
    var pastFirstLastDatesRestPeriod: [NSDate:NSDate]
    
    var predictedOvulationDates: [CycleDate]!
    var predictedCautionDates: [CycleDate]!
    var predictedMenstruationsDates: [CycleDate]!
    
    var predictedCycleDates: [CycleDate]
    var pastCycleDates: [CycleDate]
    
    var endPredictionDate: NSDate
    var currentDate: NSDate
    
    
    init(currentDate: NSDate, endPredictionDate: NSDate)
    {
        self.currentDate = currentDate
        self.endPredictionDate = endPredictionDate
        
        self.lengthOfMenstruation = 5
        self.lengthOfRestPeriod = 28
        
        self.pastFirstLastDatesMenstruation = [NSDate:NSDate]()
        self.pastFirstLastDatesRestPeriod = [NSDate:NSDate]()
        
        self.predictedCycleDates = Settings.sharedInstance.getPredictedDateObjects()
        
        self.pastCycleDates = Settings.sharedInstance.getPastCycleDates()
    }
    
    
    // calculate the amount of consequative days set to menstruation
    func getPastFirstLastDatesMenstruation()
    {
        if self.pastCycleDates.isEmpty
        {
            return
        }
        
        var startEndDates = [NSDate:NSDate]()
        
        sortDates(self.pastCycleDates)
        var copyPastMenstruationDates = self.pastCycleDates
        copyPastMenstruationDates.removeAtIndex(0)
        var nextMenstruationDates = copyPastMenstruationDates.generate()
        
        var startDate = pastCycleDates.first!
        
        for date in pastCycleDates
        {
            if let nextDate = nextMenstruationDates.next()
            {
                if nextDate.date.daysFrom(date.date) != 1
                {
                    startEndDates[startDate.date] = date.date
                    startDate = nextDate
                }
            }
            else
            {
                startEndDates[startDate.date] = date.date
            }
        }
        self.pastFirstLastDatesMenstruation = startEndDates
    }
    
    
    // calculate the period between menstruations
    func getPastFirstLastDatesRestPeriod()
    {
        if self.pastCycleDates.isEmpty
        {
            return
        }
        
        sortDates(self.pastCycleDates)

        var startEndDates = [NSDate:NSDate]()
        var copyPastMenstruationDates = self.pastCycleDates
        copyPastMenstruationDates.removeAtIndex(0)
        var nextPastMenstruationDates = copyPastMenstruationDates.generate()
        
        for date in self.pastCycleDates
        {
            if let nextDate = nextPastMenstruationDates.next()
            {
                if nextDate.date.daysFrom(date.date) != 1
                {
                    var startDate = date.date.dateByAddingDays(1)
                    
                    var endDate = nextDate.date.dateBySubtractingDays(1)
                    
                    startEndDates[startDate] = endDate
                }
            }
        }
        self.pastFirstLastDatesRestPeriod = startEndDates
    }
    
    
    // calculate average legth of menstruation and length of time 
    // between menstruations, for more accurate predictions.
    // defualt settings to ensure a realistic outcome
    func getAverageLengthOfMenstruation()
    {
        if self.pastFirstLastDatesMenstruation.isEmpty
        {
            return
        }
        
        var totalDaysOfMenstruation = 0
        var numberOfMenstruations = self.pastFirstLastDatesMenstruation.count
        
        for (startDate, endDate) in self.pastFirstLastDatesMenstruation
        {
            var daysOfMenstruation = startDate.daysEarlierThan(endDate) + 1
            
            if daysOfMenstruation < 4 && numberOfMenstruations < 3
            {
                daysOfMenstruation =  self.lengthOfMenstruation
            }
            totalDaysOfMenstruation += daysOfMenstruation
        }
        
        if totalDaysOfMenstruation / numberOfMenstruations < 3
        {
            return
        }
        
        self.lengthOfMenstruation = totalDaysOfMenstruation / numberOfMenstruations
    }
    
    
    
    func getAverageLengthOfRestPeriod()
    {
        if self.pastFirstLastDatesRestPeriod.isEmpty
        {
            return
        }
        
        var totalDaysOfRestPeriod = 0
        var numberOfRestPeriods = self.pastFirstLastDatesRestPeriod.count
        
        for (startDate, endDate) in self.pastFirstLastDatesRestPeriod
        {
            var daysNoMenstruation = startDate.daysEarlierThan(endDate) + 1
            
            if daysNoMenstruation < 20 && numberOfRestPeriods < 3
            {
                daysNoMenstruation = self.lengthOfRestPeriod
            }
            
            totalDaysOfRestPeriod += daysNoMenstruation
        }
        
        if totalDaysOfRestPeriod / numberOfRestPeriods < 20
        {
            return
        }
        
        self.lengthOfRestPeriod = totalDaysOfRestPeriod / numberOfRestPeriods
    }
        
    
    
    // calculates future menstruations and ovulations. Set one 
    // caution day befor and after the ovulation for error margins.
    func getPredictedCycleDates()
    {
        sortDates(self.pastCycleDates)
        
        self.predictedOvulationDates = [CycleDate]()
        self.predictedCautionDates = [CycleDate]()
        self.predictedMenstruationsDates = [CycleDate]()

        var menstruationDate = self.pastCycleDates.last!
        
        var ovulationDate: CycleDate!
        
        var cautionDate: CycleDate!
        
        var test = [CycleDate]()
        
        while menstruationDate.date.isEarlierThanOrEqualTo(self.endPredictionDate)
        {
            ovulationDate = CycleDate(date: menstruationDate.date.dateByAddingDays(self.lengthOfRestPeriod / 2))
            ovulationDate.type = "ovulation"
            predictedOvulationDates.append(ovulationDate)
  
            cautionDate = CycleDate(date: ovulationDate.date.dateByAddingDays(1))
            cautionDate.type = "caution"
            predictedCautionDates.append(cautionDate)
            
            cautionDate = CycleDate(date: ovulationDate.date.dateBySubtractingDays(1))
            cautionDate.type = "caution"
            predictedCautionDates.append(cautionDate)
            
            menstruationDate.date = menstruationDate.date.dateByAddingDays(self.lengthOfRestPeriod - 1)
           
            for var index = 0; index < self.lengthOfMenstruation; index++
            {
                menstruationDate = CycleDate(date: menstruationDate.date.dateByAddingDays(1))
                menstruationDate.type = "menstruation"
                predictedMenstruationsDates.append(menstruationDate)
                test.append(menstruationDate)
            }
        }
        
        self.predictedCycleDates = predictedMenstruationsDates + predictedCautionDates + predictedOvulationDates
        self.sortDates(self.predictedCycleDates)
        Settings.sharedInstance.savedData
    }
    

    // adds and deletes menstruationdate when done so by the user
    func editMenstruationDates(selectedDate: CycleDate)
    {
        if contains(self.pastCycleDates, selectedDate)
        {
            self.pastCycleDates = self.pastCycleDates.filter( {$0 != selectedDate} )
        }
        else
        {
            self.pastCycleDates.append(selectedDate)
        }
        
        sortDates(self.pastCycleDates)
        self.calculateCycle()
    }
    
    
    // remove pased predicted dates to pastPredicted dates
    func sortPredictedDates()
    {
        var datesHavePassed = [CycleDate]()
        
        sortDates(predictedCycleDates)
        
        var firstDay = CycleDate(date: currentDate)
        
        for predictedDates in self.predictedCycleDates
        {
            while firstDay.date.isEarlierThanOrEqualTo(predictedDates.date)
            {
                self.pastCycleDates.append(predictedDates)
                self.predictedCycleDates.filter( {$0 != predictedDates} )
            }
        }
    }
    
    
    // sort list of dates from past to future
    func sortDates(var datesToSort: [CycleDate])
    {
        datesToSort.sort({ $0.date.day() < $1.date.day() })
        datesToSort.sort({ $0.date.month() < $1.date.month() })
        datesToSort.sort({ $0.date.year() < $1.date.year() })
    }
    
    
    // call all functions necessary to calculate teh cycle
    func calculateCycle() -> [CycleDate]
    {
        self.getPastFirstLastDatesMenstruation()
        self.getPastFirstLastDatesRestPeriod()
        
        self.getAverageLengthOfMenstruation()
        self.getAverageLengthOfRestPeriod()

        self.getPredictedCycleDates()
        
        return self.predictedCycleDates
    }
}
