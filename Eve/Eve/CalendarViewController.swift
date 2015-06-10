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
        screenHeight = screenSize.height
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
        
        //        calendarCollectionView.registerClass(UICollectionViewController.self, forCellWithReuseIdentifier: "month")
            
        super.viewDidLoad()
    }
        
        
    // collectionview protocol amount of sections (1 date is 1 section)
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return calendarInfo.daysInCurrentYear
    }
        
        
    // collectionview protocol to fill cell with data
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = self.calendarCollectionView.dequeueReusableCellWithReuseIdentifier("calendarCell", forIndexPath: indexPath) as! DateCollectionViewCell

        var date = calendarInfo.dateList[indexPath.item]
        println(calendarInfo.monthValuesList)
        cell.dateLabel!.text = "\(date)"
        return cell
        
        //        let header = self.calendarCollectionView.dequeueReusableSupplementaryViewOfKind(collectionView, withReuseIdentifier: "month", forIndexPath: NSIndexPath.self)
            
    }
        
        
    // size of cells
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
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
    


