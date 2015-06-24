//
//  CalendarCollectionView.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 23/06/15.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

class CalendarCollectionView: UICollectionView
{
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 75, height: 75)
        
        layout.headerReferenceSize = CGSize(width: 200, height: 50)
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        self.backgroundView?.backgroundColor = UIColor.clearColor()
        
    }
    

    
}




//class CalendarCollectionView: UICollectionView
//{
//
//    /*
//    // Only override drawRect: if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func drawRect(rect: CGRect) {
//        // Drawing code
//    }
//    */
//    
//    // size of calendar view
//    // size of cells
//    // size of header
//    // spaces between?
//    
//    let viewWidth: CGFloat!
//    
//    let viewHeight: CGFloat!
//    
//    let viewSize: CGRect!
//    
//    let cellSize: CGSize!
//    
//    
//    required init(coder aDecoder: NSCoder)
//    {
//        self.viewSize = UIScreen.mainScreen().bounds
//        self.viewWidth = viewSize.width
//        self.viewHeight = viewSize.height
//        
//        self.cellSize = CGSize(width: self.viewWidth / 5, height: self.viewWidth / 5)
//        
//        super.init(coder: aDecoder)
//        
//        self.backgroundView?.backgroundColor = UIColor.greenColor()
//
//    }
//    
//    
//    
//    
//    
//}
//
////    let viewWidth: CGFloat!
////    let viewHeight: CGFloat!
////    
////    let viewSize: CGRect!
////    let cellSize: CGSize!
//
//    
//    required init(coder aDecoder: NSCoder)
//    {
//       
//        
//        self.viewSize = UIScreen.mainScreen().bounds
//        self.viewWidth = viewSize.width
//        self.viewHeight = viewSize.height
//        
//        self.cellSize = CGSize(width: self.viewWidth / 5, height: self.viewWidth / 5)
//        
//        let layout = UICollectionViewFlowLayout()
//        
//        super.init(coder: aDecoder)
//        
//        self.frame = self.viewSize
//        
//        self.backgroundColor = UIColor.clearColor()
//    }
////    
////    let screenSize = UIScreen.mainScreen().bounds
////    let width: CGFloat!
//    let height: CGFloat!
//    let thumbnailSize: CGSize!
//    
//    required init(coder aDecoder: NSCoder)
//    {
//        width = screenSize.width
//        height = screenSize.height
//        thumbnailSize = CGSize(width: (width / COLUMNS) - 10, height: (width / COLUMNS) - 10)
//        
//        let newLayout = UICollectionViewFlowLayout()
//        newLayout.minimumLineSpacing = CGFloat(10)
//        
//        
//        super.init(coder: aDecoder)
//    }
//    
//    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout)
//    {
//        width = frame.width - CGFloat(10)
//        height = frame.height - CGFloat(10)
//        thumbnailSize = CGSize(width: (width / COLUMNS) - CGFloat(10), height: (width / COLUMNS) - CGFloat(10))
//        
//        
//        print("thum size =\(thumbnailSize)")
//        // Set the item size on the layout of collectionView, we want four-column thumbnails
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//
//
//        layout.itemSize = thumbnailSize
//        
//        layout.minimumInteritemSpacing = CGFloat(10)
//        layout.minimumLineSpacing = CGFloat(10)
//         println(" size frame = \(frame.width)")
//        
//        
//        super.init(frame: frame, collectionViewLayout: layout)
//        
//        backgroundColor = UIColor.whiteColor()
//        alwaysBounceVertical = true
//        
//        registerClass(DateCollectionViewCell.self, forCellWithReuseIdentifier: "dateCell")
//        
//        registerClass(MonthCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "monthHeader")
//    }
//    
//    

//
//    let screenSize = UIScreen.mainScreen().bounds
//    let width: CGFloat!
//    let height: CGFloat!
//    let dateCellSize: CGSize!
//    
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout)
//   {
//        width = frame.width
//        height = frame.height
//        dateCellSize = CGSize(width: width / COLUMNS, height: width / COLUMNS)
//        
//        // Set the item size on the layout of collectionView, we want four-column thumbnails
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.itemSize = dateCellSize
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        
//        super.init(frame: frame, collectionViewLayout: layout)
//        
//        backgroundColor = UIColor.whiteColor()
//        alwaysBounceVertical = true
//    
//
//    }
//    
//    required init(coder aDecoder: NSCoder)
//    {
//        super.init(coder: aDecoder)
//    }
//    
//    
//    
//    
//        override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout)
//       {
//            let width = frame.width
//            let height = frame.height
//            let dateCellSize = CGSize(width: width / COLUMNS, height: width / COLUMNS)
//    
//            // Set the item size on the layout of collectionView, we want four-column thumbnails
//            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//            layout.itemSize = dateCellSize
//            layout.minimumInteritemSpacing = 0
//            layout.minimumLineSpacing = 0
//            layout.headerReferenceSize = dateCellSize
//    
//            super.init(frame: frame, collectionViewLayout: layout)
//    
//            backgroundColor = UIColor.whiteColor()
//            alwaysBounceVertical = true
//        
//        
//            registerClass(DateCollectionViewCell.self, forCellWithReuseIdentifier: "dateCell")
//        
//            registerClass(MonthCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "monthHeader")
//    }
//    
//    
//    
//    


