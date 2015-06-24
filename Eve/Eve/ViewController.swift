////
////  ViewController.swift
////  Eve
////
////  Created by Sangeeta van Beemen on 23/06/15.
////  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
////
//
//import UIKit
//
//class ViewController: UIViewController
//{
//    
////    @IBOutlet weak var CalendarView: UICollectionView!
//
//    let calendarInfo: CalendarClass!
//    
//    let datesToShow: [[NSDate]]!
//    
//    
//    @IBOutlet weak var calendarView: UICollectionView!
//    
//    
//    required init(coder aDecoder: NSCoder)
//    {
//
//        calendarInfo = CalendarClass()
//        
//        datesToShow = calendarInfo.getDates()
//        
//        super.init(coder: aDecoder)
//       
//    }
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//
//
//extension ViewController: UICollectionViewDataSource
//{
//    
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
//    {
//        return datesToShow.count
//    }
//
//    
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
//    {
//        var daysInMonth = datesToShow[section].count
//        
//        return daysInMonth
//    }
//    
//
//    
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
//    {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("dateCell", forIndexPath: indexPath) as! DateCollectionViewCell
//        
//        cell.dateLabel.text = "\(datesToShow[indexPath.section][indexPath.item])"
//        
//        
//        
//        println(" cell lauyout = \(cell.frame.size)")
//        
//        return cell
//        
//    }
//    
//    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
//    {
//        let monthHeader = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "monthHeader", forIndexPath: indexPath) as! MonthCollectionReusableView
//        
//        return monthHeader
//    }
//    
//    
//
//
////    func collectionView(collectionView: CalendarCollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
////        
////   
////        
////        // Otherwise create four column thumbnails.
////        return collectionView.thumbnailSize
////    }
//
//    
//}
//
//
//
//extension ViewController: UICollectionViewDelegate
//{
//    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return false
//    }
//    
//
//}
//
//
//
//extension ViewController: UICollectionViewDelegateFlowLayout
//{
////    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
////        return CGFloat(1)
////    }
////    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return CGSize(width: 75, height: 75)
//    }
//    
//
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
