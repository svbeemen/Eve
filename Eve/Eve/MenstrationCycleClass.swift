//
//  MenstrationCycleClass.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 17/06/15.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import Foundation

class MenstruationCycle
{
    
    var previousMenstruationDates = [NSDate]()
    
//    var predictedMenstruationDates = [NSDate]()
    
    var fertileDates = [NSDate]()
    
    var safeDates = [NSDate]()
    
    var allMenstruationDates = [NSDate]()

    
    
    var startDateNextPeriod: NSDate!
    
    var endDateNextPeriod: NSDate!
 
    var startDateFertile: NSDate!
    
    var endDateFertile: NSDate!
    
    
    var daysTillNextMenstruation: Int!
    
    var lengthOfMenstruation: Int!
    
    var daysEndMenstruationTillOvulation: Int!
    

    
    // function to set and adjuct previous menstruation dates. Stores dateobjects in an array.
    // Calls the classses sort function to sort elements by date.
    func setMenstruationDate(selectedDate: NSDate)
    {
        
        if contains(self.previousMenstruationDates, selectedDate)
        {
            self.previousMenstruationDates = self.previousMenstruationDates.filter( {$0 != selectedDate} )
        }
        else
        {
            self.previousMenstruationDates.append(selectedDate)
        }
        
        
        self.sortMenstruationDates(previousMenstruationDates)
        
    }

    
    // sort the dates of the ....
    func sortMenstruationDates(datesToSort: [NSDate])
    {
        datesToSort.sorted({ $0.day() < $1.day() })
        datesToSort.sorted({ $0.month() < $1.month() })
        datesToSort.sorted({ $0.year() < $1.year() })
    }
    
    
    
    // function that calculates when a menstruation starts and stops. Stores date object in dictionary. 
    // Returns sorted dictionary in array. Function only gets called with in the MenstrautionCycleClass
    func getFirstAndLastDatePreviousMenstruation() -> [(NSDate, NSDate)]
    {   // working progress
        
        var copyPreviousMenstruationDates = self.previousMenstruationDates
        
        copyPreviousMenstruationDates.removeAtIndex(0)
        
        var nextDatesPreviousMenstruationDates = copyPreviousMenstruationDates.generate()
        
        var previousMenstruationStartEndDates = [NSDate:NSDate]()
        
        
        
        var startMenstruationDate = self.previousMenstruationDates[0]
    
        for (index, dateMenstruation) in enumerate(self.previousMenstruationDates)
        {
            if let nextMenstruation = nextDatesPreviousMenstruationDates.next()
            {
                if nextMenstruation.daysFrom(dateMenstruation) != 1
                {
                    var endMenstruationDate = dateMenstruation
                    
                    previousMenstruationStartEndDates[startMenstruationDate] = endMenstruationDate
                    
                    startMenstruationDate = nextMenstruation
                }
            }
            else
            {
                var lastMenstruationDate = dateMenstruation
                previousMenstruationStartEndDates[startMenstruationDate] = lastMenstruationDate
            }
        }
        
        
        var previousMenstruationDateDic = sorted(previousMenstruationStartEndDates) { $0.0 < $1.0 }
        
        return previousMenstruationDateDic
    }
    
    
    // calculates the average amoungt of time in days between all previous known menstruations.
    func getAveragePeriodBetweenMenstruations() -> Int
    {
        
        var previousMenstruationStartEndDates = self.getFirstAndLastDatePreviousMenstruation()
        
        var copyPreviousMenstruationStartEndDates = previousMenstruationStartEndDates
        
        copyPreviousMenstruationStartEndDates.removeAtIndex(0)
        
        var nextPreviousMenstruationStartEndDates = copyPreviousMenstruationStartEndDates.generate()
        
        
        var totalDaysBetweenMenstruations = 0

        
        for (startDate, endDate) in previousMenstruationStartEndDates
        {
            
            if let nextMenstruation = nextPreviousMenstruationStartEndDates.next()
            {

                var daysBetweenMenstruation = nextMenstruation.0.daysFrom(endDate)
                
                totalDaysBetweenMenstruations += daysBetweenMenstruation
            }
            
        }
        
        var averageDaysBetweenMenstruation = totalDaysBetweenMenstruations / previousMenstruationStartEndDates.count
        
        return averageDaysBetweenMenstruation
        
    }
    
    
    // calculates average legth of all know previous menstruations.
    func getAverageLengthMenstruations() -> Int
    {
        
        var previousMenstruationStartEndDates = self.getFirstAndLastDatePreviousMenstruation()
        
        
        var totalDaysMenstruations = 0
        
        
        for (startDate, endDate) in previousMenstruationStartEndDates
        {
            
            var lengthMenstruation = endDate.daysFrom(startDate)
            
            totalDaysMenstruations += lengthMenstruation
      
        }
        
        var averageLenghthMenstruation = totalDaysMenstruations / previousMenstruationStartEndDates.count
        
        return averageLenghthMenstruation
        
    }
    
    
    
    func calculateCycle()
    {
        
        self.daysTillNextMenstruation = self.getAveragePeriodBetweenMenstruations()
        
        self.lengthOfMenstruation = self.getAverageLengthMenstruations()
        
        self.daysEndMenstruationTillOvulation = daysTillNextMenstruation / 2
        
        

        
        var endDateLastMenstruation = self.previousMenstruationDates.last
        
        var startDateNextPeriod = endDateLastMenstruation?.dateByAddingDays(daysTillNextMenstruation)
        
        var endDateNextPeriod = startDateNextPeriod?.dateByAddingDays(lengthOfMenstruation)
        
        var startDateFertile = endDateLastMenstruation?.dateByAddingDays(daysEndMenstruationTillOvulation - 1)
        
        var endDateFertile = endDateLastMenstruation?.dateByAddingDays(daysEndMenstruationTillOvulation + 1)
        
    }
    
    
    
    // calculates start and date of menstruations since last known period till input EndDAte.
    func getPredictedMenstruationDates(endDatePrediction: NSDate) -> [NSDate]
    {
        self.calculateCycle()
        
        var predictedMenstruationDates = [NSDate]()
        
        var endMenstruation = self.previousMenstruationDates.last
        
        
        while endMenstruation!.isEarlierThan(endDatePrediction)
        {
            var startMenstruation = endMenstruation!.dateByAddingDays(self.getAveragePeriodBetweenMenstruations())
            endMenstruation = startMenstruation.dateByAddingDays(self.getAverageLengthMenstruations())
            
            while startMenstruation.isEarlierThanOrEqualTo(endMenstruation)
            {
                var menstruationDate = startMenstruation
                
                predictedMenstruationDates.append(menstruationDate)
                
                startMenstruation.day + 1
            }
        }
        
        return predictedMenstruationDates
    }
    
    
    
    func getPredictedFertileDate(endDatePrediction: NSDate)
    {
        self.calculateCycle()
        
        var predictedFertileDates = [NSDate]()
        
        var startDateFertile = self.previousMenstruationDates.last!.dateByAddingDays(self.daysEndMenstruationTillOvulation - 1)
        
        
        while startDateFertile!.isEarlierThanOrEqualTo(endDatePrediction)
        {
            var endDate = startDateFertile!.dateByAddingDays(3)
            
            while startDateFertile.isEarlierThanOrEqualTo(endDateFertile)
            {
                var fertileDate = startDateFertile
                
                predictedFertileDates.append(fertileDate)
                
                startDateFertile.day + 1
            }
            
            
        }
        
        
    }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        


}