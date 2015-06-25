//
//  NewMonthReusableView.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 25/06/15.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

class NewMonthReusableView: UICollectionReusableView
{
    var dateLabel: UILabel!
    
    var dateObject: NSDate!
    
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(patternImage: UIImage(named: "SwatchLightGrey")!)
        
        let textFrame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        dateLabel = UILabel(frame: textFrame)
        dateLabel.font = UIFont.systemFontOfSize(20)
        dateLabel.textColor = UIColor.whiteColor()
        dateLabel.textAlignment = NSTextAlignment.Left
        self.addSubview(dateLabel)
        
        self.layer.cornerRadius = CGFloat(15)
    }
}
