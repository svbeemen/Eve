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
        
        calendarInfo = CalendarClass()
        dateObjects = calendarInfo.getDates()
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        today = calendarInfo.currentDate
        
        let layout: CalendarViewFlowLayout = CalendarViewFlowLayout()
        calendarView = CalendarCollectionView(frame: self.view.frame, collectionViewLayout: layout)
        calendarView!.dataSource = self
        calendarView!.delegate = self
        self.view.insertSubview(calendarView!, atIndex: 0)
        

        var todayIndexSection = today.month.value() + 11
        var todayIndexItem = today.day.value() - 1
        var todayIndexPAth = NSIndexPath(forItem: todayIndexItem, inSection: todayIndexSection)
        self.calendarView.scrollToItemAtIndexPath(todayIndexPAth, atScrollPosition: UICollectionViewScrollPosition.CenteredVertically, animated: true)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadCalendarView:",name:"load", object: nil)
    }
    
    
    
    func loadCalendarView(notification: NSNotification)
    {
        self.calendarView.reloadData()
    }
    

    @IBAction func saveMyDates(sender: UIButton)
    {
        calendarInfo.menstruation.saveDates()
        
        savedData.removeObjectForKey("pastMenstruationDates")
//        var newPastDates = savedData.objectForKey("pastMenstruationDates") as! [NSDate]
        
//        println("newPAstDAtes = \(newPastDates)")
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
    
    
    override func viewWillDisappear(animated: Bool)
    {
        calendarInfo.menstruation.saveDates()
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
         println("color cells")
        
        
        cell.dateObject = dateObjects[indexPath.section][indexPath.item]
        
 
        if contains(calendarInfo.menstruation.pastMenstruationDates, cell.dateObject) || contains(calendarInfo.menstruation.predictedMenstruationDates, cell.dateObject)
        {
            cell.circleImage.image = UIImage(named: "LightRed")
            cell.circleImage.layer.borderWidth = CGFloat(0)
            
            cell.dateObject.day
        }
        else if contains(calendarInfo.menstruation.predictedOvulationDates, cell.dateObject)
        {
            cell.circleImage.image = UIImage(named: "darkGrey")
            cell.circleImage.layer.borderWidth = CGFloat(0)
        }
        else if contains(calendarInfo.menstruation.predictedCautionDates, cell.dateObject)
        {
            cell.circleImage.image = UIImage(named: "lightBlueCircle")
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
//        println("SHOULD SELECT")
//        
//        let cell = calendarView.cellForItemAtIndexPath(indexPath) as! NewDateCell
//
////        cellObject = cell 
//        
//        return true
//    }
//    
//
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let cell = calendarView.cellForItemAtIndexPath(indexPath) as! NewDateCell
        
        cellObject = cell
        
        self.performSegueWithIdentifier("detail", sender: nil)
    }
    
}























