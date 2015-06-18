//
//  CalendarViewController.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 10/06/15 W24.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    // variables for size of phone screen and layout of cells
    let screenSize : CGRect
    let screenWidth: CGFloat!
    let screenHeight: CGFloat!

    // dates to show in view
    var datesToShow: [NSDate]
    
//    var indexPathsSelectedItems = [NSDate]()
    
    // instance of calendar manager
    let calendarInfo: newCalendarManager
    
    
    // collectionview Outlet variable
    @IBOutlet weak var calendarCollectionView: UICollectionView!

    
    // init for screensize
    required init(coder aDecoder: NSCoder)
    {

        screenSize = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height - CGFloat(30)
        
        self.calendarInfo = newCalendarManager()
        
        self.datesToShow = calendarInfo.getMonthValues()
        
        
        super.init(coder: aDecoder)
    }
    
    
    // collectionview protocols init
    override func viewDidLoad()
    {
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
        
        super.viewDidLoad()

    }
    

    
    // amount of items in each section. 1 month is one section
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return datesToShow.count
    }

    
    // collectionview protocol to fill cell with data
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        
        let cell = self.calendarCollectionView.dequeueReusableCellWithReuseIdentifier("calendarCell", forIndexPath: indexPath) as! DateCollectionViewCell
        
        var myIndexPaths = self.calendarCollectionView.indexPathsForSelectedItems()
        
        if find(myIndexPaths, indexPath as! AnyObject)
        {
            
        }

        f ([collectionView.indexPathsForSelectedItems containsObject:indexPath]) {
            [collectionView selectItemAtIndexPath:indexPath animated:FALSE scrollPosition:UICollectionViewScrollPositionNone];
            // Select Cell
        }
        else {
            // Set cell to non-highlight
        }
        

        
        var date = self.datesToShow[indexPath.row].day.value()
        
        cell.dateLabel.text = "\(date)"
        
        cell.dateObject = datesToShow[indexPath.row]
        
        return cell
    }
   
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        let cell = calendarCollectionView.cellForItemAtIndexPath(indexPath) as! DateCollectionViewCell
        
        println(" selected = \(cell.selected)")
        
        if cell.dateObject.isEarlierThanOrEqualTo(calendarInfo.currentDate)
        {
            self.indexPathsSelectedItems.append(cell.dateObject)
            
            println(" DATE LIST SELCTED =\(self.indexPathsSelectedItems)")
            
            
            println(" SHOULD SELECT TRUE")
            return true
        }
        
        println(" SHOULD SELECT FALSE")


        return false
    }
    
    
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath)
    {
        let cell = self.calendarCollectionView.cellForItemAtIndexPath(indexPath) as! DateCollectionViewCell
        

        
        println("cell SELECTED date is = \(cell.dateObject)")
        
    }
    
    func collectionView(collectionView: UICollectionView, shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        let cell = self.calendarCollectionView.cellForItemAtIndexPath(indexPath) as! DateCollectionViewCell
        
        if cell.selected == true
        {
            println(" SHOULD DESELECT TRUE")

            return true
        }
        
        println(" SHOULD SELECT TRUE")

        return false

    }

    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath)
    {
        let cellLayout = cell as! DateCollectionViewCell
        
        cellLayout.tintColorDidChange()
        
        if contains(self.indexPathsSelectedItems, cellLayout.dateObject)
        {
            println(" made blue! \(cellLayout.dateObject)")
            cell.backgroundColor = UIColor.blueColor()
        }
    }
    
    
}

