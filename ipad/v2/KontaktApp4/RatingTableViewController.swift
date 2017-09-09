//
//  RatingTableViewController.swift
//  KontaktApp4
//
//  Created by Daniel Corak on 09.09.17.
//  Copyright © 2017 Daniel Corak. All rights reserved.
//

import UIKit

class RatingTableViewController: UITableViewController {
    
    var contacts = [Contact]()
    
    let jsonFileHandler: JsonFileHandler = JsonFileHandler()
    
    var error : NSError? = nil
    
    @IBAction func showApplicantInfo(_ sender: AnyObject) {
        print("Info Button pressed")
        
        let buttonPosition = sender.convert(CGPoint(), to:tableView)
        let indexPath = tableView.indexPathForRow(at:buttonPosition)
        let cell = tableView.cellForRow(at: indexPath!) as! RatingTableViewCell
        print(cell.firstName.text!)
        
        // create the alert
        let title: String = "Beschreibung von " + cell.firstName.text!
        let beschreibung: String = cell.firstName.text! + "\n" + cell.name.text! + "\n"
        let alert = UIAlertController(title: title, message: beschreibung, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadContacts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "RatingTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RatingTableViewCell else  {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let contact = contacts[indexPath.row]
        
        cell.firstName.text = contact.firstname
        cell.name.text = contact.name
        cell.rating.rating = Double(contact.rating)
        cell.comment.text = contact.comment
        cell.infoButton.tag = indexPath.section
        
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
    
    private func loadContacts(){
        do{
            contacts = try jsonFileHandler.getData()
            
        } catch let err as NSError {
            print(err.localizedDescription)
            error = err;
        }
    }
    
    
}
