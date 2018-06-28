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
    var userQuestionnaire = true
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        computerSwitch.setOn(false, animated:false)
        UCSwitch.setOn(false, animated:false)
        faxSwitch.setOn(false, animated:false)
        appointmentSwitch.setOn(false, animated:false)
        doesUserNeedToDoQuestionnaire()
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
    func doesUserNeedToDoQuestionnaire () { // queries the database to get all instances of given participation number, then checks to see if there has been a questionnaire filled out in the last 6 months. if so it returns false. if not returns true
        var isDateOld = true
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.month = -6
        let sixMonthsAgoDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        userRef?.observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            let participantNumber = value?["participantNumber"] as? String ?? ""
            print("Your participantNumber is: " + participantNumber)
            self.rootRef.child("Users").queryOrdered(byChild: "/participantNumber").queryEqual(toValue: participantNumber).observeSingleEvent(of: .value, with: { (snapshot) in
                print("Snapshot: " + "\(snapshot)")
                
                for child in snapshot.children.allObjects as! [DataSnapshot] {
                    print("Child: \(child)")
                    let valueA = child.childSnapshot(forPath: "questionnaire")
                    print("Child ValueA: \(valueA)")
                    let valueB = valueA.value as? NSDictionary
                    let questionnaireDateString = valueB?["questionnaireDate"] as? String ?? ""
                    let questionnaireDate = dateFormatter.date(from: questionnaireDateString)
                    print("Questionnaire Date is: " + questionnaireDateString)
                    if questionnaireDate != nil {
                        if questionnaireDate! > sixMonthsAgoDate! {
                            isDateOld = false
                            
                        }
                    }
                }
                self.userQuestionnaire = isDateOld
            })
            
        }) {(error) in
            print(error.localizedDescription)
        }
        
        
        
    }
    
    @IBAction func Continue(_ sender: Any) {
        // Update Database
        userRef?.child("reasonForVisit").setValue(["computer": String(computerSwitch.isOn), "UCPhone": String(UCSwitch.isOn), "faxOrCopy": String(faxSwitch.isOn), "appointment": String(appointmentSwitch.isOn)])
        
        
        
        //TODO: Do something heree to confirm which appoitment and send a notification to the person. (will require setting up an appoitment system along with admin settings or something).
        if computerSwitch.isOn == true && userQuestionnaire == true {
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
