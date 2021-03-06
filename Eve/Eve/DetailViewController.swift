//
//  DetailViewController.swift 
//  Eve
//
//  Created by Sangeeta van Beemen on 25/06/15.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    var delegate: changeDateProtocol?
    @IBOutlet weak var dateImageView: UIImageView!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var setDateButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    var cellObject: NewDateCell!
    var calendarManager: CalendarClass!
    
    @IBAction func setDate(sender: UIButton)
    {
        cellObject = self.delegate?.changeDate()
        self.getImage()
        informationLabel.text = getText()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        dateLabel.text = "\(cellObject.dateObject.date.day.value())"
        getImage()
        informationLabel.text = getText()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.viewTapped))
        view.addGestureRecognizer(tapRecognizer)
        
        if cellObject.dateObject.date.isLaterThan(calendarManager.currentDate)
        {
            setDateButton.hidden = true
        }
    }
    
    // Instructionview disappears when tapped.
    func viewTapped()
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Get image for date type.
    func getImage()
    {
        dateImageView.layer.borderWidth = CGFloat(0)
        
        if  cellObject.dateObject.type == "menstruation"
        {
            dateImageView.image = UIImage(named: "Menstruation")
            setDateButton.setTitle("\u{00D7}", forState: UIControlState.Normal)
        }
        else if cellObject.dateObject.type == "ovulation"
        {
            dateImageView.image = UIImage(named: "Caution")
            logoImageView.image = UIImage(named: "Logo")
            setDateButton.setTitle("\u{002B}", forState: UIControlState.Normal)
        }
        else if cellObject.dateObject.type == "caution"
        {
            dateImageView.image = UIImage(named: "Caution")
            setDateButton.setTitle("\u{002B}", forState: UIControlState.Normal)
        }
        else
        {
            dateImageView.image = UIImage(named: "Normal")
            setDateButton.setTitle("\u{002B}", forState: UIControlState.Normal)
        }
    }
    
    // Get text for date type. 
    func getText() -> String
    {
        var text = ""
        
        if  cellObject.dateObject.type == "menstruation"
        {
            text = "Good luck with the cramps. You are safe to have as much fun as you please!"
        }
        else if cellObject.dateObject.type == "ovulation"
        {
            text = "Whatever you do today, be safe!"
        }
        else if cellObject.dateObject.type == "caution"
        {
            text = "It's danger zone lady. Keep calm and be safe!"
        }
        else
        {
            text = "You're all good to go!"
        }
        return text
    }
}