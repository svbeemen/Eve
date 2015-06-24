////
////  NewViewController.swift
////  Eve
////
////  Created by Sangeeta van Beemen on 22/06/15.
////  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
////
//
//import UIKit
//
//class NewViewController: UIViewController
//{
//    
//    var collectionView: NewCalendarView!
//    
//    var calendarInfo: newCalendarManager!
//    
//    var datesToShow: [[NSDate]]!
//    
//    var currentDate = NSDate()
//    
//    
//    
//    required init(coder aDecoder: NSCoder)
//    {
//        collectionView = NewCalendarView(coder: aDecoder)
//        
//        self.calendarInfo = newCalendarManager()
//        self.datesToShow = calendarInfo.getDates()
//        
//        super.init(coder: aDecoder)
//    }
//    
//    
//    override func viewDidLoad()
//    {
//
//        super.viewDidLoad()
//        
////        collectionView = NewCalendarView(coder: NSCoder())
//        collectionView!.dataSource = self
//        collectionView!.delegate = self
//        self.view.addSubview(collectionView!)
//
//    }
//
//}
//
//
//extension NewViewController: UICollectionViewDataSource {
//    
//    // There are four sections in the collectionView: Header, thumbnails, header, thumbnails.
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return self.datesToShow.count
//    }
//    
//    // Returns the length of each section.
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        
//        return self.datesToShow[section].count
//    }
//    
//    // Returns the cell to be rendered.
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
//    {
//        
//        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("calendarCell", forIndexPath: indexPath) as! DateCollectionViewCell
//        
//        var date = self.datesToShow[indexPath.section][indexPath.item].day.value()
//        
//        cell.dateLabel.text = "\(date)"
//        
//        cell.dateObject = datesToShow[indexPath.section][indexPath.item]
//        
//        
//        // make red if date is a menstruation date
//        if contains(self.calendarInfo.cycleManager.menstrautionDates, cell.dateObject) || contains(self.calendarInfo.selectedDates, cell.dateObject)
//        {
//            cell.contentView.backgroundColor = UIColor.redColor()
//        }
//        else if contains(self.calendarInfo.cycleManager.fertileDates, cell.dateObject)
//        {
//            cell.contentView.backgroundColor = UIColor.darkGrayColor()
//        }
//        else
//        {
//            cell.contentView.backgroundColor = UIColor.greenColor()
//        }
//        
//        
//        cell.contentView.layer.cornerRadius = 32.5
//        
//        return cell
//    }
//
//    
////    // Returns size of cell.
////    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
////        
////        
////        // Otherwise create four column thumbnails.
////        return collectionView
////    }
//}
//
//extension NewViewController: UICollectionViewDelegate {
//    
//    // If a cell can be selected.
//    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return false
//    }
//}