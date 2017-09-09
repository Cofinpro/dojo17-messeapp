//
//  RatingTableViewController.swift
//  KontaktApp4
//
//  Created by Daniel Corak on 09.09.17.
//  Copyright © 2017 Daniel Corak. All rights reserved.
//

import UIKit

class RatingTableViewController: UITableViewController {
    
    var ratings = [Rating]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRatings()
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
        return ratings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "RatingTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RatingTableViewCell else  {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let rating = ratings[indexPath.row]
        
        cell.firstName.text = rating.firstname
        cell.name.text = rating.name
        cell.rating = rating.rating
        cell.comment = rating.comment

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
    
    private func loadRatings(){
        guard let rating1 = Rating(firstname: "Daniel", name: "Corak", rating: CosmosView(), comment: UITextField()) else {
            fatalError("Unable to instantiate rating1")
        }
        
        guard let rating2 = Rating(firstname: "Michael", name: "Heck", rating: CosmosView(), comment: UITextField()) else {
                fatalError("Unable to instantiate rating2")
        }
        
        guard let rating3 = Rating(firstname: "Harald", name: "Müller", rating: CosmosView(), comment: UITextField()) else {
            fatalError("Unable to instantiate rating3")
        }
        
        ratings += [rating1, rating2, rating3]
    }
    

}
