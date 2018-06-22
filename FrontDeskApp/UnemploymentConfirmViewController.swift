//
//  UnemploymentConfirmViewController.swift
//  FrontDeskApp
//
//  Created by Jon Myer on 6/21/18.
//  Copyright © 2018 Jonathan Myer. All rights reserved.
//

import UIKit
import FirebaseDatabase


class UnemploymentConfirmViewController: UIViewController {
    var userRef: DatabaseReference?
    
    @IBOutlet weak var computerSwitch: UISwitch!
    @IBOutlet weak var UCSwitch: UISwitch!
    @IBOutlet weak var faxSwitch: UISwitch!
    @IBOutlet weak var appoitmentSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func Continue(_ sender: Any) {
        if computerSwitch.isOn {
            userRef?.setValue(["computer": "true"])
        }
        if UCSwitch.isOn {
            userRef?.setValue(["UCPhone": "true"])
        }
        if faxSwitch.isOn{
            userRef?.setValue(["fax": "true"])
        }
        if appoitmentSwitch.isOn{
            userRef?.setValue(["appoitment": "true"])
        }
    }
    
    
    
}
