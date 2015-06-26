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
    
    var dateObject: CycleDate!
    
    
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
        dateLabel.font = UIFont.boldSystemFontOfSize(20)
        dateLabel.textColor = UIColor.whiteColor()
        dateLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(dateLabel)
        
        self.layer.cornerRadius = CGFloat(15)
    }
    
    func getText()
    {
        dateLabel.text = "\(MONTHNAMES[dateObject.date.month.value() - 1])  \(dateObject.date.year.value())"
    }
}
