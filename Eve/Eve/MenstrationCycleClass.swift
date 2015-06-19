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
    
    
    var daysTillNextMenstruation: Int!
    var lengthOfMenstruation: Int!
    
//    var daysEndMenstruationTillOvulation: Int!
    
    var lengthOfOvulation: Int!
    
    
    var menstrautionDates = [NSDate]()
    var fertileDates = [NSDate]()
    var safeDates = [NSDate]()
    
    //    var predictedMenstruationDates = [NSDate]()
    //
    //    var fertileDates = [NSDate]()
    //
    //    var safeDates = [NSDate]()

    
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
        
        
        self.sortMenstruationDates(self.previousMenstruationDates)
        
//        println("MEN CLASS previousmen list = \(self.previousMenstruationDates)")
        
    }

    
    // sort the dates of the ....
    func sortMenstruationDates(datesToSort: [NSDate])
    {
        datesToSort.sorted({ $0.day() < $1.day() })
        datesToSort.sorted({ $0.month() < $1.month() })
        datesToSort.sorted({ $0.year() < $1.year() })
        
//        println("sorted menstruation dates in calss = \(datesToSort)")
    }
    
    
    
    // function that calculates when a menstruation starts and stops. Stores date object in dictionary. 
    // Returns sorted dictionary in array. Function only gets called with in the MenstrautionCycleClass
    func getFirstAndLastDatePreviousMenstruation(newAllDateObjects: [NSDate]) -> [(NSDate, NSDate)]
    {
        
        var startEndDates = [NSDate:NSDate]()
        
        self.sortMenstruationDates(newAllDateObjects)
        
        var copyAllDateObjectes = newAllDateObjects
        
        copyAllDateObjectes.removeAtIndex(0)
        
        var nextDateMenstruationDates = copyAllDateObjectes.generate()
        
        var previousMenstruationStartEndDates = [NSDate:NSDate]()

        
        
        var startMenstruationDate = newAllDateObjects[0]
        
    
        for (index, dateMenstruation) in enumerate(newAllDateObjects)
        {
            if let nextMenstruation = nextDateMenstruationDates.next()
            {
                if nextMenstruation.daysFrom(dateMenstruation) != 1
                {
                    var endMenstruationDate = dateMenstruation
                    
                    var object = [startMenstruationDate, endMenstruationDate]
                    
                    startEndDates[startMenstruationDate] = endMenstruationDate
                    
                    
                    startMenstruationDate = nextMenstruation
                }
            }
            else
            {
                var lastMenstruationDate = dateMenstruation
                startEndDates[startMenstruationDate] = lastMenstruationDate
            }
        }


        var startEndDateDictionary = sorted(startEndDates){$0.0 < $1.0}
        
        println("MEN CLASS previousMen Dictionary  = \(startEndDateDictionary)")

        return startEndDateDictionary
    }
    
    

    func getEndMenStartMen(newAllDateObjects: [NSDate]) -> [(NSDate, NSDate)]
    {
        
        var startEndDates = [NSDate:NSDate]()
        
        self.sortMenstruationDates(newAllDateObjects)
        
        var copyAllDateObjectes = newAllDateObjects
        
        copyAllDateObjectes.removeAtIndex(0)
        
        var nextDateMenstruationDates = copyAllDateObjectes.generate()
        
//        var previousMenstruationStartEndDates = [NSDate:NSDate]()
        
        
        
        var startMenstruationDate = newAllDateObjects[0]
        
        
        for (index, dateMenstruation) in enumerate(newAllDateObjects)
        {
            if let nextMenstruation = nextDateMenstruationDates.next()
            {
                if nextMenstruation.daysFrom(dateMenstruation) != 1
                {
                    var endMenstruationDate = dateMenstruation
                    
                    startEndDates[endMenstruationDate] = nextMenstruation
                    
                    
                    endMenstruationDate = nextMenstruation
                }
            }
            else
            {
                var lastMenstruationDate = dateMenstruation
                startEndDates[startMenstruationDate] = lastMenstruationDate
            }
        }
        
        
        var startEndDateDictionary = sorted(startEndDates){$0.0 < $1.0}
        
        println("new END NEXT  = \(startEndDateDictionary)")
        
        return startEndDateDictionary
    }
    
    
    
    
    
    
    // calculates the average amoungt of time in days between all previous known menstruations.
    func getAveragePeriodBetweenMenstruations() -> Int
    {
        
        println("GET AVE PER BETWEEN MEN")
        
        var previousMenstruationStartEndDates = self.getFirstAndLastDatePreviousMenstruation(self.previousMenstruationDates)
        
        var copyPreviousMenstruationStartEndDates = previousMenstruationStartEndDates
        
        copyPreviousMenstruationStartEndDates.removeAtIndex(0)
        
        var nextPreviousMenstruationStartEndDates = copyPreviousMenstruationStartEndDates.generate()
        
        
        var totalDaysBetweenMenstruations = 0

        
        for (startDate, endDate) in previousMenstruationStartEndDates
        {
            println("DATE SETS IN DIC = \(startDate, endDate)")
            
            if let nextMenstruation = nextPreviousMenstruationStartEndDates.next()
            {
                println("next menstruation = \(nextMenstruation.0)")
                
                var daysBetweenMenstruation = endDate.daysEarlierThan(nextMenstruation.0)
                
                println("days between =\(daysBetweenMenstruation)")
                
                totalDaysBetweenMenstruations += daysBetweenMenstruation
                
                println("days tota; = \(totalDaysBetweenMenstruations)")
                
            }
            
        }
        
        var averageDaysBetweenMenstruation = totalDaysBetweenMenstruations / previousMenstruationStartEndDates.count
        
        return averageDaysBetweenMenstruation
        
    }

    

    
    // calculates average legth of all know previous menstruations.
    func getAverageLengthMenstruations() -> Int
    {
        
        
        println("GET AVE MEN LENTH")
        var previousMenstruationStartEndDates = self.getFirstAndLastDatePreviousMenstruation(self.previousMenstruationDates)
        
        
        var totalDaysMenstruations = 0
        
        
        for (startDate, endDate) in previousMenstruationStartEndDates
        {
            
            var lengthMenstruation = startDate.daysEarlierThan(endDate)
            
            println("MEN CAL LENGTH = \(lengthMenstruation)")

            totalDaysMenstruations += lengthMenstruation
      
        }
        
        var averageLenghthMenstruation = totalDaysMenstruations / previousMenstruationStartEndDates.count
        
        println("amount of periods = \(previousMenstruationStartEndDates.count)")
        
        return averageLenghthMenstruation
        
    }
    
    
    
    func calculateCycle(endDate: NSDate)
    {
        
        println("CALCULATE CYCLE")
        
        // variables that calculate the users cycle by the inputted dates
        self.daysTillNextMenstruation = self.getAveragePeriodBetweenMenstruations()
        
        self.lengthOfMenstruation = self.getAverageLengthMenstruations()
        
        self.lengthOfOvulation = 3
        

        
        self.menstrautionDates = self.getPredictedMenstruationDates(endDate)
        
        
        
        self.fertileDates = self.getPredictedFertileDate(self.menstrautionDates)
        
        self.menstrautionDates = self.menstrautionDates + self.previousMenstruationDates
        
        
        
        println("called FUNCTIONS")
        println("MENSDATES = \(self.menstrautionDates)")
        println("and FERDATES = \(self.fertileDates)")
        
//        println("MEN CLASS self.menstruationDates = \(self.menstrautionDates)")
//        
//        println("MEN CLASS self.fertileDATES = \(self.fertileDates)")
//        
    }
    
    
    
    // calculates start and date of menstruations since last known period till input EndDAte.
    func getPredictedMenstruationDates(endDatePrediction: NSDate) -> [NSDate]
    {
        
        var counterDaysMen = 0
        
        var counterMen = 0
        
        println(" get predicted date MEN")
        
        var predictedMenstruationDates = [NSDate]()
        
        var endLastMenstruationDate = self.previousMenstruationDates.last!
        
//        println("End Last Known Menstruation = \(endLastMenstruationDate)")

        
        var startMenstruationDate = endLastMenstruationDate.dateByAddingDays(self.daysTillNextMenstruation)
        
//        println("Start first predicted Menstruation = \(startMenstruationDate)")

        
//        println(" end prediction date = \(endDatePrediction)")
        
        while startMenstruationDate.isEarlierThan(endDatePrediction)
        {
//            println("while startdate = \(startMenstruationDate) <= that endDate =\(endDatePrediction)")
//            println(startMenstruationDate.isEarlierThan(endDatePrediction))
            counterMen += 1
            
//            println("counterMenstrautaions to predict = \(counterMen)")
            
            var endMenstruationDate = startMenstruationDate.dateByAddingDays(self.lengthOfMenstruation)
            
//            println("var endMenstruationDate \(endMenstruationDate)")
            
            while startMenstruationDate.isEarlierThan(endMenstruationDate)
            {
//                println(" in little loop\(startMenstruationDate.isEarlierThan(endMenstruationDate))")
//                println("var endMenstruationDate \(endMenstruationDate)")
//                println("var StartMenstruationDate \(startMenstruationDate)")
                
                
                var menstruationDay = startMenstruationDate
                
                predictedMenstruationDates.append(menstruationDay)
                
//                println(" predicted menstruation list = \(predictedMenstruationDates)")
                
                startMenstruationDate = startMenstruationDate.dateByAddingDays(1)
                
//                println(" date math = \(startMenstruationDate)")
                
                counterDaysMen += 1
                
//                println("counterMenDays = \(counterDaysMen)")

            }
            
            startMenstruationDate = endMenstruationDate.dateByAddingDays(self.daysTillNextMenstruation)
            
//            println("new start date \(startMenstruationDate)")
        }
        
//        println("menstruation dates \(predictedMenstruationDates)")
        return predictedMenstruationDates

    }
    
    
    
    func getPredictedFertileDate(predictedMenstruationDates: [NSDate]) -> [NSDate]
    {
        println(" get predicted date FER")

        
        var predictedFertileDates = [NSDate]()
    
        
        var menstruationStartEndDates = self.getEndMenStartMen(predictedMenstruationDates)
        
        
        
        println("PERIOD DIC = \(menstruationStartEndDates)")
        
        var copyMenstruationStartEndDates = self.getFirstAndLastDatePreviousMenstruation(predictedMenstruationDates)
        
        copyMenstruationStartEndDates.removeAtIndex(0)
        
        var nextMenstruationStartEndDates = copyMenstruationStartEndDates.generate()
        
        
    
        for (startDate, endDate) in menstruationStartEndDates
        {
            if let var nextDate = nextMenstruationStartEndDates.next()
            {
                var daysBetweenMenstruations = startDate.daysFrom(endDate)
                
                var daysTillOvulation = (daysBetweenMenstruations / 2) - 1
                
                var startOvulation = startDate.dateByAddingDays(daysTillOvulation)
                
//                startDate.dateByAddingDays(daysTillOvulation)
                
                for var index = 0; index < self.lengthOfOvulation; index++
                {
                    var dateOvulation = startOvulation.dateByAddingDays(index)
                    
                    predictedFertileDates.append(dateOvulation)
                }
                
                
            }
        }
        
        return predictedFertileDates
        
        
       
        
    }
    
//        for (startDate, endDate) in menstruationStartEndDates
//        {
//            if let var nextDate = nextMenstruationStartEndDates.next()
//            {
//                var daysBetweenMenstruations = nextDate.0.daysFrom(endDate)
//                
//                var daysTillOvulation = (daysBetweenMenstruations / 2) - 1
//                
//                var startOvulation = endDate.dateByAddingDays(daysTillOvulation)
//                
//                endDate.dateByAddingDays(daysTillOvulation)
//                
//                for var index = 0; index < self.lengthOfOvulation; index++
//                {
//                    var dateOvulation = startOvulation.dateByAddingDays(index)
//                    
//                    predictedFertileDates.append(dateOvulation)
//                }
//                
//                
//            }
//        }
//        
//        return predictedFertileDates
//        
//    }
}
        
        
        
        
//        var startDate = self.previousMenstruationDates.last
//
//
//        var startOvulationDate = startDate!.dateByAddingDays(self.daysEndMenstruationTillOvulation)
//
//
//
//        while startOvulationDate.isEarlierThan(endDatePrediction)
//        {
//            var endOvulationDate = startOvulationDate.dateByAddingDays(self.lengthOfOvulation)
//
//            while startOvulationDate.isEarlierThan(endOvulationDate)
//            {
//                var fertileDay = startOvulationDate
//
//                predictedFertileDates.append(fertileDay)
//
//                startOvulationDate = startOvulationDate.dateByAddingDays(1)
//            }
//
//            startOvulationDate = endOvulationDate.dateByAddingDays(self.lengthOfOvulation)
//        }
//
//        println("fertile dates \(predictedFertileDates)")

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        


