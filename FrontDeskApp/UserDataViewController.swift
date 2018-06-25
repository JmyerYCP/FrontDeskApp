//
//  UserDataViewController.swift
//  FrontDeskApp
//
//  Created by Jon Myer on 6/25/18.
//  Copyright © 2018 Jonathan Myer. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UserDataViewController: UIViewController {
    var userRef: DatabaseReference?
    

    @IBOutlet weak var veteranSwitch: UISwitch!
    @IBOutlet weak var militaryBranch: UITextField!
    @IBOutlet weak var disabilityPercent: UITextField!
    @IBOutlet weak var medalSwitch: UISwitch!
    @IBOutlet weak var medalLabel: UILabel!
    @IBOutlet weak var activeAfter910Switch: UISwitch!
    @IBOutlet weak var activeAfter910Label: UILabel!
    @IBOutlet weak var medalStack: UIStackView!
    @IBOutlet weak var serviceAfter910Stack: UIStackView!
    @IBOutlet weak var employedSwitch: UISwitch!
    @IBOutlet weak var employerName: UITextField!
    @IBOutlet weak var noticeOfTerminationSwitch: UISwitch!
    @IBOutlet weak var noticeOfCompanyClosingSwitch: UISwitch!
    @IBOutlet weak var receivingSwitch: UISwitch!
    @IBOutlet weak var exhaustedSwitch: UISwitch!
    @IBOutlet weak var notEligibleSwitch: UISwitch!
    @IBOutlet weak var didNotApplySwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        veteranSwitch.setOn(false, animated: false)
        veteranDisable()
        employedSwitch.setOn(false, animated: false)
        noticeOfTerminationSwitch.setOn(false, animated: false)
        noticeOfCompanyClosingSwitch.setOn(false, animated: false)
        medalSwitch.setOn(false, animated: false)
        activeAfter910Switch.setOn(false, animated: false)
        receivingSwitch.setOn(false, animated: false)
        exhaustedSwitch.setOn(false, animated: false)
        notEligibleSwitch.setOn(false, animated: false)
        didNotApplySwitch.setOn(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func veteranDisable() {
        militaryBranch.isHidden = true
        militaryBranch.sizeToFit()
        disabilityPercent.isHidden = true
        disabilityPercent.sizeToFit()
        medalStack.isHidden = true
        medalStack.sizeToFit()
        serviceAfter910Stack.isHidden = true
        serviceAfter910Stack.sizeToFit()
    }
    
    func veteranEnable() {
        militaryBranch.isHidden = false
        disabilityPercent.isHidden = false
        medalStack.isHidden = false
        serviceAfter910Stack.isHidden = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func veteranSwitchAction(_ sender: Any) {
        if veteranSwitch.isOn == true{
            veteranEnable()
        } else {
            veteranDisable()
        }
    }
    @IBAction func ContinueButton(_ sender: Any) {
        performSegue(withIdentifier: "OptionsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let destinationViewController = segue.destination as? OptionsViewController {
            destinationViewController.userRef = userRef
        }
    }
}
