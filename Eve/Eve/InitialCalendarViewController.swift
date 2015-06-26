//
//  InitialCalendarViewController.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 25/06/15.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

class InitialCalendarViewController: UIViewController
{
    var collectionView: CalendarCollectionView?
    
    let calendarManager: CalendarClass!
    
    let dateObjects: [[CycleDate]]!
    
    let today: NSDate!
    
    @IBOutlet weak var calculateDates: UIBarButtonItem!
    
    @IBAction func calculateCycle(sender: UIBarButtonItem)
    {

    }
    

    required init(coder aDecoder: NSCoder)
    {
        calendarManager = CalendarClass()
        
        dateObjects = calendarManager.getDates()
        
        today = calendarManager.currentDate
        
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let layout: CalendarViewFlowLayout = CalendarViewFlowLayout()
        collectionView = CalendarCollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView!.dataSource = self
        collectionView!.delegate = self
        self.view.insertSubview(collectionView!, atIndex: 0)

        
        var todayIndexSection = today.month.value() + 11
        var todayIndexItem = today.day.value() - 1
        var todayIndexPAth = NSIndexPath(forItem: todayIndexItem, inSection: todayIndexSection)
        self.collectionView!.scrollToItemAtIndexPath(todayIndexPAth, atScrollPosition: UICollectionViewScrollPosition.CenteredVertically, animated: true)
        
        let welcomeView = InstructionView(effect: UIVisualEffect())
        welcomeView.frame = view.bounds
        view.addSubview(welcomeView)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "predict")
        {
            calendarManager.menstruationCycle.pastCycleDates = self.calendarManager.selectedDates
            calendarManager.getAndSetCycleDates()
            
            var nextViewController = (segue.destinationViewController as! CalendarViewController)
            nextViewController.calendarManager = self.calendarManager
            nextViewController.dateObjects = self.dateObjects
            nextViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        }
    }
}



extension InitialCalendarViewController: UICollectionViewDataSource
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
        cell.getImage()
        cell.getText()
        
        println("ccell = \(cell.dateObject)")
        
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



extension InitialCalendarViewController: UICollectionViewDelegate
{
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! NewDateCell
        
        if cell.dateObject.date.isEarlierThanOrEqualTo(self.today)
        {
            return true
        }
        
        return false
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! NewDateCell

        calendarManager.setSelectedDate(cell.dateObject)
        
        cell.getImage()
        
        collectionView.reloadData()
    }
}









