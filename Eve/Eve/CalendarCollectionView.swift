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
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout)
    {
        super.init(frame: frame, collectionViewLayout: layout)

        self.backgroundColor = UIColor.whiteColor()
        
        println(" hello create collection view")
        
        self.registerClass(NewDateCell.self, forCellWithReuseIdentifier: "Cell")
        
        self.registerClass(NewMonthReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
    }
}


