//
//  CalendarViewController.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 25/06/15.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

protocol changeDateProtocol
{
    func changeDate() -> NewDateCell
}


class CalendarViewController: UIViewController, changeDateProtocol
{
    var nextViewController: DetailViewController?
    
    var calendarManager: CalendarClass!
    var dateObjects: [[CycleDate]]!
    var today: NSDate!
    
    var calendarView: CalendarCollectionView!
    var cellObject: NewDateCell!
    var cellObjectDate: CycleDate!
    
    var shouldScroll: Bool = true

    @IBOutlet weak var settingsButton: UIButton!
    @IBAction func goToSettings(sender: UIButton)
    {
        self.performSegueWithIdentifier("settings", sender: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad()
    {
        // instatiate instance calandar class, get dates to show in calendar view, calculate cycle and set date type accordingly.
        calendarManager = CalendarClass()
        calendarManager.getDates()
        calendarManager.refreshPastedDates()
        calendarManager.menstruationCycle.calculateCycle()
        calendarManager.setDateTypes()
        dateObjects = calendarManager.calenderDates
        today = calendarManager.currentDate

        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CalendarViewController.refreshCycleNotifications), name: "CycleNotificationsShouldRefresh", object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: CalendarViewController.refreshCycleNotifications(), name: "CycleNotificationsShouldRefresh", object: nil)


        // instantiate calendar view and add to view.
        let layout: CalendarViewFlowLayout = CalendarViewFlowLayout()
        calendarView = CalendarCollectionView(frame: self.view.frame, collectionViewLayout: layout)
        calendarView!.dataSource = self
        calendarView!.delegate = self
        self.view.insertSubview(calendarView!, atIndex: 0)
        
        // get index path of current date and scroll in calendar view to show current date
        let todayIndexSection = today.month.value() + 11
        let todayIndexItem = today.day.value() - 1
        let todayIndexPath = NSIndexPath(forItem: todayIndexItem, inSection: todayIndexSection)
        self.calendarView.scrollToItemAtIndexPath(todayIndexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredVertically, animated: true)
    }
    
    func refreshCycleNotifications()
    {
        CycleNotifications.sharedInstance.refreshNotifications()
    }
    
    func changeDate() -> NewDateCell
    {
        self.calendarManager.menstruationCycle.editMenstruationDates(cellObject.dateObject)
        self.calendarManager.setDateTypes()
        self.calendarView.reloadData()

        return cellObject
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "detail")
        {
            nextViewController = (segue.destinationViewController as! DetailViewController)
            nextViewController?.delegate = self
            nextViewController!.cellObject = cellObject
            nextViewController!.calendarManager = calendarManager
            nextViewController!.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        }
        else if (segue.identifier == "settings")
        {
            let settingsViewController = (segue.destinationViewController as! SettingsViewController)
            settingsViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        }
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        SavedDataManager.sharedInstance.savePastCycleDates(self.calendarManager.menstruationCycle.pastCycleDates)
        SavedDataManager.sharedInstance.savePastMenstruationDates(self.calendarManager.menstruationCycle.pastMenstruationDates)
        SavedDataManager.sharedInstance.savePredictedCycleDates(self.calendarManager.menstruationCycle.predictedCycleDates)
        
        CycleNotifications.sharedInstance.scheduleCycleNotifications(self.calendarManager.menstruationCycle.predictedMenstruationsDates, ovulationDates: self.calendarManager.menstruationCycle.predictedOvulationDates, cautionDates: self.calendarManager.menstruationCycle.predictedCautionDates)
        CycleNotifications.sharedInstance.saveNotificationSettings()
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
        
        if cellObjectDate != nil
        {
            if calendarManager.currentCalendar.isDate(cellObjectDate.date, inSameDayAsDate: cell.dateObject.date)
            {
                cellObject = cell
            }
        }
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
        cellObjectDate = cellObject.dateObject

        self.performSegueWithIdentifier("detail", sender: nil)
    }
    
    
    // infinity scroll
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        let offsetY = scrollView.contentOffset.y
        let offsetX = scrollView.contentOffset.x
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height
        {
            self.calendarManager.lastCalendarDate = self.calendarManager.lastCalendarDate.dateByAddingYears(1)
            self.calendarManager.getDates()
            calendarManager.menstruationCycle.calculateCycle()
            calendarManager.setDateTypes()
            self.dateObjects = self.calendarManager.calenderDates
            self.calendarView.reloadData()
        }
        
        if offsetY < 0
        {
            if shouldScroll
            {
                shouldScroll = false
                self.calendarManager.firstCalendarDate = self.calendarManager.firstCalendarDate.dateBySubtractingYears(1)
                self.calendarManager.getDates()
                calendarManager.menstruationCycle.calculateCycle()
                calendarManager.setDateTypes()
                self.dateObjects = self.calendarManager.calenderDates
                self.calendarView.reloadData()

                let indexLastDate = NSIndexPath(forItem: 0, inSection: 13)
                self.calendarView.scrollToItemAtIndexPath(indexLastDate, atScrollPosition: UICollectionViewScrollPosition(), animated: true)
            }
        }
        
        if offsetY > (scrollView.frame.height * 8)
        {
            shouldScroll = true
        }
    }
}