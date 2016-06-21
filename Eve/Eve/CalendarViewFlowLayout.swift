//
//  CalendarViewFlowLayout.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 23/06/15.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

class CalendarViewFlowLayout: UICollectionViewFlowLayout
{
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    override init()
    {
        super.init()
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        let cellDimension = (screenWidth - 6) / COLUMNS
        
        sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        itemSize = CGSize(width: cellDimension, height: cellDimension)
        minimumInteritemSpacing = CGFloat(0)
        minimumLineSpacing = CGFloat(0)
        headerReferenceSize = CGSize(width: 200, height: 30)
    }
}
