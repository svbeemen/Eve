//
//  ViewController.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 02/06/15 W23.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    
    
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    let screenSize : CGRect
    let screenWidth: CGFloat!
    let screenHeight: CGFloat!
    let columns = CGFloat(5)
    
    let dates = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28]
    
    required init(coder aDecoder: NSCoder)
    {
        screenSize = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad()
    {
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
//        calendarCollectionView.registerClass(UICollectionViewController.self, forCellWithReuseIdentifier: "month")
        
        super.viewDidLoad()
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.dates.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = self.calendarCollectionView.dequeueReusableCellWithReuseIdentifier("CalendarCell", forIndexPath: indexPath) as! DateLabelCollectionViewCell
//        
//        let header = self.calendarCollectionView.dequeueReusableSupplementaryViewOfKind(collectionView, withReuseIdentifier: "month", forIndexPath: NSIndexPath.self)
        
        
        println(cell.dateLabel)
        var date = self.dates[indexPath.item]
        cell.dateLabel!.text = String(date)
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
         return CGSize(width: screenWidth / columns, height: screenWidth / columns)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
}

