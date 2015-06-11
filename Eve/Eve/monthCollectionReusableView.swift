//
//  monthCollectionReusableView.swift
//  Eve
//
//  Created by Sangeeta van Beemen on 11/06/15 W24.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

class monthCollectionReusableView: UICollectionReusableView
{
        
    @IBOutlet weak var monthLabel: UILabel!

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