////
////  CalendarView.swift
////  Eve
////
////  Created by Sangeeta van Beemen on 22/06/15.
////  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
////
//
//import UIKit
//
//class BlurView: UIVisualEffectView {
//
//    /*
//    // Only override drawRect: if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func drawRect(rect: CGRect) {
//        // Drawing code
//    }
//    */
////    
////
////    var blurEffect: UIBlurEffect!
////
////    var subView: UIVisualEffectView!
//
////  
//    
//
//    var instructionTextLabel: UILabel!
//    
//    var blurEffect: UIBlurEffect!
//    
//    var touchedViews: UIGestureRecognizer!
//    
//
//    
//    override init(effect: UIVisualEffect)
//    {
//        
//        blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
//        
//        super.init(effect: blurEffect)
//    }
//    
//    
//    
//    required init(coder aDecoder: NSCoder)
//    {
//        super.init(coder: aDecoder)
//        
//        instructionTextLabel = UILabel(frame: frame)
//        instructionTextLabel.text = "Welcome To Eve"
//        instructionTextLabel.textAlignment = NSTextAlignment.Center
//        
//        touchedViews = UIGestureRecognizer(target: self, action: "hide")
//    }
//    
//    func hide()
//    {
//        self.sendSubviewToBack(self)
//    }
//    
//
////    required init(coder aDecoder: NSCoder)
////    {
////        
////        
////        
////        
////        instructionTextLabel = UILabel(frame: CGRect(origin: CGPoint, size: CGSize)
////    
////     
////        
//////        
//////        var mySize = CGSize(width: 150, height: 100)
//////        
//////        var place = superview?.center
//////        
//////        var myPlaceSize = CGRect(origin: place!, size: mySize)
//////        
//////        helloText = UILabel(frame: myPlaceSize)
//////        
////        super.init(coder: aDecoder)
////        
////
////        
////    }
////    
//    
//
////    
////    
//
////
////    
////    required init(coder aDecoder: NSCoder) {
////        
//////        blurEffect = UIBlurEffect()
//////        subView = UIVisualEffectView()
////
////        
////        blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
////        
////        subView = UIVisualEffectView(effect: blurEffect)
////
////        
////        subView.bounds = UIScreen.mainScreen().bounds
////        
////        super.init(coder: aDecoder)
////        
////    }
//    
//    
//
//}
