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
    var calendarManager: CalendarClass
    var dateObjects: [[CycleDate]]
    let today: NSDate
    var shouldScroll: Bool = true

    required init?(coder aDecoder: NSCoder)
    {
        calendarManager = CalendarClass()
        calendarManager.getDates()
        dateObjects = calendarManager.calenderDates
        today = calendarManager.currentDate
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Instatiate a calendarview and add to view.
        let layout: CalendarViewFlowLayout = CalendarViewFlowLayout()
        collectionView = CalendarCollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView!.dataSource = self
        collectionView!.delegate = self
        self.view.insertSubview(collectionView!, atIndex: 0)

        // Get indexPath of current date and scroll calendarview to show current date.
        let todayIndexSection = today.month() + 11
        let todayIndexItem = today.day() - 1
        let todayIndexPAth = NSIndexPath(forItem: todayIndexItem, inSection: todayIndexSection)
        self.collectionView!.scrollToItemAtIndexPath(todayIndexPAth, atScrollPosition: UICollectionViewScrollPosition.CenteredVertically, animated: true)
        
        // Instantiate an instructionview. Add subview and show over other views.
        let welcomeView = InstructionView(effect: UIVisualEffect())
        welcomeView.frame = view.bounds
        view.addSubview(welcomeView)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "predict")
        {
            // Save set menstruations dates to shared instance under pastMenstruationDates.
            SavedDataManager.sharedInstance.savePastMenstruationDates(self.calendarManager.selectedDates)
            
            let nextViewController = (segue.destinationViewController as! CalendarViewController)
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
        let daysInMonth = dateObjects[section].count
        return daysInMonth
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

extension InitialCalendarViewController: UICollectionViewDelegate
{
    // Let user select date to set as mentruation date if the date is before current date or current date.
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! NewDateCell
        
        if cell.dateObject.date.isEarlierThanOrEqualTo(self.today)
        {
            return true
        }
        
        return false
    }
    
    // Add selected cell's dateobject to selected cell array. Change image of cell to correspond to cells state. Reload view to display new image.
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! NewDateCell
        calendarManager.setSelectedDate(cell.dateObject)
        cell.getImage()
        collectionView.reloadData()
    }

    // Infinite scroll
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height
        {
            
            self.calendarManager.lastCalendarDate = self.calendarManager.lastCalendarDate.dateByAddingYears(1)
            self.calendarManager.getDates()
            self.calendarManager.getSelectedDate()
            self.dateObjects = self.calendarManager.calenderDates
            self.collectionView!.reloadData()
        }

        if offsetY < 0
        {
            SavedDataManager.sharedInstance.savePastMenstruationDates(self.calendarManager.selectedDates)

            if shouldScroll
            {
                shouldScroll = false
                self.calendarManager.firstCalendarDate = self.calendarManager.firstCalendarDate.dateBySubtractingYears(1)
                self.calendarManager.getDates()
                self.calendarManager.getSelectedDate()
                self.dateObjects = self.calendarManager.calenderDates
                self.collectionView!.reloadData()
                let indexLastDate = NSIndexPath(forItem: 0, inSection: 13)
                self.collectionView!.scrollToItemAtIndexPath(indexLastDate, atScrollPosition: UICollectionViewScrollPosition(), animated: true)
            }
        }
        
        if offsetY > (scrollView.frame.minY)
        {
            shouldScroll = true
        }
    }
}









