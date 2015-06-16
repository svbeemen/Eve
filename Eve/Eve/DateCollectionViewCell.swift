//
//  DateCollectionViewCell.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 10/06/15 W24.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell
{
    
    @IBOutlet weak var dateLabel: UILabel!
   
//    @IBOutlet weak var cellImageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var dateObject: NSDate!
    
    var selectedDate: Bool!
    
}
    
//    required init(coder aDecoder: NSCoder)
//    {
//        
//        super.init(coder: aDecoder)
//    }
//    var layout = UICollectionViewLayoutAttributes()
    
    
//    override func awakeFromNib()
//    {
//        super.awakeFromNib()
//        self.selected = false
//    }
//    
//    override var selected : Bool
//    {
//        didSet
//        {
//            self.backgroundColor = selected ? UIColor.blackColor()
//        }
//    }

