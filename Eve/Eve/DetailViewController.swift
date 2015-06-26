//
//  DetailViewController.swift
//  
//
//  Created by Sangeeta van Beemen on 24/06/15.
//
//

import UIKit

class DetailViewController: UIViewController
{

    @IBOutlet weak var dateImageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var setDateButton: UIButton!
    
    var cellObject: NewDateCell!
    
    var calendarManager: CalendarClass!
    
    var cellDate: CycleDate!


    @IBAction func setDate(sender: UIButton)
    {

        calendarManager.menstruationCycle.editMenstruationDates(self.cellDate)
        
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)

        
//        if contains(calendarManager.menstruation.pastMenstruationDates, self.cellDate) || contains(calendarManager.menstruation.predictedMenstruationDates, self.cellDate)
//        {
//            dateImageView.image = UIImage(named: "LightRed")
////            cell.circleImage.layer.borderWidth = CGFloat(0)
//        }
//        else if contains(calendarManager.menstruation.predictedOvulationDates, self.cellDate)
//        {
//            dateImageView.image = UIImage(named: "darkGrey")
////            cellObject.circleImage.layer.borderWidth = CGFloat(0)
//        }
//        else if contains(calendarManager.menstruation.predictedCautionDates, self.cellDate)
//        {
//            dateImageView.image = UIImage(named: "lightBlueCircle")
////            cell.circleImage.layer.borderWidth = CGFloat(0)
//        }
//        else
//        {
//            dateImageView.image = UIImage(named: "LightGreen")
////            cell.circleImage.layer.borderWidth = CGFloat(0)
//
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        dateLabel.text = "\(cellObject.dateObject.date.day.value())"
        dateImageView.image = cellObject.cellImageView.image
   
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "viewTapped")
        view.addGestureRecognizer(tapRecognizer)
        
        cellDate = cellObject.dateObject
        
        if cellObject.dateObject.date.isLaterThan(calendarManager.currentDate)
        {
            setDateButton.hidden = true
        }
        
    }
    
    
    func viewTapped()
    {
//        self.performSegueWithIdentifier("detail", sender: nil)

        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        println("segue detail back 1")
        if(segue.identifier == "detail")
        {
            println("segue detail back 2")

            var nextViewController = (segue.destinationViewController as! CalendarViewController)
            
//            nextViewController.cellObject = cellObject
            nextViewController.calendarManager = calendarManager
            nextViewController.calendarView.reloadData()
            
//            nextViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        }
    }
}
