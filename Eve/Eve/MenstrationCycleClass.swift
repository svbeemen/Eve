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
    
    var setMenstruationDates = [NSDate]()
    
    
    var menstrautionDates = [NSDate]()
    var fertileDates = [NSDate]()


    // function to set and adjuct previous menstruation dates. Stores dateobjects in an array.
    // Calls the classses sort function to sort elements by date.
    func setMenstruationDate(selectedDate: NSDate)
    {
        
        if contains(self.setMenstruationDates, selectedDate)
        {
            self.setMenstruationDates = self.setMenstruationDates.filter( {$0 != selectedDate} )
        }
        else
        {
            self.setMenstruationDates.append(selectedDate)
        }
        
        
        self.sortMenstruationDates(self.setMenstruationDates)
        
        println("set menstruation dates = \(self.setMenstruationDates)")
        
    }

    
    // sort the dates of the ....
    func sortMenstruationDates(datesToSort: [NSDate])
    {
        datesToSort.sorted({ $0.day() < $1.day() })
        datesToSort.sorted({ $0.month() < $1.month() })
        datesToSort.sorted({ $0.year() < $1.year() })
        
        println("SORT")
        println(" sorted = \(datesToSort)")
        
    }
    
    
    
    // function that calculates when a menstruation starts and stops. Stores date object in dictionary. 
    // Returns sorted dictionary in array. Function only gets called with in the MenstrautionCycleClass
    func getFirstLastDateMenstruation(menstruationDates: [NSDate]) -> [NSDate:NSDate]
    {
        println(" in function menstruationDAtes = \(menstruationDates)")
        
        var startEndMenstrautionDates = [NSDate:NSDate]()
        
        self.sortMenstruationDates(menstruationDates)
        
        var startDate: NSDate!
        
        var copyMenstrautionDates: [NSDate]!
        
        if !menstruationDates.isEmpty
        {
            startDate = menstruationDates.first
            copyMenstrautionDates = menstruationDates
            copyMenstrautionDates.removeAtIndex(0)
        }
        
        
        var nextMenstruationDates = copyMenstrautionDates.generate()
        
        for (index, date) in enumerate(menstruationDates)
        {

            if let nextDate = nextMenstruationDates.next()
            {

                if nextDate.daysFrom(date) != 1
                {
    
                    var endDate = date
                    
                    startEndMenstrautionDates[startDate] = endDate
                    
                    startDate = nextDate
                }
            }
            else
            {
                var endDate = date
                startEndMenstrautionDates[startDate] = endDate
            }
        }
        
        println("start date & end date one menstruation  = \(startEndMenstrautionDates)")

        return startEndMenstrautionDates
    }
    
    

    func getFirstLastDateRestPeriod(menstruationDates: [NSDate]) -> [NSDate:NSDate]
    {
        
        var restPeriodDates = [NSDate:NSDate]()
        
        self.sortMenstruationDates(menstruationDates)
        
        var startDate: NSDate!
        
        var copyMenstrautionDates: [NSDate]!
        
        if !menstruationDates.isEmpty
        {
            startDate = menstruationDates.first
            copyMenstrautionDates = menstruationDates
            copyMenstrautionDates.removeAtIndex(0)
        }
        
        var nextMenstruationDates = copyMenstrautionDates.generate()

        
        for (index, date) in enumerate(menstruationDates)
        {
            if let nextDate = nextMenstruationDates.next()
            {

                if nextDate.daysFrom(date) != 1
                {

                    var startDate = date.dateByAddingDays(1) as NSDate
    
                    var endDate = nextDate.dateBySubtractingDays(1) as NSDate
                    
                    restPeriodDates[startDate] = endDate
                    
                    startDate = nextDate
                }
            }

        }
        
        
        println("restPeriodDates  = \(restPeriodDates)")
        
        return restPeriodDates
    }
    
    
    
    
    
    
    // calculates the average amoungt of time in days between all previous known menstruations.
    func getAveragePeriodBetweenMenstruations(restPeriodDates: [NSDate:NSDate]) -> Int
    {
        var averageDaysInBetweenMenstruations: Int!
        
        
        if restPeriodDates.isEmpty
        {
            averageDaysInBetweenMenstruations = 28
        }
        else
        {
            var amountRestPeriods = restPeriodDates.count

            var totalDaysBetweenMenstruations = 0

            for (startDate, endDate) in restPeriodDates
            {
                var daysBetween = startDate.daysEarlierThan(endDate) + 1
                
                totalDaysBetweenMenstruations += daysBetween
            }
            
            averageDaysInBetweenMenstruations = totalDaysBetweenMenstruations / amountRestPeriods
        }
        
        println("lenth between menstruations = \(averageDaysInBetweenMenstruations)")
        
        return averageDaysInBetweenMenstruations
        
    }

    
    // calculates average legth of all know previous menstruations.
    func getAverageLengthMenstruations(menstruationDates: [NSDate:NSDate]) -> Int
    {
        
        var totalDaysOfMenstruations = 0
        
        for (startDate, endDate) in menstruationDates
        {
            var daysOfMenstruation = startDate.daysEarlierThan(endDate) + 1
            
            totalDaysOfMenstruations += daysOfMenstruation
        }
        
        
        var amountOfMenstruations = menstruationDates.count
        
        var averageLengthOfMenstruations = totalDaysOfMenstruations / amountOfMenstruations
        
        println("length of menstruation = \(averageLengthOfMenstruations)")
        
        return averageLengthOfMenstruations
        
    }
    
    
    
    func calculateCycle(endDate: NSDate)
    {
        
        self.menstrautionDates = self.getPredictedMenstruationDates(endDate)
        
        
        self.fertileDates = self.getPredictedOvulationDates(endDate)
        
        var previousMenstruationDates = self.setMenstruationDates
        
        var previousOvulationDates = self.calculatePreviousCycles(self.setMenstruationDates)
        
        self.menstrautionDates = self.menstrautionDates + previousMenstruationDates
        
        self.fertileDates = self.fertileDates + previousOvulationDates
        

    }
  
    // calculates start and date of menstruations since last known period till input EndDAte.
    func getPredictedMenstruationDates(endDatePrediction: NSDate) -> [NSDate]
    {
        
        var predictedMenstruationDates = [NSDate]()
    
        
        var menstruationDates = self.getFirstLastDateMenstruation(self.setMenstruationDates)
        
        var noMenstruationDates = self.getFirstLastDateRestPeriod(self.setMenstruationDates)

        var lenthOfMenstruation = self.getAverageLengthMenstruations(menstruationDates)
        
        var timeBetweenMenstruations = self.getAveragePeriodBetweenMenstruations(noMenstruationDates)
        
        
        var lastKnownMenstruation = self.setMenstruationDates.last!
        
        var startDate = lastKnownMenstruation
        
        while startDate.isEarlierThanOrEqualTo(endDatePrediction)
        {
            startDate = startDate.dateByAddingDays(timeBetweenMenstruations)
            
            var endDate = startDate.dateByAddingDays(lenthOfMenstruation)
            
            while startDate.isEarlierThan(endDate)
            {
                predictedMenstruationDates.append(startDate)
                
                startDate = startDate.dateByAddingDays(1)
            }

        }
        
        self.sortMenstruationDates(predictedMenstruationDates)
        
        println(" predicted menstruationDates = \(predictedMenstruationDates)")
        
        return predictedMenstruationDates
    }
    
    
    
    
    func getPredictedOvulationDates(endDatePrediction: NSDate) -> [NSDate]
    {
        
        var predictedOvulationDates = [NSDate]()
        
        
        var menstruationDates = self.getFirstLastDateMenstruation(self.setMenstruationDates)
        
        var noMenstruationDates = self.getFirstLastDateRestPeriod(self.setMenstruationDates)
        
        var lenthOfMenstruation = self.getAverageLengthMenstruations(menstruationDates)
        
        var timeBetweenMenstruations = self.getAveragePeriodBetweenMenstruations(noMenstruationDates)
        
        
        
        var predictedMenstruationDates = self.getPredictedMenstruationDates(endDatePrediction)
        
                
        var startEndDatesRestPeriods = self.getFirstLastDateRestPeriod(predictedMenstruationDates)

        
        var daysTillOvulation: Int = timeBetweenMenstruations / 2
        
        for (startDate, endDate) in startEndDatesRestPeriods
        {
            var ovulationDate = startDate.dateByAddingDays(daysTillOvulation)
            
            predictedOvulationDates.append(ovulationDate)
            
            predictedOvulationDates.append(ovulationDate.dateByAddingDays(1))
            
            predictedOvulationDates.append(ovulationDate.dateBySubtractingDays(1))

        }
        
        self.sortMenstruationDates(predictedOvulationDates)
        
        println(" predicted ovulation dates = \(predictedOvulationDates)")
        
        return predictedOvulationDates
        
    }
    
    
    func calculatePreviousCycles(previousMenstruationDates: [NSDate]) -> [NSDate]
    {
        var previousOvulationDates = [NSDate]()
        
        var startEndDatesPreviousRestPeriods = self.getFirstLastDateRestPeriod(previousMenstruationDates)
        
        for (startDate, endDate) in startEndDatesPreviousRestPeriods
        {
            var daysTillOvulation = (startDate.daysEarlierThan(endDate) + 1) / 2
            
            var ovulationDate = startDate.dateByAddingDays(daysTillOvulation)
            
            previousOvulationDates.append(ovulationDate)
            
            previousOvulationDates.append(ovulationDate.dateByAddingDays(1))
            
            previousOvulationDates.append(ovulationDate.dateBySubtractingDays(1))
            
        }
        
        
        self.sortMenstruationDates(previousOvulationDates)
        
        println(" previous ovulation dates = \(previousOvulationDates)")
        
        return previousOvulationDates
    }
}
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        


