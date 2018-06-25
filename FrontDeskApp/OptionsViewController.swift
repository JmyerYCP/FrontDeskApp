//
//  OptionsViewController.swift
//  FrontDeskApp
//
//  Created by Jon Myer on 6/21/18.
//  Copyright © 2018 Jonathan Myer. All rights reserved.
//

import UIKit
import FirebaseDatabase


class OptionsViewController: UIViewController {
    var userRef: DatabaseReference?
    
    @IBOutlet weak var computerSwitch: UISwitch!
    @IBOutlet weak var UCSwitch: UISwitch!
    @IBOutlet weak var faxSwitch: UISwitch!
    @IBOutlet weak var appointmentSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        computerSwitch.setOn(false, animated:false)
        UCSwitch.setOn(false, animated:false)
        faxSwitch.setOn(false, animated:false)
        appointmentSwitch.setOn(false, animated:false)
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
        // Update Database
        userRef?.child("reasonForVisit").setValue(["computer": String(computerSwitch.isOn), "UCPhone": String(UCSwitch.isOn), "faxOrCopy": String(faxSwitch.isOn), "appointment": String(appointmentSwitch.isOn)])
        
        //TODO: Do something heree to confirm which appoitment and send a notification to the person. (will require setting up an appoitment system along with admin settings or something).
        
        performSegue(withIdentifier: "SignInConfirmSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let destinationViewController = segue.destination as? SignInConfirmViewController {
            destinationViewController.userRef = userRef
        }
    }
    
    
    
}
