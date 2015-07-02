////
////  SettingsViewController.swift
////  Eve
////
////  Created by Sangeeta van Beemen on 23/06/15.
////  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController
{
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var ovulationSwitch: UISwitch!
    
    @IBOutlet weak var cautionSwitch: UISwitch!
    
    @IBOutlet weak var menstruationSwitch: UISwitch!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        CycleNotifications.sharedInstance.loadNotificationSettings()
        ovulationSwitch.on = CycleNotifications.sharedInstance.includeOvulationNotifications
        menstruationSwitch.on = CycleNotifications.sharedInstance.includeMenstruationNotifications
        cautionSwitch.on = CycleNotifications.sharedInstance.includeCautionNotifications
    }
    
    
    @IBAction func goBack(sender: UIButton)
    {
        dismissViewControllerAnimated(true, completion: nil)

    }
    

    @IBAction func changeOvulationSwitchState(sender: UISwitch)
    {
        if ovulationSwitch.on
        {
            CycleNotifications.sharedInstance.includeOvulationNotifications = true
        }
        else
        {
            CycleNotifications.sharedInstance.includeOvulationNotifications = false
        }
    }
    

    @IBAction func changeCautionSwitchState(sender: UISwitch)
    {
        if cautionSwitch.on
        {
            CycleNotifications.sharedInstance.includeCautionNotifications = true
        }
        else
        {
            CycleNotifications.sharedInstance.includeCautionNotifications = false
        }
    }
    

    @IBAction func changeMenstruationSwitchStat(sender: UISwitch)
    {
        if menstruationSwitch.on
        {
            CycleNotifications.sharedInstance.includeMenstruationNotifications = true
        }
        else
        {
            CycleNotifications.sharedInstance.includeMenstruationNotifications = false
        }
    }
}