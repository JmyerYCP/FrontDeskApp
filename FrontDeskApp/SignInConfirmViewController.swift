//
//  SignInConfirmViewController.swift
//  FrontDeskApp
//
//  Created by Jon Myer on 6/25/18.
//  Copyright © 2018 Jonathan Myer. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SignInConfirmViewController: UIViewController {
    var userRef: DatabaseReference?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //TODO: Set up more stuff to confirm what options they selected.

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func FinishedButton(_ sender: Any) {
        performSegue(withIdentifier: "ReturnToWelcomeSegue", sender: self)
    }
}
