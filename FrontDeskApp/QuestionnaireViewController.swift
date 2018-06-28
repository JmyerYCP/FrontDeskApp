//
//  QuestionnaireViewController.swift
//  FrontDeskApp
//
//  Created by Jon Myer on 6/26/18.
//  Copyright © 2018 Jonathan Myer. All rights reserved.
//

import UIKit
import FirebaseDatabase

class QuestionnaireViewController: UIViewController {

    var userRef: DatabaseReference?
    var rootRef = Database.database().reference()
    @IBOutlet weak var displacedHomemakerSwitch: UISwitch!
    @IBOutlet weak var TANFSwitch: UISwitch!
    @IBOutlet weak var TANFTextField: UITextField!
    @IBOutlet weak var generalAssistanceTextField: UITextField!
    @IBOutlet weak var generalAssistanceSwitch: UISwitch!
    @IBOutlet weak var foodStampsSwitch: UISwitch!
    @IBOutlet weak var refugeeTextField: UITextField!
    @IBOutlet weak var refugeeSwitch: UISwitch!
    @IBOutlet weak var SSITextField: UITextField!
    @IBOutlet weak var SSISwitch: UISwitch!
    @IBOutlet weak var familySizeTextField: UITextField!
    @IBOutlet weak var homelessSwitch: UISwitch!
    @IBOutlet weak var freeLunchSwitch: UISwitch!
    @IBOutlet weak var fosterChildSwitch: UISwitch!
    @IBOutlet weak var disabilitySwitch: UISwitch!
    @IBOutlet weak var runawayYouthSwitch: UISwitch!
    @IBOutlet weak var youthHighPovertySwitch: UISwitch!
    @IBOutlet weak var exOffenderSwitch: UISwitch!
    @IBOutlet weak var englishLanguageLearnerSwitch: UISwitch!
    @IBOutlet weak var englishGrade8Switch: UISwitch!
    @IBOutlet weak var unableToEnglishWorkSwitch: UISwitch!
    @IBOutlet weak var farmWorker: UISwitch!
    @IBOutlet weak var exhaustingTANFSwitch: UISwitch!
    @IBOutlet weak var singleParentSwitch: UISwitch!
    @IBOutlet weak var singlePregnantWomanSwitch: UISwitch!
    @IBOutlet weak var longTermUnemploymentSwitch: UISwitch!
    @IBOutlet weak var culturalBarrierSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        TANFTextField.isHidden = true
        generalAssistanceTextField.isHidden = true
        refugeeTextField.isHidden = true
        SSITextField.isHidden = true


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func TANFSwitchAction(_ sender: Any) {
        textSwitchAction(switchName: TANFSwitch, textFieldName: TANFTextField)
    }
    @IBAction func generalAssistanceSwitchAction(_ sender: Any) {
        textSwitchAction(switchName: generalAssistanceSwitch, textFieldName: generalAssistanceTextField)
    }
    @IBAction func refugeeSwitchAction(_ sender: Any) {
        textSwitchAction(switchName: refugeeSwitch, textFieldName: refugeeTextField)
    }
    @IBAction func SSISwitchAction(_ sender: Any) {
        textSwitchAction(switchName: SSISwitch, textFieldName: SSITextField)
    }
    
    func textSwitchAction(switchName: UISwitch, textFieldName: UITextField) {
        if switchName.isOn == true{
            textFieldName.isHidden = false
            textFieldName.becomeFirstResponder()
            textFieldName.sizeToFit()
        } else {
            textFieldName.isHidden = true
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func continueButtonAction(_ sender: Any) {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        let currentDateString = formatter.string(from: currentDate)
        let cTANFTextField = TANFTextField.text
        let cgeneralAssistanceTextField = generalAssistanceTextField.text
        let crefugeeTextField = refugeeTextField.text
        let cSSITextField = SSITextField.text
        let cfamilySizeTextField = familySizeTextField.text
        userRef?.child("questionnaire").setValue(["questionnaireDate": currentDateString, "displacedHomemakerSwitch": String(displacedHomemakerSwitch.isOn), "TANFSwitch": String(TANFSwitch.isOn), "TANFTextField": cTANFTextField , "generalAssistanceTextField": cgeneralAssistanceTextField, "generalAssistanceSwitch": String(generalAssistanceSwitch.isOn), "foodStampsSwitch": String(foodStampsSwitch.isOn), "refugeeTextField": crefugeeTextField, "refugeeSwitch": String(refugeeSwitch.isOn), "SSITextField": cSSITextField, "SSISwitch": String(SSISwitch.isOn), "familySizeTextField": cfamilySizeTextField, "homelessSwitch": String(homelessSwitch.isOn), "freeLunchSwitch": String(freeLunchSwitch.isOn), "fosterChildSwitch": String(fosterChildSwitch.isOn), "disabilitySwitch": String(disabilitySwitch.isOn), "runawayYouthSwitch": String(runawayYouthSwitch.isOn), "youthHighPovertySwitch": String(youthHighPovertySwitch.isOn), "exOffenderSwitch": String(exOffenderSwitch.isOn), "englishLanguageLearnerSwitch": String(englishLanguageLearnerSwitch.isOn), "englishGrade8Switch": String(englishGrade8Switch.isOn), "unableToEnglishWorkSwitch": String(unableToEnglishWorkSwitch.isOn), "farmWorker": String(farmWorker.isOn), "exhaustingTANFSwitch": String(exhaustingTANFSwitch.isOn), "singleParentSwitch": String(singleParentSwitch.isOn), "singlePregenantWomanSwitch": String(singlePregnantWomanSwitch.isOn), "longTermUnemploymentSwitch": String(longTermUnemploymentSwitch.isOn), "culturalBarrierSwitch": String(culturalBarrierSwitch.isOn)])
        performSegue(withIdentifier: "SignInConfirmSegue2", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let destinationViewController = segue.destination as? SignInConfirmViewController {
            destinationViewController.userRef = userRef
        }
    }
}


