//
//  UnemploymentViewController.swift
//  FrontDeskApp
//
//  Created by Jon Myer on 6/19/18.
//  Copyright © 2018 Jonathan Myer. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UnemploymentViewController: UIViewController  {
    

    
    
    
    
    //MARK: Properties
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var participantNumberTextField: UITextField!
    @IBOutlet weak var ticketNumberTextField: UITextField!
    
    @IBOutlet var firstNameValidationLabel: UILabel!
    @IBOutlet var lastNameValidationLabel: UILabel!
    @IBOutlet var participantNumberValidationLabel: UILabel!
    @IBOutlet var ticketNumberValidationLabel: UILabel!
    
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var continueButton: UIButton!
    @IBOutlet var stack: UIStackView!
    var user: User!
    var rootRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup View
        setupView()
        firstNameTextField.becomeFirstResponder()
        // Register View Controller as Observer
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: Notification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    fileprivate func setupView() {
        // Configure Validation Labels
        firstNameValidationLabel.isHidden = true
        firstNameValidationLabel.sizeToFit()
        lastNameValidationLabel.isHidden = true
        lastNameValidationLabel.sizeToFit()
        participantNumberValidationLabel.isHidden = true
        participantNumberValidationLabel.sizeToFit()
        ticketNumberValidationLabel.isHidden = true
        ticketNumberValidationLabel.sizeToFit()
        // Configure Continue Button
        continueButton.isEnabled = false
    }
    
    // MARK: - Notification Handling
    
    @objc private func textDidChange(_ notification: Notification) {
        var formIsValid = true
        
        for textField in textFields {
            // Validate Text Field
            let (valid, _) = validate(textField)
            
            guard valid else {
                formIsValid = false
                break
            }
        }
        
        // Update Save Button
        continueButton.isEnabled = formIsValid
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func validate(_ textField: UITextField) -> (Bool, String?) {
        guard let text = textField.text else {
            return (false, nil)
        }
        var message: String!
        if textField == firstNameTextField{
            message = "This field cannot be empty. Please enter your first name"
        }
        else if textField == lastNameTextField{
            message = "This field cannot be empty. Please enter your last name"
        }
        else if textField == participantNumberTextField{
            message = "This field cannot be empty. Please enter your participant number. If you don't know your number, please see the front desk for assistance."
        }
        else{
            message = "This field cannot be empty. Please enter your ticket number."
        }
        return (text.count > 0, message)
    }
    

    @IBAction func continueButtonAction(_ sender: Any) {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        let time = formatter.string(from: currentDateTime)
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        let date = formatter.string(from: currentDateTime)
        
        let cfirstName = firstNameTextField.text
        let clastName = lastNameTextField.text
        let cparticipantNumber = participantNumberTextField.text
        let cticketNumber = ticketNumberTextField.text
        rootRef.child("UCList").childByAutoId().setValue(["firstName": cfirstName, "lastName": clastName, "participantNumber": cparticipantNumber, "ticketNumber": cticketNumber, "date": date, "time": time])
        performSegue(withIdentifier: "UCConfirmSegue", sender: self)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UnemploymentViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case firstNameTextField:
            // Validate Text Field
            let (valid, message) = validate(textField)
            
            if valid {
                lastNameTextField.becomeFirstResponder()
            }
            
            // Update Validation Label
            self.firstNameValidationLabel.text = message
            
            // Show/Hide Validation Label
            UIView.animate(withDuration: 0.25, animations: {
                self.firstNameValidationLabel.isHidden = valid
            })
            
        case lastNameTextField:
            // Validate Text Field
            let (valid, message) = validate(textField)
            
            if valid {
                participantNumberTextField.becomeFirstResponder()
            }
            
            // Update Validation Label
            self.lastNameValidationLabel.text = message
            
            // Show/Hide Validation Label
            UIView.animate(withDuration: 0.25, animations: {
                self.lastNameValidationLabel.isHidden = valid
            })
            
        case participantNumberTextField:
            // Validate Text Field
            let (valid, message) = validate(textField)
            
            if valid {
                ticketNumberTextField.becomeFirstResponder()
            }
            
            // Update Validation Label
            self.participantNumberValidationLabel.text = message
            
            // Show/Hide Validation Label
            UIView.animate(withDuration: 0.25, animations: {
                self.participantNumberValidationLabel.isHidden = valid
            })
        default:
            // Validate Text Field
            let (valid, message) = validate(textField)
            
            if valid {
                ticketNumberTextField.becomeFirstResponder()
            }
            
            // Update Validation Label
            self.ticketNumberValidationLabel.text = message
            
            // Show/Hide Validation Label
            UIView.animate(withDuration: 0.25, animations: {
                self.ticketNumberValidationLabel.isHidden = valid
            })
            
        }
        return true
    }
    
    
}



