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
//    // dates to show in view
//    var datesToShow: [[NSDate]]
//    
//    var selectedDates: [NSDate]
//    
//    // instance of calendar manager
//    let calendarInfo: newCalendarManager
//    
//
//    
//    @IBOutlet weak var setDateButton: UIButton!
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
////        var darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
////        // 2
////        var blurView = UIVisualEffectView(effect: darkBlur)
////        blurView.frame = view.bounds
////        // 3
////        view.addSubview(blurView)
//    }
//    // init for screensize
//    required init(coder aDecoder: NSCoder)
//    {
//
////        blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
////        
////        helloView = UIVisualEffectView(effect: blurEffect)
////        
////        helloLabel = UILabel()
////
////        helloLabel.text = "HELOO"
//        
////        let bundle = NSBundle(forClass:self.dynamicType)
////        let nib = UINib(nibName: "InstructionView", bundle: bundle)
////        instructionSubView = nib.instantiateWithOwner(InstructionView.self, options: nil)[0] as! UIView
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
////        self.calendarInfo.cycleManager.calculateCycle(self.calendarInfo.lastCalendarDate)
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
////        // makes green if is a safe date. is a not fertile!
////        else if contains(self.calendarInfo.cycleManager.safeDates, cell.dateObject)
////        {
////            cell.contentView.backgroundColor = UIColor.greenColor()
////        }
////        // make dark grey if a fertile day
////        else if contains(self.calendarInfo.cycleManager.fertileDates, cell.dateObject)
////        {
////            cell.contentView.backgroundColor = UIColor.darkGrayColor()
////        }
//
//        
////        
////        if contains(self.selectedDates, cell.dateObject)
////        {
////            cell.contentView.backgroundColor = UIColor.cyanColor()
////        }
////        else
////        {
////            cell.contentView.backgroundColor = UIColor.lightGrayColor()
////        }
////        
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
