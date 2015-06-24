////
////  CalendarViewCollectionViewController.swift
////  Eve
////
////  Created by Sangeeta van Beemen on 22/06/15.
////  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
////
//
//import UIKit
////let reuseIdentifier = "dateCell"
//
//
//class NewCalendarView: UICollectionView
//{
//    
//    // variables for size of phone screen and layout of cells
//    let screenSize : CGRect!
//    let screenWidth: CGFloat!
//    let screenHeight: CGFloat!
//    
//    let columns = CGFloat(5)
//    
//    let dateCellSize: CGSize!
//    
//  
//    required init(coder aDecoder: NSCoder)
//    {
//        
//        screenSize = UIScreen.mainScreen().bounds
//        screenWidth = screenSize.width
//        screenHeight = screenSize.height - CGFloat(30)
//        
//        self.dateCellSize = CGSize(width: screenWidth / columns , height: screenWidth / columns)
//
//        
//        super.init(coder: aDecoder)
//        
//    }
//    
//
//    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout)
//    {
//        screenSize = UIScreen.mainScreen().bounds
//        screenWidth = frame.width
//        screenHeight = frame.height
//        dateCellSize = CGSize(width: screenWidth / columns , height: screenWidth / columns)
//        
//        // Set the item size on the layout of collectionView, we want four-column thumbnails
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.itemSize = dateCellSize
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        
//        super.init(frame: frame, collectionViewLayout: layout)
//        
//        
//        
//        backgroundColor = UIColor.whiteColor()
//        alwaysBounceVertical = true
//        
//        registerClass(DateCollectionViewCell.self, forCellWithReuseIdentifier: "dateCell")
//        registerClass(MonthCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "monthCell")
//        
////        
////        registerNib(UINib(nibName: "ThumbnailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ThumbnailCollectionViewCell")
////        registerNib(UINib(nibName: "HeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HeaderCollectionViewCell")
////        registerNib(UINib(nibName: "EmptyListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EmptyListCollectionViewCell")
////        
////        var currentDateIndexPath = self.getIndexPathCurrentDate(self.today)
////        
////        self.scrollToItemAtIndexPath(currentDateIndexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
//    }
//
//    
//    
//    func getIndexPathCurrentDate(date:NSDate) -> NSIndexPath
//    {
//        var sectionInt = date.month.value() + 12
//        
//        var itemInt = date.day.value() - 1
//        
//        var indexPathCurrentDate = NSIndexPath(forItem: itemInt, inSection: sectionInt)
//        
//        return indexPathCurrentDate
//        
//    }
//
//}
