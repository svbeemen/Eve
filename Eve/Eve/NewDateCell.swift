//
//  NewDateCell.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 25/06/15.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

class NewDateCell: UICollectionViewCell
{
    var dateLabel: UILabel!
    
    var circleImage: UIImageView!
    
    var dateObject: NSDate!

    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        circleImage = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width - 3, height: frame.size.height - 3))
        circleImage.contentMode = UIViewContentMode.ScaleAspectFit
        contentView.addSubview(circleImage)
        
        let textFrame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        dateLabel = UILabel(frame: textFrame)
        dateLabel.font = UIFont.systemFontOfSize(16)
        dateLabel.textColor = UIColor.whiteColor()
        dateLabel.textAlignment = .Center
        contentView.addSubview(dateLabel)
    }
}
