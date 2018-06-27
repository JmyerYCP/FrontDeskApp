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
    var rootRef = Database.database().reference()
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
    func doesUserNeedToDoQuestionnaire (participationNumber: String) -> Bool {
        rootRef.child("users").child("questionnaire").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let questionnaireDate = value?["questionnaireDate"] as? String ?? ""
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
            let date = dateFormatter.date(from: questionnaireDate)
            
            
            let currentDateTime = Date()
            
            })
        
    }
    
    @IBAction func Continue(_ sender: Any) {
        // Update Database
        userRef?.child("reasonForVisit").setValue(["computer": String(computerSwitch.isOn), "UCPhone": String(UCSwitch.isOn), "faxOrCopy": String(faxSwitch.isOn), "appointment": String(appointmentSwitch.isOn)])
        userRef?.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let userPartNumber = value?["participationNumber"] as? String ?? ""
        })
        
        //TODO: Do something heree to confirm which appoitment and send a notification to the person. (will require setting up an appoitment system along with admin settings or something).
        if computerSwitch.isOn == true{
            performSegue(withIdentifier: "questionnaireSegue", sender: self)

        } else{
            performSegue(withIdentifier: "SignInConfirmSegue", sender: self)

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let destinationViewController = segue.destination as? SignInConfirmViewController {
            destinationViewController.userRef = userRef
        }
        else if let destinationViewController = segue.destination as? QuestionnaireViewController {
            destinationViewController.userRef = userRef
        }
    }
    
    
    
}
