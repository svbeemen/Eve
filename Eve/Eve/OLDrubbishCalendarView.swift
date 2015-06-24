//////
//////  rubbishCalendarView.swift
//////  Eve
//////
//////  Created by Sangeeta van Beemen on 16/06/15 W25.
//////  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//////
////
////import Foundation
//////
//////  CalendarViewController.swift
//////  Eve
//////
//////  Created by Sangeeta van Beemen on 10/06/15 W24.
//////  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//////
////
////import UIKit
////
////class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
////{
////    
////    private let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
////    
////    private var months: NSArray
////    
////    // variables for screen size to create layout
////    let screenSize : CGRect
////    let screenWidth: CGFloat!
////    let screenHeight: CGFloat!
////    
////    let counter: Int = 0
////    
////    let calendarInfo: Calendar
////    
////    // amount of adjecent dates
////    let columns = CGFloat(5)
////    
////    
////    // testing variable
////    var testingClass: newCalendarManager
////    var testingYearList: [NSDate]
////    
////    
////    @IBOutlet weak var calendarCollectionView: UICollectionView!
////    
////    
////    // init for screensize
////    required init(coder aDecoder: NSCoder)
////    {
////        
////        screenSize = UIScreen.mainScreen().bounds
////        screenWidth = screenSize.width
////        screenHeight = screenSize.height - CGFloat(30)
////        calendarInfo = Calendar()
////        months = calendarInfo.monthNameList
////        
////        // test for class
////        testingClass = newCalendarManager()
////        testingYearList = testingClass.monthsToView()
////        testingClass.getMonthValues(testingYearList)
////        
////        
////        super.init(coder: aDecoder)
////    }
////    
////    // collectionview protocols init
////    override func viewDidLoad()
////    {
////        calendarCollectionView.delegate = self
////        calendarCollectionView.dataSource = self
////        
////        //        calendarInfo.monthValues()
////        //        calendarInfo.dateValue()
////        //        calendarCollectionView.registerClass(UICollectionViewController.self, forCellWithReuseIdentifier: "month")
////        
////        super.viewDidLoad()
////    }
////    
////    
////    // amount of sections in collectionview
////    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
////    {
////        println("in num sections")
////        //        calendarInfo.printValues()
////        return calendarInfo.monthNameList.count
////    }
////    
////    
////    // collectionview protocol amount of items in a section. A section will be 1 month.
////    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
////    {
////        var days = calendarInfo.monthDays()[section]
////        return days
////    }
////    
////    
////    
////    
////    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
////    {
////        println("size header month")
////        
////        return CGSize(width: screenWidth, height: CGFloat(50))
////    }
////    
////    
////    // collectionview protocol to fill cell with data
////    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
////    {
////        println("in content for cell sections")
////        
////        let cell = self.calendarCollectionView.dequeueReusableCellWithReuseIdentifier("calendarCell", forIndexPath: indexPath) as! DateCollectionViewCell
////        
////        var date = indexPath.item + 1
////        
////        cell.dateLabel!.text = "\(date)"
////        
////        cell.dateLabel.frame = cell.frame
////        
////        cell.dateLabel.textRectForBounds(cell.bounds, limitedToNumberOfLines: 5)
////        
////        cell.dateLabel.drawTextInRect(cell.dateLabel.frame)
////        
////        cell.activityIndicator.stopAnimating()
////        
////        if indexPath != largeDateCellIndexPath
////        {
////            println("in not indexpath larg cell")
////            //            cell.dateLabel.textRectForBounds(cell.bounds, limitedToNumberOfLines: 1)
////            return cell
////        }
////        
////        cell.activityIndicator.startAnimating()
////        
////        //8
////        if indexPath == self.largeDateCellIndexPath
////        {
////            println("in 1st indexpath == larg cell")
////            cell.backgroundColor = UIColor.blackColor()
////            if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? DateCollectionViewCell
////            {
////                cell.backgroundColor = UIColor.blackColor()
////                println("in 2st indexpath == larg cell")
////                //                cell.dateLabel.textRectForBounds(cell.bounds, limitedToNumberOfLines: 1)
////            }
////        }
////        
////        return cell
////    }
////    
////    
////    
////    
////    //    // size of cells
////    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
////    //    {
////    //        println("in size of cell")
////    //
////    //        return CGSize(width: screenWidth / columns, height: CGFloat(screenHeight / 8))
////    //    }
////    
////    
////    
////    // uncommecnt for month name
////    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
////    {
////        println("content month header")
////        
////        let monthHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "monthCell", forIndexPath: indexPath) as! monthCollectionReusableView
////        
////        monthHeaderView.monthLabel.text = calendarInfo.monthNameList[indexPath.section] as? String
////        
////        println("monthLabelText = \(monthHeaderView.monthLabel.text)")
////        
////        return monthHeaderView
////    }
////    
////    
////    
////    //    // spaces between cells
////    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
////    //    {
////    //        println("spaces for interitem section")
////    //        return 0
////    //    }
////    
////    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
////    {
////        return CGFloat(0.0)
////    }
////    
////    
////    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
////        return CGFloat(0)
////    }
////    
////    //    // spaces between cells
////    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
////    //    {
////    //        println("spaces for section")
////    //        return 0
////    //    }
////    
////    
////    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
////    {
////        println("in did select")
////        
////        let cell = self.calendarCollectionView.cellForItemAtIndexPath(indexPath) as! DateCollectionViewCell
////        
////        cell.dateLabel.textColor = UIColor.blueColor()
////        
////        var cellSection = indexPath.section
////        
////        println("text date\(cell.dateLabel.text!) and month section is \(calendarInfo.monthNameList[cellSection])")
////        
////        println("indexPath = \(indexPath)")
////    }
////    
////    
////    
////    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
////    {
////        println("in size of cell")
////        let dimension = CGFloat(screenWidth / 7)
////        
////        if indexPath == largeDateCellIndexPath
////        {
////            println("in size of cell BIG")
////            
////            var bigCellSize = collectionView.bounds.size
////            bigCellSize.height -= CGFloat(50)
////            bigCellSize.width -= CGFloat(50)
////            //            var size = collectionView.bounds.size
////            //            size.height -= topLayoutGuide.length
////            //            size.height -= (sectionInsets.top + sectionInsets.right)
////            //            size.width -= (sectionInsets.left + sectionInsets.right)
////            
////            return bigCellSize
////        }
////        
////        println("in size of cell NORMAL")
////        return CGSize(width: dimension, height: dimension)
////    }
////    
////    
////    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,insetForSectionAtIndex section: Int) -> UIEdgeInsets
////    {
////        var newSpaces = UIEdgeInsetsZero
////        
////        return newSpaces
////    }
////    
////    
////    
////    // tutorial
////    //1
////    var largeDateCellIndexPath : NSIndexPath?
////        {
////        didSet
////        {
////            //2
////            var indexPaths = [NSIndexPath]()
////            
////            if largeDateCellIndexPath != nil
////            {
////                println("append indexpatrhs")
////                indexPaths.append(largeDateCellIndexPath!)
////            }
////            
////            if oldValue != nil
////            {
////                println("old value")
////                indexPaths.append(oldValue!)
////            }
////            
////            //3
////            self.calendarCollectionView.performBatchUpdates({
////                println("perforn BatchUpdates")
////                self.calendarCollectionView.reloadItemsAtIndexPaths(indexPaths)
////                return
////                })
////                {
////                    completed in
////                    //4
////                    if self.largeDateCellIndexPath != nil
////                    {
////                        println("performBatchupdates annitmate scroll to")
////                        self.calendarCollectionView.scrollToItemAtIndexPath(self.largeDateCellIndexPath!, atScrollPosition: .CenteredVertically, animated: true)
////                    }
////            }
////        }
////    }
////    
////    
////    // tutorial
////    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool
////    {
////        println("in should select")
////        if largeDateCellIndexPath == indexPath
////        {
////            println("in should select / if {largeDateCellIndex == indexpath")
////            largeDateCellIndexPath = nil
////        }
////        else
////        {
////            println("in should select / else { ")
////            largeDateCellIndexPath = indexPath
////        }
////        return false
////        
////    }
////    
////    
////}
////
////
////
////
////
//////
//////    func scrollViewDidScroll(scrollView: UIScrollView)
//////    {
//////        println("in scroll")
//////        let offsetX = scrollView.contentOffset.x
//////        let contentWidth = scrollView.contentSize.width
//////        let test = scrollView.frame.size.width
//////
//////        calendarInfo.todayDate = calendarInfo.todayDate.dateByAddingMonths(1)
//////
//////        print("new TODAY day is \(calendarInfo.todayDate.day())")
//////        print("new TODAY month is \(calendarInfo.todayDate.month())")
//////        print("new TODAY year is \(calendarInfo.todayDate.year())")
//////
//////        self.calendarCollectionView.reloadData()
//////
//////
////////        self.calendarCollectionView.reloadData()
////////        let offsetY = scrollView.contentOffset.y
////////        let contentWidth = scrollView.contentSize.width
////////
////////        println("off set is \(offsetY) and contentWidth is \(contentWidth) and scrollView is \(scrollView.frame.size.width)")
////////
////////        if offsetY > contentWidth - scrollView.frame.size.width
////////        {
////////            calendarInfo.monthInView = calendarInfo.firstDayOfMonthObject.dateByAddingMonths(1)
////////            print("month is \(calendarInfo.monthInView.month())")
////////            self.calendarCollectionView.reloadData()
////////        }
////////
////////
////////        
//////    }
////
////
////
////
//
//
////
////  CalendarViewController.swift
////  Eve
////
////  Created by Sangeeta van Beemen on 10/06/15 W24.
////  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
////
//
//
//let savedSettings = NSUserDefaults.standardUserDefaults()
//
//import UIKit
//
//class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
//{
//    // variables for size of phone screen and layout of cells
//    let screenSize : CGRect
//    let screenWidth: CGFloat!
//    let screenHeight: CGFloat!
//    
//    //    let helloView: UIVisualEffectView!
//    //
//    //    let blurEffect: UIBlurEffect!
//    //
//    //    let helloLabel: UILabel!
//    
//    let instructionSubView: UIView!
//    
//    
//    // dates to show in view
//    var datesToShow: [[NSDate]]
//    
//    @IBOutlet weak var blurView: UIVisualEffectView!
//    var selectedDates: [NSDate]
//    
//    // instance of calendar manager
//    let calendarInfo: newCalendarManager
//    
//    // variable to indicate calendar is empty. has not been used before
//    var initialCalendarState: Bool
//    
//    @IBOutlet weak var setDateButton: UIButton!
//    
//    
//    // collectionview Outlet variable
//    @IBOutlet weak var calendarCollectionView: UICollectionView!
//    
//    
//    @IBAction func setDates(sender: UIButton)
//    {
//        self.calendarInfo.cycleManager.calculateCycle(self.calendarInfo.lastCalendarDate)
//        self.calendarCollectionView.reloadData()
//        
//        
//        //        var darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
//        //        // 2
//        //        var blurView = UIVisualEffectView(effect: darkBlur)
//        //        blurView.frame = view.bounds
//        //        // 3
//        //        view.addSubview(blurView)
//    }
//    // init for screensize
//    required init(coder aDecoder: NSCoder)
//    {
//        
//        //        blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
//        //
//        //        helloView = UIVisualEffectView(effect: blurEffect)
//        //
//        //        helloLabel = UILabel()
//        //
//        //        helloLabel.text = "HELOO"
//        
//        //        let bundle = NSBundle(forClass:self.dynamicType)
//        //        let nib = UINib(nibName: "InstructionView", bundle: bundle)
//        //        instructionSubView = nib.instantiateWithOwner(InstructionView.self, options: nil)[0] as! UIView
//        
//        
//        
//        // size of screen for layout
//        screenSize = UIScreen.mainScreen().bounds
//        screenWidth = screenSize.width
//        screenHeight = screenSize.height - CGFloat(30)
//        
//        
//        
//        self.calendarInfo = newCalendarManager()
//        self.datesToShow = calendarInfo.getDates()
//        
//        
//        
//        
//        
//        if let setDates = savedSettings.objectForKey("setDates") as? [NSDate]
//        {
//            self.selectedDates = savedSettings.objectForKey("setDates") as! [NSDate]
//            self.initialCalendarState = false
//        }
//        else
//        {
//            self.selectedDates = [NSDate]()
//            self.initialCalendarState = true
//        }
//        
//        
//        super.init(coder: aDecoder)
//        
//    }
//    
//    
//    // collectionview protocols init
//    override func viewDidLoad()
//    {
//        calendarCollectionView.delegate = self
//        calendarCollectionView.dataSource = self
//        
//        view.addSubview(instructionSubView)
//        
//        super.viewDidLoad()
//        
//    }
//    
//    
//    
//    
//    override func viewWillAppear(animated: Bool) {
//        
//        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
//        
//        
//        
//        var welcomeSubView = UIVisualEffectView(effect: blurEffect)
//        
//        
//        welcomeSubView.frame = view.bounds
//        
//        var instructionText = UILabel(frame: CGRectMake(100, 50, 100, 100))
//        
//        
//        instructionText.text = "HELLO WORLD"
//        
//        welcomeSubView.addSubview(instructionText)
//        
//        
//        view.addSubview(welcomeSubView)
//        
//    }
//    
//    
//    // amount of sections in collectionview. 3 years will be shown
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
//    {
//        return self.datesToShow.count
//    }
//    
//    
//    // amount of items in each section. 1 month is one section
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
//    {
//        return datesToShow[section].count
//    }
//    
//    
//    // collectionview protocol to fill cell with data
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
//    {
//        
//        
//        //        self.calendarInfo.cycleManager.calculateCycle(self.calendarInfo.lastCalendarDate)
//        
//        
//        let cell = self.calendarCollectionView.dequeueReusableCellWithReuseIdentifier("calendarCell", forIndexPath: indexPath) as! DateCollectionViewCell
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
//        
//        //        // makes green if is a safe date. is a not fertile!
//        //        else if contains(self.calendarInfo.cycleManager.safeDates, cell.dateObject)
//        //        {
//        //            cell.contentView.backgroundColor = UIColor.greenColor()
//        //        }
//        //        // make dark grey if a fertile day
//        //        else if contains(self.calendarInfo.cycleManager.fertileDates, cell.dateObject)
//        //        {
//        //            cell.contentView.backgroundColor = UIColor.darkGrayColor()
//        //        }
//        
//        
//        //
//        //        if contains(self.selectedDates, cell.dateObject)
//        //        {
//        //            cell.contentView.backgroundColor = UIColor.cyanColor()
//        //        }
//        //        else
//        //        {
//        //            cell.contentView.backgroundColor = UIColor.lightGrayColor()
//        //        }
//        //
//        
//        cell.contentView.layer.cornerRadius = 32.5
//        
//        return cell
//    }
//    
//    
//    // monthNamesToShowInView
//    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
//    {
//        let monthHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "monthCell", forIndexPath: indexPath) as! MonthCollectionReusableView
//        
//        var monthDateObject = self.datesToShow[indexPath.section][0]
//        
//        var monthHeaderText = self.calendarInfo.monthNames[monthDateObject.month.value() - 1] as! String
//        
//        monthHeaderView.monthLabel.text = "\(monthHeaderText)  \(monthDateObject.year.value())"
//        
//        
//        return monthHeaderView
//        
//    }
//    
//    
//    
//    
//    // select past or current date. change color.
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
//    {
//        println(" DID SELECT")
//        
//        let cell = calendarCollectionView.cellForItemAtIndexPath(indexPath) as! DateCollectionViewCell
//        
//        if cell.dateObject <= self.calendarInfo.currentDate
//        {
//            
//            
//            // remove or add date object
//            self.calendarInfo.cycleManager.setMenstruationDate(cell.dateObject)
//            
//            // if date was alread set as period date
//            if contains(self.calendarInfo.cycleManager.setMenstruationDates, cell.dateObject)
//            {
//                // get cell  back to original color
//                cell.contentView.backgroundColor = UIColor.redColor()
//                
//                println(" SEelect")
//            }
//            else
//            {
//                // make cell blue to indictae menstruation dates
//                cell.contentView.backgroundColor = UIColor.greenColor()
//                println(" DeSelect")
//                
//                
//            }
//            
//            self.selectedDates.append(cell.dateObject)
//            
//        }
//    }
//    
//    
//    
//    // save dates in NSUserDefaults
//    func saveDates()
//    {
//        savedSettings.setObject(self.selectedDates, forKey: "setDates")
//        savedSettings.synchronize()
//    }
//    
//    
//}
//
//
