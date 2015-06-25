//
//  CalendarViewController.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 25/06/15.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController
{
    
    var calendarInfo: CalendarClass!
    
    var dateObjects: [[NSDate]]!
    
    var today: NSDate!
    
    var calendarView: CalendarCollectionView!
    
    var cellObject: NewDateCell!
    
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        today = calendarInfo.currentDate
        calendarInfo.calculateValues()
        
        let layout: CalendarViewFlowLayout = CalendarViewFlowLayout()
        calendarView = CalendarCollectionView(frame: self.view.frame, collectionViewLayout: layout)
        calendarView!.dataSource = self
        calendarView!.delegate = self
        self.view.insertSubview(calendarView!, atIndex: 0)

        var todayIndexSection = today.month.value() + 11
        var todayIndexItem = today.day.value() - 1
        var todayIndexPAth = NSIndexPath(forItem: todayIndexItem, inSection: todayIndexSection)
        self.calendarView.scrollToItemAtIndexPath(todayIndexPAth, atScrollPosition: UICollectionViewScrollPosition.CenteredVertically, animated: true)
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "detail")
        {
            var nextViewController = (segue.destinationViewController as! DetailViewController)

            nextViewController.cellObject = cellObject
            nextViewController.calendarManager = calendarInfo
                    
            nextViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        }
    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        self.calendarView.reloadData()
    }
}


extension CalendarViewController: UICollectionViewDataSource
{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return dateObjects.count
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        var daysInMonth = dateObjects[section].count
        
        return daysInMonth
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! NewDateCell
        
        
        cell.dateObject = dateObjects[indexPath.section][indexPath.item]
        
        
        if contains(calendarInfo.cycleManager.pastMenstruationDates, cell.dateObject) || contains(calendarInfo.cycleManager.predictedMenstrautionDates, cell.dateObject)
        {
            cell.circleImage.image = UIImage(named: "LightRed")
            cell.circleImage.layer.borderWidth = CGFloat(0)
        }
        else if contains(calendarInfo.cycleManager.predictedFertileDates, cell.dateObject)
        {
            cell.circleImage.image = UIImage(named: "darkGrey")
            cell.circleImage.layer.borderWidth = CGFloat(0)
        }
        else
        {
            cell.circleImage.image = UIImage(named: "LightGreen")
            cell.circleImage.layer.borderWidth = CGFloat(0)
            
        }
        
        
        if cell.dateObject.isToday()
        {
            cell.circleImage.layer.borderWidth = CGFloat(2)
            cell.circleImage.layer.cornerRadius = CGFloat(32)
            cell.circleImage.layer.borderColor = UIColor.blackColor().CGColor
        }
        
        cell.dateLabel.text = "\(cell.dateObject.day.value())"
        
    
        return cell
    }
    
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
        let monthHeader = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath) as! NewMonthReusableView
        
        monthHeader.dateObject = self.dateObjects[indexPath.section].first!
        
        monthHeader.dateLabel.text = "\(self.calendarInfo.monthNames[monthHeader.dateObject.month.value() - 1]) \(monthHeader.dateObject.year.value())"
        
        return monthHeader
    }
}


extension CalendarViewController: UICollectionViewDelegate
{
//    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool
//    {
//        let cell = calendarView.cellForItemAtIndexPath(indexPath) as! NewDateCell
//        
//        if cell.dateObject.isEarlierThanOrEqualTo(self.today)
//        {
////            cellObject = cell
//
//            return true
//        }
//        
//        return false
//    }
//    

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let cell = calendarView.cellForItemAtIndexPath(indexPath) as! NewDateCell
        
        println("Did select")
        
        calendarInfo.setSelectedDate(cell.dateObject)

        cellObject = cell
        
        self.performSegueWithIdentifier("detail", sender: nil)
    }
    
}























