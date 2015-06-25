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
    
    var pastMenstruationDates: [NSDate]
    
    var pastOvulationDates: [NSDate]
    
    var pastCautionDates: [NSDate]
    
    
    var predictedMenstruationDates: [NSDate]
    
    var predictedOvulationDates: [NSDate]
    
    var predictedCautionDates: [NSDate]
    
    
    var lengthOfMenstruation: Int
    
    var lengthOfRestPeriod: Int
    
    
    var currentDate: NSDate
    
    
    var pastFirstLastDatesMenstruation: [NSDate:NSDate]
    var pastFirstLastDatesRestPeriod: [NSDate: NSDate]
    
    
    init(currentDate: NSDate)
    {
        if let pastMenstruationDates = savedData.objectForKey("pastMenstruationDates") as? [NSDate]
        {
            self.pastMenstruationDates = savedData.objectForKey("pastMenstruationDates") as! [NSDate]
            
            println("init menstruationcycle")
        }
        else
        {
            self.pastMenstruationDates = [NSDate]()
        }
        
        if let pastOvulationDates = savedData.objectForKey("pastOvulationDates") as? [NSDate]
        {
            self.pastOvulationDates = savedData.objectForKey("pastOvulationDates") as! [NSDate]
        }
        else
        {
            self.pastOvulationDates = [NSDate]()
        }
        
        if let pastCautionDates = savedData.objectForKey("pastCautionDates") as? [NSDate]
        {
            self.pastCautionDates = savedData.objectForKey("pastCautionDates") as! [NSDate]
        }
        else
        {
            self.pastCautionDates = [NSDate]()
        }
        
        
        // future
        if let predictedMenstruationDates = savedData.objectForKey("predictedMenstruationDates") as? [NSDate]
        {
            self.predictedMenstruationDates = savedData.objectForKey("predictedMenstruationDates") as! [NSDate]
        }
        else
        {
            self.predictedMenstruationDates = [NSDate]()
        }
        

        
        if let predictedOvulationDates = savedData.objectForKey("predictedOvulationDates") as? [NSDate]
        {
            self.predictedOvulationDates = savedData.objectForKey("predictedOvulationDates") as! [NSDate]
        }
        else
        {
            self.predictedOvulationDates = [NSDate]()
        }
        
        if let predictedCautionDates = savedData.objectForKey("predictedCautionDates") as? [NSDate]
        {
            self.predictedCautionDates = savedData.objectForKey("predictedCautionDates") as! [NSDate]
        }
        else
        {
            self.predictedCautionDates = [NSDate]()
        }
        
        println("pre cautiondate = \(self.predictedCautionDates)")

        println("pre mens dates = \(self.predictedMenstruationDates)")
        println("pre ovu dates = \(self.predictedOvulationDates)")
        
  
        
        self.lengthOfMenstruation = 5
        self.lengthOfRestPeriod = 28
        
        println("length of menstruation =\(self.lengthOfMenstruation)")
        println("length of restperiod =\(self.lengthOfRestPeriod)")
        
        self.currentDate = currentDate
        
        self.pastFirstLastDatesMenstruation = [NSDate:NSDate]()
        self.pastFirstLastDatesRestPeriod = [NSDate:NSDate]()
        
    }
    
    
    
    func getPastFirstLastDatesMenstruation()
    {
        if self.pastMenstruationDates.isEmpty
        {
            return
        }
        
        self.pastMenstruationDates = sortDates(self.pastMenstruationDates)
        
        var startEndDates = [NSDate:NSDate]()
        
        var copyPastMenstruationDates = self.pastMenstruationDates
        copyPastMenstruationDates.removeAtIndex(0)
        var nextMenstruationDates = copyPastMenstruationDates.generate()
        
        var startDate = pastMenstruationDates.first!
        
        for date in pastMenstruationDates
        {
            if let nextDate = nextMenstruationDates.next()
            {
                if nextDate.daysFrom(date) != 1
                {
                    startEndDates[startDate] = date
                    
                    startDate = nextDate
                }
            }
            else
            {
                startEndDates[startDate] = date
            }
        }

        self.pastFirstLastDatesMenstruation =  startEndDates
    }
    
    
    
    
    func getPastFirstLastDatesRestPeriod()
    {
        if self.pastMenstruationDates.isEmpty
        {
            return
        }
        
        self.pastMenstruationDates = sortDates(self.pastMenstruationDates)
        
        var startEndDates = [NSDate:NSDate]()
        
        var copyPastMenstruationDates = self.pastMenstruationDates
        
        copyPastMenstruationDates.removeAtIndex(0)
        
        var nextPastMenstruationDates = copyPastMenstruationDates.generate()
        
        
        for date in self.pastMenstruationDates
        {
            if let nextDate = nextPastMenstruationDates.next()
            {
                if nextDate.daysFrom(date) != 1
                {
                    var startDate = date.dateByAddingDays(1)
                    
                    var endDate = nextDate.dateBySubtractingDays(1)
                    
                    startEndDates[startDate] = endDate
                    
                }
            }
        }
        
        self.pastFirstLastDatesRestPeriod = startEndDates
    }
    
    
    
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
            
            if daysNoMenstruation < 10 && numberOfRestPeriods < 3
            {
                daysNoMenstruation = self.lengthOfRestPeriod
            }
            
            totalDaysOfRestPeriod += daysNoMenstruation
        }
        
        
        self.lengthOfRestPeriod = totalDaysOfRestPeriod / numberOfRestPeriods
    }
    
    
    
    
    func getPredictedFirstLastDates(endDatePrediction: NSDate)
    {
        self.pastMenstruationDates = sortDates(self.pastMenstruationDates)

        println(" past dates set =\(self.pastMenstruationDates)")
        var menstruationDate = self.pastMenstruationDates.last!
        
        var ovulationDate: NSDate!
        
        var cautionDate: NSDate!
        
        
        var futureOvulationDates = [NSDate]()
        
        var futureCautionDates = [NSDate]()
        
        var futureMenstruationDates = [NSDate]()
        
        
        
        while menstruationDate.isEarlierThanOrEqualTo(endDatePrediction)
        {
            
            ovulationDate = menstruationDate.dateByAddingDays(self.lengthOfRestPeriod / 2)
            futureOvulationDates.append(ovulationDate)
            println("OVULATION DATE = \(ovulationDate)")
            
            cautionDate = ovulationDate.dateByAddingDays(1)
            futureCautionDates.append(cautionDate)
            
            println("CAUTION DATE B4 = \(cautionDate)")
            
            cautionDate = ovulationDate.dateBySubtractingDays(1)
            futureCautionDates.append(cautionDate)
            
            println("CAUTION DATE AFTER = \(cautionDate)")

            
            menstruationDate = menstruationDate.dateByAddingDays(self.lengthOfRestPeriod - 1)
            
            println("MENSTRUATIONDATE = \(menstruationDate)")
            
            for var index = 0; index < self.lengthOfMenstruation; index++
            {
                menstruationDate = menstruationDate.dateByAddingDays(1)

                futureMenstruationDates.append(menstruationDate)
                
                println("MENSTRUATIONDATE in loop = \(menstruationDate)")

            }
        }
        
        println(" B4 sort CAU \(futureCautionDates)")
        println(" B4 sort OV \(futureMenstruationDates)")
        println(" B4 sort MEn \(futureOvulationDates)")

        self.predictedOvulationDates = futureOvulationDates
        self.predictedCautionDates = futureCautionDates
        self.predictedMenstruationDates = futureMenstruationDates
        
        
        
//        self.predictedOvulationDates = self.sortDates(futureOvulationDates)
//        self.predictedCautionDates = self.sortDates(futureCautionDates)
//        self.predictedMenstruationDates = self.sortDates(futureCautionDates)
    }
    
    
    
//    func getPredictedDatesObjects()
//    {
//        
//    }
//    
    
    // adds and deletes menstruationdate when done so by the user
    func editMenstruationDates(selectedDate: NSDate)
    {
        if contains(self.pastMenstruationDates, selectedDate)
        {
            self.pastMenstruationDates = self.pastMenstruationDates.filter( {$0 != selectedDate} )
        }
        else
        {
            self.pastMenstruationDates.append(selectedDate)
        }
    }
    
    
    // remove pased dates and add to past dates
    func sortPredictedDates()
    {
        var newPastOvulationDates = [NSDate]()
        var newPastCautionDates = [NSDate]()
        var newPastMenstruationDates = [NSDate]()
        
        var newFutureOvulationDates = [NSDate]()
        var newFutureCautionDates = [NSDate]()
        var newFutureMenstruationDates = [NSDate]()
        
        for date in self.predictedOvulationDates
        {
            while date.isEarlierThanOrEqualTo(self.currentDate)
            {
                self.pastOvulationDates.append(date)
                self.predictedOvulationDates = self.predictedOvulationDates.filter( {$0 != date} )
                
            }
        }
        
        for date in self.predictedCautionDates
        {
            while date.isEarlierThanOrEqualTo(self.currentDate)
            {
                self.pastCautionDates.append(date)
                self.predictedOvulationDates = self.predictedOvulationDates.filter({ $0 != date} )
            }
        }
        
        for date in self.predictedMenstruationDates
        {
            while date.isEarlierThanOrEqualTo(self.currentDate)
            {
                self.pastMenstruationDates.append(date)
                self.predictedMenstruationDates = self.predictedMenstruationDates.filter({ $0 != date})
            }
        }
        
    }
    
    
    // sprt list of dates from past to future
    func sortDates(datesToSort: [NSDate]) -> [NSDate]
    {
        var sortedDates = datesToSort.sorted({ $0.day() < $1.day() })
        sortedDates = sortedDates.sorted({ $0.month() < $1.month() })
        sortedDates = sortedDates.sorted({ $0.year() < $1.year() })
        
        return sortedDates
            
    }
    
    func saveDates()
    {
        // predicted
        savedData.setObject(self.predictedMenstruationDates, forKey: "predictedMenstruationDates")
        
        savedData.setObject(self.predictedOvulationDates, forKey: "predictedOvulationDates")
        
        savedData.setObject(self.predictedCautionDates, forKey: "predictedCautionDates")
        
        
        // past
//        savedData.setObject(self.pastMenstruationDates, forKey: "pastMenstruationDates")

        savedData.setObject(self.pastOvulationDates, forKey: "pastOvulationDates")

        savedData.setObject(self.pastCautionDates, forKey: "pastCautionDates")

    }
        
    
    func calculateCycle(endDate: NSDate)
    {
        println("CALCULATE CYCLE")
        
        self.getPastFirstLastDatesMenstruation()
        self.getPastFirstLastDatesRestPeriod()
        
        self.getAverageLengthOfMenstruation()
        self.getAverageLengthOfRestPeriod()
        
        self.getPredictedFirstLastDates(endDate)
        
        
        println("pre cautiondate = \(self.predictedCautionDates)")
        println("pre mens dates = \(self.predictedMenstruationDates)")
        println("pre ovu dates = \(self.predictedOvulationDates)")
        
        println("length of menstruation =\(self.lengthOfMenstruation)")
        println("length of restperiod =\(self.lengthOfRestPeriod)")
    }
    
    
}
