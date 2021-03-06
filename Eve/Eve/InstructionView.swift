//
//  InstructionView.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 24/06/15.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

class InstructionView: UIVisualEffectView
{
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    override init(effect: UIVisualEffect?)
    {
        super.init(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        
        let tapRegonizer = UITapGestureRecognizer(target: self, action: #selector(InstructionView.viewTapped))
        self.addGestureRecognizer(tapRegonizer)
        
        let label = UILabel(frame: CGRectMake(120, 80, 300, 400));
        label.center = CGPointMake(UIScreen.mainScreen().bounds.width / 2, UIScreen.mainScreen().bounds.height / 2.5)
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: "Arial", size: 22)
        label.text = "Welcome To Eve.                   Select the dates you last had your period. For the most accurate results please set as many previous period dates as possible. Press the ♀ for your predicted ovulation and menstruation dates."
        label.numberOfLines = 10
        label.textColor = UIColor.darkGrayColor()
        
        self.addSubview(label)
    }
    
    func viewTapped()
    {
        self.removeFromSuperview()
    }
}