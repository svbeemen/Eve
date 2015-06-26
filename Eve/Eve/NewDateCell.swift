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
    
    var cellImageView: UIImageView!
    
    var dateObject: CycleDate!

    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        cellImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width - 3, height: frame.size.height - 3))
        cellImageView.contentMode = UIViewContentMode.ScaleAspectFit
        contentView.addSubview(cellImageView)
        
        let textFrame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        dateLabel = UILabel(frame: textFrame)
        dateLabel.font = UIFont.boldSystemFontOfSize(16)
        dateLabel.textColor = UIColor.whiteColor()
        dateLabel.textAlignment = .Center
        contentView.addSubview(dateLabel)
    }
    
    
    func getImage()
    {
        cellImageView.layer.borderWidth = CGFloat(0)

        if dateObject.type == "menstruation"
        {
            cellImageView.image = UIImage(named: "Untitled-31")
        }
        else if dateObject.type == "ovulation"
        {
            cellImageView.image = UIImage(named: "Untitled-6")
        }
        else if dateObject.type == "caution"
        {
            cellImageView.image = UIImage(named: "Untitled-21")
        }
        else
        {
            cellImageView.image = UIImage(named: "Untitled-17")
        }
        
        if dateObject.date.isToday()
        {
            cellImageView.layer.borderWidth = CGFloat(2)
            cellImageView.layer.borderColor = UIColor.darkGrayColor().CGColor
            cellImageView.layer.cornerRadius = CGFloat(self.frame.width / 2)
        }
    }
    
    
    func getText()
    {
        dateLabel.text = "\(dateObject.date.day.value())"
    }
}

