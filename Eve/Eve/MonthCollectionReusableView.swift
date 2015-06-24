//
//  monthCollectionReusableView.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 11/06/15 W24.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

class MonthCollectionReusableView: UICollectionReusableView
{
        
//    let screenSize: CGRect
//    let screenWidth: CGFloat

//    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    var dateObject: NSDate!
   
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.magentaColor()
        self.frame.size = CGSize(width: 100, height: 50)
        self.layer.borderWidth = CGFloat(4)
        self.layer.borderColor = UIColor.blackColor().CGColor
//        self.frame.size = CGSize(width: self.frame.width - 10, height: 50)
//        self.layer.cornerRadius = 5
    }
    
    
//    
//    override init(frame: CGRect)
//    {
//        
//        self.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(300), height: CGFloat(50))
//        super.init(frame: frame)
//    }
//
//    required init(coder aDecoder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
//    }
//    
////    required init(coder aDecoder: NSCoder)
////    {
////
////    }
//    

}



//class CollectionSampleViewController: UICollectionViewController {
//    
//    private let reuseIdentifier1 = "Cell"
//    private var numberOfItemsPerSection = 9
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    
//    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return numberOfItemsPerSection
//    }
//    
//    override func scrollViewDidScroll(scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        
//        if offsetY > contentHeight - scrollView.frame.size.height {
//            numberOfItemsPerSection += 6
//            self.collectionView.reloadData()
//        }
//    }   
//}