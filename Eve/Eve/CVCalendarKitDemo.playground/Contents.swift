//: Playground - noun: a place where people can play

import UIKit

//
//var str = "Hello, playground"

var currentCalendar = NSCalendar.currentCalendar()

var monthsNames = currentCalendar.monthSymbols

var monthData = [Int:NSDate]()

var currentDate = NSDate()

var theFirstDayOfMonth = currentDate.day == 1

var newList = [[Int:NSDate]]()

var indexList = [Int]()

var monthObjects = [NSDate]()

var numberDaysInYear = 0

// list of 1st of the month objects
func monthDateObjects() -> [NSDate]
{
    for index in 1...12
    {
        var monthobject = theFirstDayOfMonth.month == index
        monthObjects.append(monthobject)
    }
    return monthObjects
}

var viewList = monthDateObjects()



// days in year function
func daysInYear() -> Int
{
    for object in monthObjects
    {
        var daysInMonth = object.lastMonthDate().day.value()
        numberDaysInYear += daysInMonth
    }
    return numberDaysInYear
}

var view = daysInYear()

//var monthValuesList = []

var monthDictionary = [Int:Int]()

func monthValues() -> [(Int,Int)]
{
    for month in monthObjects
    {
        var monthDayValue = month.lastMonthDate().day.value()
        var monthValue = month.month.value()
        monthDictionary[monthValue] = monthDayValue
        //        var monthDic["monthValue"] = monthDayValue
        //        monthValuesList.append(monthDic)
    }
    
    var monthValuesList = sorted(monthDictionary) { $0.0 < $1.0 }
    return monthValuesList
}

var showMe = monthValues()
var rangeList = [Int]()

func getRange() -> [Int]
{
    for (hello, world) in showMe
    {
        var range = world
        rangeList.append(range)
    }
    return rangeList
}



var showRange = getRange()


//func monthValues() -> [[Int:Int]]
//{
//    for month in monthObjects
//    {
//        var monthDayValue = month.lastMonthDate().day.value()
//        var monthValue = month.month.value()
//        monthDictionary.append([monthValue:monthDayValue])
////        var monthDic["monthValue"] = monthDayValue
////        monthValuesList.append(monthDic)
//    }
//    
//    monthDictionary = sorted(monthDictionary) { $0.0 < $1.0 }
//    return monthDictionary
//}

//
//var show = monthValues()
//
//func getRange()
//{
//    for ([month:day]) in monthDictionary
//    {
//        var ran = day
//    }
//}


























