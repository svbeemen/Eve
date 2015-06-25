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
    
    let calendarInfo: CalendarClass!
    
    let dateObjects: [[NSDate]]!
    
    let today: NSDate!
    
    @IBAction func setDates(sender: AnyObject)
    {
        calendarInfo.calculateValues()
    }
    
    
    required init(coder aDecoder: NSCoder)
    {
        calendarInfo = CalendarClass()
        
        dateObjects = calendarInfo.getDates()
        
        today = calendarInfo.currentDate
        
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
            var nextViewController = (segue.destinationViewController as! CalendarViewController)
            nextViewController.calendarInfo = calendarInfo
            
            nextViewController.dateObjects = dateObjects
            
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
        
        cell.dateLabel.text = "\(cell.dateObject.day.value())"
        
        if contains(calendarInfo.cycleManager.pastMenstruationDates, cell.dateObject)
        {
            cell.circleImage.image = UIImage(named: "Red")
            cell.circleImage.layer.borderWidth = CGFloat(0)
        }
        else
        {
            cell.circleImage.image = UIImage(named: "lightBlueCircle")
            cell.circleImage.layer.borderWidth = CGFloat(0)
        }

        
        if cell.dateObject.isToday()
        {
            cell.circleImage.layer.borderWidth = CGFloat(2)
            cell.circleImage.layer.borderColor = UIColor.darkGrayColor().CGColor
            cell.circleImage.layer.cornerRadius = CGFloat(36)
        }
        
        return cell
    }
    
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
        let monthHeader = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath) as! NewMonthReusableView
        
        monthHeader.dateObject = self.dateObjects[indexPath.section].first!
        
        monthHeader.dateLabel.text = "  \(self.calendarInfo.monthNames[monthHeader.dateObject.month.value() - 1]) \(monthHeader.dateObject.year.value())"

//        monthHeader.layer.cornerRadius = 10

        return monthHeader
    }
}




extension InitialCalendarViewController: UICollectionViewDelegate
{
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! NewDateCell
        
        if cell.dateObject.isEarlierThanOrEqualTo(self.today)
        {
            return true
        }
        
        return false
        
    }
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! NewDateCell
        
        println("Did select")
        
        calendarInfo.setSelectedDate(cell.dateObject)
        
        cell.circleImage.image = UIImage(named: "red")
        
        collectionView.reloadData()

        
    }
    
}









