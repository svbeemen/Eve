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
    var pastMenstruationDates: [CycleDate]
    
    init(currentDate: NSDate, endPredictionDate: NSDate)
    {
        self.currentDate = currentDate
        self.endPredictionDate = endPredictionDate
        
        // margins for average cycle
        self.lengthOfMenstruation = 5
        self.lengthOfRestPeriod = 28
        
        self.pastFirstLastDatesMenstruation = [NSDate:NSDate]()
        self.pastFirstLastDatesRestPeriod = [NSDate:NSDate]()
        self.predictedCycleDates = SavedDataManager.sharedInstance.getPredictedCycleDates()
        self.pastCycleDates = SavedDataManager.sharedInstance.getPastCycleDates()
        self.pastMenstruationDates = SavedDataManager.sharedInstance.getPastMenstruationDates()
    }
    
    // Calculate the amount of consequative days set to menstruation.
    func getPastFirstLastDatesMenstruation()
    {
        var startEndDates = [NSDate:NSDate]()
        var startDate = pastMenstruationDates.first!
        self.pastMenstruationDates = sortDates(self.pastMenstruationDates)
        var copyPastMenstruationDates = self.pastMenstruationDates
        copyPastMenstruationDates.removeAtIndex(0)
        var nextMenstruationDates = copyPastMenstruationDates.generate()
        
        for date in pastMenstruationDates
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
    
    // Calculate the period between menstruations.
    func getPastFirstLastDatesRestPeriod()
    {
        self.pastMenstruationDates = sortDates(self.pastMenstruationDates)
        var startEndDates = [NSDate:NSDate]()
        var copyPastMenstruationDates = self.pastMenstruationDates
        copyPastMenstruationDates.removeAtIndex(0)
        var nextPastMenstruationDates = copyPastMenstruationDates.generate()
        
        for date in self.pastMenstruationDates
        {
            if let nextDate = nextPastMenstruationDates.next()
            {
                if nextDate.date.daysFrom(date.date) != 1
                {
                    let startDate = date.date.dateByAddingDays(1)
                    let endDate = nextDate.date.dateBySubtractingDays(1)
                    startEndDates[startDate] = endDate
                }
            }
        }
        self.pastFirstLastDatesRestPeriod = startEndDates
    }
    
    // Calculate average length of menstruation for most accurate predictions. 
    // Defualt settings to ensure a realistic outcome.
    func getAverageLengthOfMenstruation()
    {
        if self.pastFirstLastDatesMenstruation.isEmpty
        {
            return
        }
        
        var totalDaysOfMenstruation = 0
        let numberOfMenstruations = self.pastFirstLastDatesMenstruation.count
        
        for (startDate, endDate) in self.pastFirstLastDatesMenstruation
        {
            var daysOfMenstruation = startDate.daysEarlierThan(endDate) + 1
            
            // margins for default settings
            if daysOfMenstruation < 2 && numberOfMenstruations < 2
            {
                daysOfMenstruation =  self.lengthOfMenstruation
            }
            totalDaysOfMenstruation += daysOfMenstruation
        }
        
        // margins for default settings
        if totalDaysOfMenstruation / numberOfMenstruations < 3
        {
            return
        }
        
        self.lengthOfMenstruation = totalDaysOfMenstruation / numberOfMenstruations
    }
    
    // Calculate average length of time between menstruations, for most accurate predictions. 
    // Defualt settings to ensure a realistic outcome.
    func getAverageLengthOfRestPeriod()
    {
        if self.pastFirstLastDatesRestPeriod.isEmpty
        {
            return
        }
        
        var totalDaysOfRestPeriod = 0
        let numberOfRestPeriods = self.pastFirstLastDatesRestPeriod.count
        
        for (startDate, endDate) in self.pastFirstLastDatesRestPeriod
        {
            var daysNoMenstruation = startDate.daysEarlierThan(endDate) + 1
            
            // margins for default settings
            if daysNoMenstruation < 7 && numberOfRestPeriods < 1
            {
                daysNoMenstruation = self.lengthOfRestPeriod
            }
            totalDaysOfRestPeriod += daysNoMenstruation
        }
        
        // margins for default settings
        if totalDaysOfRestPeriod / numberOfRestPeriods < 5
        {
            return
        }
        
        self.lengthOfRestPeriod = totalDaysOfRestPeriod / numberOfRestPeriods
    }
    
    // Calculates future menstruation and ovulation dates. 
    // Set one caution day befor and after the ovulation for error margins.
    func getPredictedCycleDates()
    {
        self.pastMenstruationDates = sortDates(self.pastMenstruationDates)
        self.predictedOvulationDates = [CycleDate]()
        self.predictedCautionDates = [CycleDate]()
        self.predictedMenstruationsDates = [CycleDate]()
        self.predictedCycleDates = [CycleDate]()
        var myLastMenstruationDate = self.pastMenstruationDates.last!
        var ovulationDate: CycleDate!
        var cautionDate: CycleDate!

        while myLastMenstruationDate.date.isEarlierThanOrEqualTo(self.endPredictionDate)
        {
            ovulationDate = CycleDate(date: myLastMenstruationDate.date.dateByAddingDays(self.lengthOfRestPeriod / 2))
            ovulationDate.type = "ovulation"
            predictedOvulationDates.append(ovulationDate)

            // caution date 1 day after ovulation date
            cautionDate = CycleDate(date: ovulationDate.date.dateByAddingDays(1))
            cautionDate.type = "caution"
            predictedCautionDates.append(cautionDate)
            
            // caution date 1 day before before ovulation date
            cautionDate = CycleDate(date: ovulationDate.date.dateBySubtractingDays(1))
            cautionDate.type = "caution"
            predictedCautionDates.append(cautionDate)
            
            myLastMenstruationDate = CycleDate(date: myLastMenstruationDate.date.dateByAddingDays(self.lengthOfRestPeriod - 1))
            
            // predict future menstruation dates
            for _ in 0 ..< self.lengthOfMenstruation
            {
                myLastMenstruationDate = CycleDate(date: myLastMenstruationDate.date.dateByAddingDays(1))
                myLastMenstruationDate.type = "menstruation"
                predictedMenstruationsDates.append(myLastMenstruationDate)
            }
        }
        // collect all predicted cycle dates and sort by date
        self.predictedCycleDates = predictedMenstruationsDates + predictedCautionDates + predictedOvulationDates
        self.predictedCycleDates = self.sortDates(self.predictedCycleDates)
    }

    // Adds and deletes menstruationdate when done so by the user.
    func editMenstruationDates(selectedDate: CycleDate)
    {
        if self.pastMenstruationDates.contains(selectedDate)
        {
            self.pastMenstruationDates = self.pastMenstruationDates.filter( {$0 != selectedDate} )
        }
        else
        {
            let newMenstruationDate = CycleDate(date: selectedDate.date)
            newMenstruationDate.type = "menstruation"
            self.pastMenstruationDates.append(newMenstruationDate)
        }
        self.pastMenstruationDates = sortDates(self.pastMenstruationDates)
        self.calculateCycle()
    }
    
    // Sort list of dates from past to future.
    func sortDates(datesToSort: [CycleDate]) -> [CycleDate]
    {
        let sortedDates = datesToSort.sort({ $0.date.compare($1.date) == NSComparisonResult.OrderedAscending })
        return sortedDates
    }
    
    // Call all functions necessary to calculate the cycle.
    func calculateCycle()
    {
        if self.pastMenstruationDates.isEmpty
        {
            self.predictedCycleDates = [CycleDate]()
            return
        }
        
        self.getPastFirstLastDatesMenstruation()
        self.getPastFirstLastDatesRestPeriod()
        self.getAverageLengthOfMenstruation()
        self.getAverageLengthOfRestPeriod()
        self.getPredictedCycleDates()
    }
}
