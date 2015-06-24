////
////  LayoutController.swift
////  Eve
////
////  Created by Sangeeta van Beemen on 18/06/15.
////  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
////
//
//import UIKit
//
//let reuseIdentifier = "calendarCell"
//
//class LayoutController: UICollectionViewFlowLayout, UICollectionViewController {
//
////        let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
////        let titles = ["Sand Harbor, Lake Tahoe - California","Beautiful View of Manhattan skyline.","Watcher in the Fog","Great Smoky Mountains National Park, Tennessee","Most beautiful place"]
////        override func viewDidLoad() {
////            super.viewDidLoad()
////        }
////        
////        override func didReceiveMemoryWarning() {
////            super.didReceiveMemoryWarning()
////            // Dispose of any resources that can be recreated.
////        }
////        
////        // MARK: UICollectionViewDataSource
////        
////        override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
////            //#warning Incomplete method implementation -- Return the number of sections
////            return 1
////        }
////        
////        
////        override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////            //#warning Incomplete method implementation -- Return the number of items in the section
////            return 50
////        }
////        
////        
////        override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
////            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as CollectionViewCell
////            cell.title.text = self.titles[indexPath.row % 5]
////            let curr = indexPath.row % 5  + 1
////            let imgName = "pin\(curr).jpg"
////            cell.pinImage.image = UIImage(named: imgName)
////            
////            return cell
////        }
////        
////        
////        
////        
////        func collectionView(collectionView: UICollectionView!,
////            layout collectionViewLayout: UICollectionViewLayout!,
////            sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
////                return CGSize(width: 170, height: 300)
////        }
////        
////        
////        
////        
////        func collectionView(collectionView: UICollectionView!,
////            layout collectionViewLayout: UICollectionViewLayout!,
////            insetForSectionAtIndex section: Int) -> UIEdgeInsets {
////                return sectionInsets
////        }
////        
////        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
////            println(segue.identifier)
////            println(sender)
////            if(segue.identifier == "detail"){
////                let cell = sender as DateCollectionViewCell
////                let indexPath = collectionView?.indexPathForCell(cell)
////                let vc = segue.destinationViewController as DetailViewController
////                
////                let curr = indexPath!.row % 5  + 1
////                let imgName = "pin\(curr).jpg"
////                
////                println(vc)
////                vc.currImage = UIImage(named: imgName)
////                vc.textHeading = self.titles[indexPath!.row % 5]
////                //            
////                //            vc.heading.text = self.titles[0]
////                //            vc.imageView.image = UIImage(named: imgName)
////            }
////        }
//    
//        
//        
//    }
//
////    override func viewDidLoad() {
////        super.viewDidLoad()
////
////        // Uncomment the following line to preserve selection between presentations
////        // self.clearsSelectionOnViewWillAppear = false
////
////        // Register cell classes
////        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
////
////        // Do any additional setup after loading the view.
////    }
////
////    override func didReceiveMemoryWarning() {
////        super.didReceiveMemoryWarning()
////        // Dispose of any resources that can be recreated.
////    }
////
////    /*
////    // MARK: - Navigation
////
////    // In a storyboard-based application, you will often want to do a little preparation before navigation
////    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
////        // Get the new view controller using [segue destinationViewController].
////        // Pass the selected object to the new view controller.
////    }
////    */
////
////    // MARK: UICollectionViewDataSource
////
////    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
////        //#warning Incomplete method implementation -- Return the number of sections
////        return 0
////    }
////
////
////    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        //#warning Incomplete method implementation -- Return the number of items in the section
////        return 0
////    }
////
////    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
////    
////        // Configure the cell
////    
////        return cell
////    }
////
////    // MARK: UICollectionViewDelegate
////
////    /*
////    // Uncomment this method to specify if the specified item should be highlighted during tracking
////    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
////        return true
////    }
////    */
////
////    /*
////    // Uncomment this method to specify if the specified item should be selected
////    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
////        return true
////    }
////    */
////
////    /*
////    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
////    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
////        return false
////    }
////
////    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
////        return false
////    }
////
////    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
////    
////    }
////    */
////
//}
