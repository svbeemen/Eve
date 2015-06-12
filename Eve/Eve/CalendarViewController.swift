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
    
    // variables for screen size to create layout
    let screenSize : CGRect
    let screenWidth: CGFloat!
    let screenHeight: CGFloat!
    
    let counter: Int = 0
    
    let calendarInfo: Calendar
    
    // amount of adjecent dates
    let columns = CGFloat(5)

    
    @IBOutlet weak var calendarCollectionView: UICollectionView!

    
    // init for screensize
    required init(coder aDecoder: NSCoder)
    {
        screenSize = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height - CGFloat(30)
        calendarInfo = Calendar()

        
        super.init(coder: aDecoder)
    }
    
    // collectionview protocols init
    override func viewDidLoad()
    {
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
     
//        calendarInfo.monthValues()
//        calendarInfo.dateValue()
        //        calendarCollectionView.registerClass(UICollectionViewController.self, forCellWithReuseIdentifier: "month")
            
        super.viewDidLoad()
    }
    
    
    // amount of sections in collectionview
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        println("in num sections")
//        calendarInfo.printValues()
        return calendarInfo.monthNameList.count
    }

        
    // collectionview protocol amount of items in a section. A section will be 1 month.
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        var days = calendarInfo.monthDays()[section]
        return days
    }

    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        println("size header month")
        
        return CGSize(width: screenWidth, height: CGFloat(50))
    }
    
    
    // collectionview protocol to fill cell with data
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        println("in content for cell sections")
        
        let cell = self.calendarCollectionView.dequeueReusableCellWithReuseIdentifier("calendarCell", forIndexPath: indexPath) as! DateCollectionViewCell

        var date = indexPath.item + 1

        cell.dateLabel!.text = "\(date)"
        
        return cell
    }
        
        
    // size of cells
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        println("in size of cell")
        
        return CGSize(width: screenWidth / columns, height: CGFloat(screenHeight / 8))
    }
    

    
    // uncommecnt for month name
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
        println("content month header")
        
        let monthHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "monthCell", forIndexPath: indexPath) as! monthCollectionReusableView
        
        monthHeaderView.monthLabel.text = calendarInfo.monthNameList[indexPath.section] as? String
        
        println("monthLabelText = \(monthHeaderView.monthLabel.text)")
        
        return monthHeaderView
    }
    
    
    
    // spaces between cells
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        println("spaces for interitem section")
        return 0
    }
        
        
    // spaces between cells
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        println("spaces for section")
        return 0
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        println("in did select")
        
        let cell = self.calendarCollectionView.cellForItemAtIndexPath(indexPath) as! DateCollectionViewCell
        
        cell.dateLabel.textColor = UIColor.blueColor()
        
        var cellSection = indexPath.section
        
        var month: AnyObject = calendarInfo.monthNameList[cellSection]
        
        println("text date\(cell.dateLabel.text!) and index path \(month)")
        
//        cellLayout?.highlighted = true
//        cellLayout = UIColor.blueColor()
//        println("hightlight = \(cellLayout!.highlighted)")
        

    }
    


    
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
}
    


