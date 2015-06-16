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
    // variables for size of phone screen
    let screenSize : CGRect
    let screenWidth: CGFloat!
    let screenHeight: CGFloat!

    let calendarInfo: newCalendarManager
    var calendarYearsToShow: [NSDate]
    var calendarMonthsToShow: [[NSDate]]
    var monthNames: [AnyObject]
    var calendarToday: NSDate
    
    var indexPathToday: NSIndexPath
    
    
    // amount of adjecent dates
    let columns = CGFloat(7)

    // collectionview Outlet variable
    @IBOutlet weak var calendarCollectionView: UICollectionView!

    
    // init for screensize
    required init(coder aDecoder: NSCoder)
    {

        screenSize = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height - CGFloat(30)
        
        calendarInfo = newCalendarManager()
        calendarYearsToShow = calendarInfo.yearsToView()
        calendarMonthsToShow = calendarInfo.getMonthValues(calendarYearsToShow)
        monthNames = calendarInfo.monthNames
        calendarToday = calendarInfo.currentDate
        
        indexPathToday = NSIndexPath(forItem: calendarToday.day.value() - 1, inSection: calendarToday.month.value() - 1)

        super.init(coder: aDecoder)
    }
    
    
    // collectionview protocols init
    override func viewDidLoad()
    {
        println("view did load")
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
        
        println("cell index today = \(calendarCollectionView.cellForItemAtIndexPath(indexPathToday))")
        println(" item index = \(indexPathToday.item) and section index = \(indexPathToday.section)")
//        calendarCollectionView.scrollToItemAtIndexPath(indexPathToday!, atScrollPosition: .CenteredVertically, animated: true)
        
        super.viewDidLoad()
        
        //        calendarCollectionView.registerClass(UICollectionViewController.self, forCellWithReuseIdentifier: "month")
    }
    

    // amount of sections in collectionview. 3 years will be shown
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        println("number of sections \(calendarMonthsToShow.count)")
        return calendarMonthsToShow.count
    }

        
    // amount of items in each section. 1 month is one section
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        var days = calendarMonthsToShow[section].count
        return days
    }

    
    // collectionview protocol to fill cell with data
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
//        println("in content for cell sections")
        
        let cell = self.calendarCollectionView.dequeueReusableCellWithReuseIdentifier("calendarCell", forIndexPath: indexPath) as! DateCollectionViewCell
        
        var date = calendarMonthsToShow[indexPath.section][indexPath.item].day.value()
//        
//        println("indexPath Item = \(indexPath.item)")
//        println("indexPath section = \(indexPath.section)")
//        
        cell.dateLabel.text = "\(date)"
        
        cell.dateObject = calendarMonthsToShow[indexPath.section][indexPath.item]
        
        if selectedDateCellIndexPath == indexPath
        {
            cell.backgroundColor = UIColor.blueColor()
        }
        
//        if cell.dateObject == calendarToday
//        {
////            println("dateObject == Today, \(calendarToday) = \(cell.dateObject)")
//            cell.backgroundColor = UIColor.blackColor()
//        }
//      
        println("cell date object = \(cell.dateObject)")
        return cell
    }
    
    
    // name of month in header
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
        println("content month header")
        
        let monthHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "monthCell", forIndexPath: indexPath) as! monthCollectionReusableView
        
        var monthNameIndex = calendarMonthsToShow[indexPath.section][0].month.value()
        
        var yearOfMonth = calendarMonthsToShow[indexPath.section][0].year.value()
        
        var monthName: AnyObject = monthNames[monthNameIndex - 1]
        
        monthHeaderView.monthLabel.text = "\(monthName) \(yearOfMonth)"
        
        println("monthLabelText = \(monthHeaderView.monthLabel.text)")
        
        return monthHeaderView
    }
    
    

    
//    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool
//    {
//        println("in should select")
//        
//        let cellSelect = self.calendarCollectionView.cellForItemAtIndexPath(indexPath) as! DateCollectionViewCell
//        
//        cellSelect.backgroundColor = UIColor.blueColor()
//
//        return true
//        
//        //        println("text date\(cellSelect.dateLabel.text!) and month section is \(cellSelect.dateObject.month.value())")
//        //        println("indexPath.section = \(indexPath.section), indexPath.item = \(indexPath.item)")
//        //        println("NEWindexPath.section = \(newIndexPath.section), NEWindexPath.item = \(newIndexPath.item)")
//        //
//        //        println("old indexPath = \(indexPath)")
//        //        println("new indexPAth = \(newIndexPath)")
//    }
    
//    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
//        let myCell = cell as! DateCollectionViewCell
//    
//        if myCell.dateObject.year() == calendarToday.year()
//        {
//            if myCell.dateObject.month() == calendarToday.month()
//            {
//                if myCell.dateObject.day() == calendarToday.day()
//                {
//                    myCell.backgroundColor = UIColor.brownColor()
//                }
//            }
//            
//        }
//    }

    
    
//    // size of cells
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
//    {
//        println("in size of cell")
//            
//        var cellDimension = screenWidth / columns
//    
//        return CGSize(width: cellDimension, height: cellDimension)
//    }
//    
//    // size of header
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
//    {
//        println("size header month")
//        
//        return CGSize(width: screenWidth, height: CGFloat(50))
//    }

    
    // tutorial
    //1
    var selectedDateCellIndexPath : NSIndexPath?
    {
        didSet
        {
            //2
            var indexPaths = [NSIndexPath]()

            if selectedDateCellIndexPath != nil
            {
//                println("append indexpatrhs")
                indexPaths.append(selectedDateCellIndexPath!)
            }
    
            if oldValue != nil
            {
//                println("old value")
                indexPaths.append(oldValue!)
            }
    
            //3
            self.calendarCollectionView.performBatchUpdates({
//                println("perforn BatchUpdates")
                self.calendarCollectionView.reloadItemsAtIndexPaths(indexPaths)
                return
            })
            {
                completed in
                //4
                if self.selectedDateCellIndexPath != nil
                {
//                    println("performBatchupdates annitmate scroll to")
                    self.calendarCollectionView.scrollToItemAtIndexPath(self.selectedDateCellIndexPath!, atScrollPosition: .CenteredVertically, animated: true)
                }
            }
        }
    }
    
    
    
    // tutorial
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        let cell = self.calendarCollectionView.cellForItemAtIndexPath(indexPath) as! DateCollectionViewCell
        println("should be selected date object = \(cell.dateObject)")
        
        println("in should select")
        if selectedDateCellIndexPath == indexPath
        {
            println("UNSELECT")
            selectedDateCellIndexPath = nil
            calendarInfo.removeMenstruationDate(cell.dateObject)
        }
        else
        {
            println("SELECT")
            selectedDateCellIndexPath = indexPath
            calendarInfo.setMenstruationDate(cell.dateObject)
        }
        return false
    }
    
}
    
    
    
    
    

    
    

    

        
        
//    // size of cells
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
//    {
//        println("in size of cell")
//        
//        return CGSize(width: screenWidth / columns, height: CGFloat(screenHeight / 8))
//    }
    

    

    
    
    
//    // spaces between cells
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
//    {
//        println("spaces for interitem section")
//        return 0
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
//    {
//        return CGFloat(0.0)
//    }
//    
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
//        return CGFloat(0)
//    }
//        
//    // spaces between cells
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
//    {
//        println("spaces for section")
//        return 0
//    }

    

//    
//    
//
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
//    {
//        println("in size of cell")
//        let dimension = CGFloat(screenWidth / 7)
//        
//        if indexPath == largeDateCellIndexPath
//        {
//            println("in size of cell BIG")
//            
//            var bigCellSize = collectionView.bounds.size
//            bigCellSize.height -= CGFloat(50)
//            bigCellSize.width -= CGFloat(50)
////            var size = collectionView.bounds.size
////            size.height -= topLayoutGuide.length
////            size.height -= (sectionInsets.top + sectionInsets.right)
////            size.width -= (sectionInsets.left + sectionInsets.right)
//            
//            return bigCellSize
//        }
//        
//        println("in size of cell NORMAL")
//        return CGSize(width: dimension, height: dimension)
//    }
//        
//
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,insetForSectionAtIndex section: Int) -> UIEdgeInsets
//    {
//        var newSpaces = UIEdgeInsetsZero
//        
//        return newSpaces
//    }
//    
//    
//    
//    // tutorial
//    //1
//    var largeDateCellIndexPath : NSIndexPath?
//    {
//        didSet
//        {
//            //2
//            var indexPaths = [NSIndexPath]()
//            
//            if largeDateCellIndexPath != nil
//            {
//                println("append indexpatrhs")
//                indexPaths.append(largeDateCellIndexPath!)
//            }
//            
//            if oldValue != nil
//            {
//                println("old value")
//                indexPaths.append(oldValue!)
//            }
//            
//            //3
//            self.calendarCollectionView.performBatchUpdates({
//                println("perforn BatchUpdates")
//                self.calendarCollectionView.reloadItemsAtIndexPaths(indexPaths)
//                return
//            })
//            {
//                completed in
//                //4
//                if self.largeDateCellIndexPath != nil
//                {
//                    println("performBatchupdates annitmate scroll to")
//                    self.calendarCollectionView.scrollToItemAtIndexPath(self.largeDateCellIndexPath!, atScrollPosition: .CenteredVertically, animated: true)
//                }
//            }
//        }
//    }
//    
//    
//    // tutorial
//    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool
//    {
//        println("in should select")
//        if largeDateCellIndexPath == indexPath
//        {
//            println("in should select / if {largeDateCellIndex == indexpath")
//            largeDateCellIndexPath = nil
//        }
//        else
//        {
//            println("in should select / else { ")
//            largeDateCellIndexPath = indexPath
//        }
//        return false
//
//    }
//    
//
//}




    
//    
//    func scrollViewDidScroll(scrollView: UIScrollView)
//    {
//        println("in scroll")
//        let offsetX = scrollView.contentOffset.x
//        let contentWidth = scrollView.contentSize.width
//        let test = scrollView.frame.size.width
//        
//        calendarInfo.todayDate = calendarInfo.todayDate.dateByAddingMonths(1)
//        
//        print("new TODAY day is \(calendarInfo.todayDate.day())")
//        print("new TODAY month is \(calendarInfo.todayDate.month())")
//        print("new TODAY year is \(calendarInfo.todayDate.year())")
//        
//        self.calendarCollectionView.reloadData()
//        
//
////        self.calendarCollectionView.reloadData()
////        let offsetY = scrollView.contentOffset.y
////        let contentWidth = scrollView.contentSize.width
////        
////        println("off set is \(offsetY) and contentWidth is \(contentWidth) and scrollView is \(scrollView.frame.size.width)")
////        
////        if offsetY > contentWidth - scrollView.frame.size.width
////        {
////            calendarInfo.monthInView = calendarInfo.firstDayOfMonthObject.dateByAddingMonths(1)
////            print("month is \(calendarInfo.monthInView.month())")
////            self.calendarCollectionView.reloadData()
////        }
////
////
////        
//    }

    


