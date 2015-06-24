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
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        self.itemSize = CGSize(width: 63, height: 63)
        self.minimumLineSpacing = CGFloat(1)
        self.minimumInteritemSpacing = CGFloat(1)
        
        
    }
    
   
}
