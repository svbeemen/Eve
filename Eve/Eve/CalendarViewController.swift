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
    
    var calendarManager: CalendarClass!
    var dateObjects: [[CycleDate]]!
    var today: NSDate!
    
    var calendarView: CalendarCollectionView!
    var cellObject: NewDateCell!
    
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        calendarManager = CalendarClass()
        today = calendarManager.currentDate
        dateObjects = calendarManager.getDates()
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let layout: CalendarViewFlowLayout = CalendarViewFlowLayout()
        calendarView = CalendarCollectionView(frame: self.view.frame, collectionViewLayout: layout)
        calendarView!.dataSource = self
        calendarView!.delegate = self
        self.view.insertSubview(calendarView!, atIndex: 0)
    
        view.backgroundColor = UIColor.blackColor()
        
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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "detail")
        {
            var nextViewController = (segue.destinationViewController as! DetailViewController)
            nextViewController.cellObject = cellObject
            nextViewController.calendarManager = calendarManager
            nextViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        }
    }
    
    
    // called by notication when user selects or deseletc a date in the detalview.
    override func viewWillDisappear(animated: Bool)
    {
        
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
        return dateObjects[section].count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! NewDateCell
                
        cell.dateObject = dateObjects[indexPath.section][indexPath.item]
        cell.getImage()
        cell.getText()
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
        let monthHeader = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath) as! NewMonthReusableView
        
        monthHeader.dateObject = self.dateObjects[indexPath.section].first!
        monthHeader.getText()
        
        return monthHeader
    }
}


extension CalendarViewController: UICollectionViewDelegate
{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let cell = calendarView.cellForItemAtIndexPath(indexPath) as! NewDateCell
        cellObject = cell
        
        self.performSegueWithIdentifier("detail", sender: nil)
    }
}























