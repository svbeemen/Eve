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


    @IBAction func setDate(sender: UIButton)
    {
        println("set date button pressed")
        calendarManager.cycleManager.setMenstruationDate(self.cellObject.dateObject)
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        dateLabel.text = "\(cellObject.dateObject.day.value())"
        
        dateImageView.image = cellObject.circleImage.image
   
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "viewTapped")
        view.addGestureRecognizer(tapRecognizer)
    }
    
    
    func viewTapped()
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
