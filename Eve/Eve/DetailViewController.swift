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
    
    var cellObject: NewDateCell!
    
    var calendarManager: CalendarClass!

    @IBOutlet weak var logoImageView: UIImageView!
    
    
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
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "viewTapped")
        view.addGestureRecognizer(tapRecognizer)
        
        if cellObject.dateObject.date.isLaterThan(calendarManager.currentDate)
        {
            setDateButton.hidden = true
        }
        
        println("cell date type = \(cellObject.dateObject.type)")
    }
    
    
    func viewTapped()
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
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
        else if cellObject.dateObject.type == "Caution"
        {
            dateImageView.image = UIImage(named: "caution")
            setDateButton.setTitle("\u{002B}", forState: UIControlState.Normal)
        }
        else
        {
            dateImageView.image = UIImage(named: "Normal")
            setDateButton.setTitle("\u{002B}", forState: UIControlState.Normal)
        }
    }
    
    
    func getText() -> String
    {
        var text = ""
        
        if  cellObject.dateObject.type == "menstruation"
        {
            text = "It's not the most pleasant time of the month. But you're changes of getting pregnant is pretty much ziltch. So good luck with the craps and remember all real man doesn't mind sailing the red sea's. Have fun!"
        }
        else if cellObject.dateObject.type == "ovulation"
        {
            text = "What ever you do today, be safe!! We know it's difficult but remember, if you're not careful now it will no alcohol for nine months. Good luck!"
        }
        else if cellObject.dateObject.type == "Caution"
        {
            text = "It's danger zone lady! You might feel like and that's great. But be safe!"
        }
        else
        {
            text = "You're all good to go! Have fun!"
        }
        return text
    }
    
    
}
