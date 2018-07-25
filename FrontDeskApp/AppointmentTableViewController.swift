//
//  AppointmentTableViewController.swift
//  FrontDeskApp
//
//  Created by Jon Myer on 7/11/18.
//  Copyright © 2018 Jonathan Myer. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseFunctions

protocol CustomCellDelegate {
    func cellButtonTapped(cell: AppointmentTableViewCell)
}

class AppointmentTableViewCell: UITableViewCell{
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    var index: Int!
    
    var delegate: CustomCellDelegate?
    
    @IBAction func buttonTapped(sender: AnyObject) {
        delegate?.cellButtonTapped(cell: self)
    }
    
}

class AppointmentTableViewController: UITableViewController, CustomCellDelegate {
    
    
    var rootRef = Database.database().reference()
    var appointmentArray: [[String]] = []
    var innerArray: [String] = []
    var buttonArray: [UIButton] = []
    var selectedItems = [String]()
    var keyArray = [String]()
    lazy var functions = Functions.functions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStaffData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("appointmentArray Length is: \(self.appointmentArray.count)")
        return self.appointmentArray.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! AppointmentTableViewCell
        
        
        cell.delegate = self
        let hostName = appointmentArray[indexPath.row][0]
        
        
        let message = "\(hostName)"
        cell.label?.text = message
        self.buttonArray.append(cell.button)
        cell.index? = indexPath.row
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func cellButtonTapped(cell: AppointmentTableViewCell) {
        let indexPath = self.tableView.indexPathForRow(at: cell.center)!.row
        print("this button is number: \(indexPath)")
        let uID = appointmentArray[indexPath][1]
        functions.httpsCallable("appointmentCheckIn").call(["text": uID]) { (result, error) in
            if let error = error as NSError? {
                if error.domain == FunctionsErrorDomain {
                    let code = FunctionsErrorCode(rawValue: error.code)
                    let message = error.localizedDescription
                    let details = error.userInfo[FunctionsErrorDetailsKey]
                }
            }
        }
        
        
        performSegue(withIdentifier: "appointmentsToConfirmSegue", sender: self)
    }
    
    func getStaffData(){
        rootRef.child("staffInfo").observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                for childchild in child.children.allObjects as! [DataSnapshot]{
                    self.innerArray.append(childchild.value as? String ?? "")
                }
                self.innerArray.append(child.key)
                self.appointmentArray.append(self.innerArray)
                self.innerArray = []
            }
            print("Appointment Array: \(self.appointmentArray)")
            print("Key Array: \(self.keyArray)")
            self.tableView.reloadData()
            
            })

        
    }

}
