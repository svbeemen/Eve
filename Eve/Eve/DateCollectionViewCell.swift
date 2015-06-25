//
//  DateCollectionViewCell.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 23/06/15.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var circleImage: UIImageView!
    
    var dateObject: NSDate!
 
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
//        self.circleImage = UIImageView()
//        self.circleImage.layer.cornerRadius = 36
//        self.circleImage.clipsToBounds = true
//        self.circleImage.backgroundColor = UIColor(patternImage: (UIImage(named: "blue"))!)
////        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
//        self.profileImageView.clipsToBounds = YES;
//        
//        self.contentView.layer.cornerRadius = 36

 
        
//        self.contentView.backgroundColor = UIColor.lightGrayColor()
//        self.backgroundView?.backgroundColor = UIColor.clearColor()
//        self.circleImage.image = UIImage(named: "redCircle")
    }
//
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame.size = CGSize(width: 75, height: 75)
        
        println("layer =\(self.contentView.frame)")
    }

    
    override func awakeFromNib() {
        self.circleImage.layer.cornerRadius = 36
        self.circleImage.clipsToBounds = true
        self.circleImage.backgroundColor = UIColor(patternImage: (UIImage(named: "blue"))!)
    }
//
}
