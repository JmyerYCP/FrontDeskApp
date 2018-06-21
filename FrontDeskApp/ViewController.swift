//
//  ViewController.swift
//  FrontDeskApp
//
//  Created by Jon Myer on 6/19/18.
//  Copyright © 2018 Jonathan Myer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goToUnemployment(_ sender: Any) {
        performSegue(withIdentifier: "UCSegue", sender: self)
    }
    
}

