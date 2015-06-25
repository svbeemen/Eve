////
////  MainViewController.swift
////  Eve
////
////  Created by Sangeeta van Beemen on 23/06/15.
////  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
////
//
//import UIKit
//
//class MainViewController: UIViewController {
//
//    @IBOutlet weak var calendarView: UICollectionView!
//    
//    @IBOutlet weak var menuButton: UIBarButtonItem!
//    
//    @IBAction func goToMenu(sender: UIBarButtonItem)
//    {
//        calendarInfo.calculateValues()
//        calendarView.reloadData()
//        
//    }
//    
//    
//    var calendarInfo: CalendarClass!
//    
//    var dateObjects: [[NSDate]]!
//
//    var today: NSDate!
//    
//    
//    var cellObject: NewDate!
//    
//    var cellDateObject: NSDate!
//    
//    var cellImage: UIImage!
//    
//    required init(coder aDecoder: NSCoder)
//    {
//                
////        calendarInfo = calendarInfo
////        
////        dateObjects = calendarInfo.getDates()
////        
////        today = calendarInfo.currentDate
////        
//        super.init(coder: aDecoder)
//        
//    }
//    
//    
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//        
//        
//        dateObjects = calendarInfo.getDates()
//        
//        today = calendarInfo.currentDate
//        
//        calendarInfo.calculateValues()
//
//        
//        var todayIndexSection = today.month.value() + 11
//        
//        var todayIndexItem = today.day.value() - 1
//        
//        var todayIndexPAth = NSIndexPath(forItem: todayIndexItem, inSection: todayIndexSection)
//        
//        self.calendarView.scrollToItemAtIndexPath(todayIndexPAth, atScrollPosition: UICollectionViewScrollPosition.CenteredVertically, animated: true)
//    }
//
//    
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//
//        
//        if(segue.identifier == "detail")
//        {
//
//            
//            var yourNextViewController = (segue.destinationViewController as! DetailViewController)
//            yourNextViewController.cellImage = cellImage
//            yourNextViewController.cellDateObject = cellDateObject
//            yourNextViewController.cellObject = cellObject
//            
//            
//            yourNextViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
//        }
//    }
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
//extension MainViewController: UICollectionViewDataSource
//{
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
//    {
//        return dateObjects.count
//    }
//
//
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
//    {
//        var daysInMonth = dateObjects[section].count
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
//        
//        cell.dateObject = dateObjects[indexPath.section][indexPath.item]
//        
//        
//        if contains(calendarInfo.cycleManager.pastMenstruationDates, cell.dateObject) || contains(calendarInfo.cycleManager.predictedMenstrautionDates, cell.dateObject)
//        {
//            cell.circleImage.image = UIImage(named: "red")
//            cell.circleImage.layer.borderWidth = CGFloat(0)
//        }
//        else if contains(calendarInfo.cycleManager.predictedFertileDates, cell.dateObject)
//        {
//            cell.circleImage.image = UIImage(named: "darBlue")
//            cell.circleImage.layer.borderWidth = CGFloat(0)
//        }
//        else
//        {
//            cell.circleImage.image = UIImage(named: "blue")
//            cell.circleImage.layer.borderWidth = CGFloat(0)
//            
//        }
//        
//        
//        if cell.dateObject.isToday()
//        {
//            cell.circleImage.layer.borderWidth = CGFloat(2)
//            cell.circleImage.layer.borderColor = UIColor.blackColor().CGColor
//        }
//    
//        cell.dateLabel.text = "\(cell.dateObject.day.value())"
//        
//    
//        
//    
//        return cell
//    
//    }
//
//    
//    
//    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
//    {
//        let monthHeader = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "monthHeader", forIndexPath: indexPath) as! MonthCollectionReusableView
//        
//        monthHeader.dateObject = self.dateObjects[indexPath.section].first!
//        
//        monthHeader.monthLabel.text = "\(self.calendarInfo.monthNames[monthHeader.dateObject.month.value() - 1])"
////        \(monthHeader.dateObject.year.value())"
////
////        monthHeader.layer.cornerRadius = 10
////        
////        monthHeader.frame.size = CGSize(width: 100, height: 50)
//
//    
//        return monthHeader
//    }
//}
//
//
//extension MainViewController: UICollectionViewDelegate
//{
//    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool
//    {
//        let cell = calendarView.cellForItemAtIndexPath(indexPath) as! DateCollectionViewCell
//        
//        if cell.dateObject.isEarlierThanOrEqualTo(self.today)
//        {
//            cellDateObject = cell.dateObject
//            cellImage = cell.circleImage.image
//            
//            cellObject = cell
//            
//            return true
//        }
//        
//        return false
//
//    }
//    
//    
//    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
//    {
//     
//        let cell = calendarView.cellForItemAtIndexPath(indexPath) as! DateCollectionViewCell
//        
//        println("Did select")
//        
//        calendarInfo.setSelectedDate(cell.dateObject)
//        
//        cell.circleImage.image = UIImage(named: "red")
//        
//        calendarView.reloadData()
//        
//        
//        cellDateObject = cell.dateObject
//        
//        cellImage = cell.circleImage.image
//        
////        
////        let detailView = DetailViewController()
////        
////        detailView.cellImage = cell.circleImage.image
//        
//        calendarView.reloadData()
//        
//    }
//
//}
//
//
//extension MainViewController: UICollectionViewDelegateFlowLayout
//{
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
//    {
//        var cellSize = CGSize(width: view.frame.width / 5, height: view.frame.width / 5)
//        
//        return cellSize
//    }
//    
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
//    {
//        var headerSize = CGSize(width: 200, height: 30)
//        
//        return headerSize
//    }
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
//
//
//
//
//
