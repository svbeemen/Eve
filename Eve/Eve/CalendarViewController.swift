//
//  CalendarViewController.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 02/06/15 W23.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit
import CVCalendarKit

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    // the collectionview
    @IBOutlet weak var calendarCollectionView: UICollectionView!

    
    // variables for screen size to create layout
    let screenSize : CGRect
    let screenWidth: CGFloat!
    let screenHeight: CGFloat!
    let iphoneCal: CalendarInfo
    
    // amount of adjecent dates
    let columns = CGFloat(5)
    
//    // temp hardcode dates
//    let dates = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28]
    
    
    // init for screensize
    required init(coder aDecoder: NSCoder)
    {
        screenSize = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        self.iphoneCal = CalendarInfo()
        
        super.init(coder: aDecoder)
    }
    
    
    // collectionview protocols init
    override func viewDidLoad()
    {
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
        iphoneCal.getMonthData()
        
//        calendarCollectionView.registerClass(UICollectionViewController.self, forCellWithReuseIdentifier: "month")
        
        super.viewDidLoad()
    }
    
    
    // collectionview protocol amount of sections (1 date is 1 section)
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        var test = iphoneCal.monthData
        var amountCells = iphoneCal.monthData
//        return self.dates.count
    }
    
    
    // collectionview protocol to fill cell with data
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = self.calendarCollectionView.dequeueReusableCellWithReuseIdentifier("CalendarCell", forIndexPath: indexPath) as! DateCollectionViewCell
        
        // set label to hard coded dates
        var tom = today.day + 1
        println(tom)
        var date = self.dates[indexPath.item]
        cell.dateLabel!.text = "\(date) and \(tom)"
        return cell
        
        //        let header = self.calendarCollectionView.dequeueReusableSupplementaryViewOfKind(collectionView, withReuseIdentifier: "month", forIndexPath: NSIndexPath.self)
        
    }
    
    
    // size of cells
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
         return CGSize(width: screenWidth / columns, height: screenWidth / columns)
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
    
}

