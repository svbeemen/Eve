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
    
    let calendarInfo: Calendar
    
    // amount of adjecent dates
    let columns = CGFloat(5)

    
    @IBOutlet weak var calendarCollectionView: UICollectionView!

    
    // init for screensize
    required init(coder aDecoder: NSCoder)
    {
        screenSize = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height - CGFloat(60)
        calendarInfo = Calendar()
        
        super.init(coder: aDecoder)
    }
    
    // collectionview protocols init
    override func viewDidLoad()
    {
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
     
        calendarInfo.monthValues()
        calendarInfo.dateValue()
        
        println("inside View")
        println("firstdayMonthObject DAY \(calendarInfo.firstDayOfMonthObject.day())")
        println("firstdayMonthObject MONTH \(calendarInfo.firstDayOfMonthObject.month())")
        println("firstdayMonthObject YEAR \(calendarInfo.firstDayOfMonthObject.year())")
        println("today! \(calendarInfo.todayDate)")
        println("today day \(calendarInfo.todayDate.day())")
        println("today month \(calendarInfo.todayDate.month())")
        println("today year \(calendarInfo.todayDate.year())")
        
        println("firstdayMonthObject \(calendarInfo.firstDayOfMonthObject)")
        
        
        //        calendarCollectionView.registerClass(UICollectionViewController.self, forCellWithReuseIdentifier: "month")
            
        super.viewDidLoad()
    }
    
    
    // amount of sections in collectionview
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        calendarInfo.printValues()
        return 1
    }

        
    // collectionview protocol amount of items in a section. A section will be 1 month.
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return calendarInfo.monthInView.daysInMonth()
    }
    
    // collectionview protocol to fill cell with data
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = self.calendarCollectionView.dequeueReusableCellWithReuseIdentifier("calendarCell", forIndexPath: indexPath) as! DateCollectionViewCell
        
//        println("width Screen \(screenSize.width)")
//        println("height Screen\(screenSize.height)")
//        println("width Cell \(cell.frame.size.width)")
//        println("height Cell \(cell.frame.size.height)")

        var date = indexPath.item + 1

        cell.dateLabel!.text = "\(date)"
//        cell.cellImageView.image = UIImage(named: "circle")
        
        return cell
    }
        
        
    // size of cells
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        var newHeight = CGFloat(calendarInfo.todayDate.daysInMonth()) / columns
        return CGSize(width: screenWidth / columns, height: screenHeight / newHeight)
    }
    
//    func override func collectionView(collectionView: UICollectionView,
//        viewForSupplementaryElementOfKind kind: String,
//        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//            //1
//            switch kind {
//                //2
//            case UICollectionElementKindSectionHeader:
//                //3
//                let headerView =
//                collectionView.dequeueReusableSupplementaryViewOfKind(kind,
//                    withReuseIdentifier: "FlickrPhotoHeaderView",
//                    forIndexPath: indexPath)
//                    as! FlickrPhotoHeaderView
//                headerView.label.text = searches[indexPath.section].searchTerm
//                return headerView
//            default:
//                //4
//                assert(false, "Unexpected element kind")
//            }
//    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
        let monthHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "monthCell", forIndexPath: indexPath) as! monthCollectionReusableView
        
        println("section Height \(monthHeaderView.frame.size.height)")
        println("section Width \(monthHeaderView.frame.size.width)")
        
        
        monthHeaderView.monthLabel.text = calendarInfo.monthNameList[calendarInfo.monthInView.month() - 1] as? String
        return monthHeaderView
    }
    
    // spaces between cells
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 0
    }
        
        
    // spaces between cells
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 0
    }

    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        println("in scroll")
        calendarInfo.monthInView = calendarInfo.firstDayOfMonthObject.dateByAddingMonths(1)
        print("month is \(calendarInfo.monthInView.month())")
        self.calendarCollectionView.reloadData()
//        let offsetY = scrollView.contentOffset.y
//        let contentWidth = scrollView.contentSize.width
//        
//        println("off set is \(offsetY) and contentWidth is \(contentWidth) and scrollView is \(scrollView.frame.size.width)")
//        
//        if offsetY > contentWidth - scrollView.frame.size.width
//        {
//            calendarInfo.monthInView = calendarInfo.firstDayOfMonthObject.dateByAddingMonths(1)
//            print("month is \(calendarInfo.monthInView.month())")
//            self.calendarCollectionView.reloadData()
//        }
//
//
//        
    }
}
    


