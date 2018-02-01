//
//  ParkingTableViewController.swift
//  ParkingCollaboratif
//
//  Created by  on 22/01/2018.
//  Copyright © 2018 iut.bm. All rights reserved.
//

import UIKit

class ParkingTableViewController: UITableViewController {
    
    var parkings: [Parking] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
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
        return parkings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParkingCell", for: indexPath) as! ParkingTableViewCell

        // Configure the cell...
        let parking = parkings[indexPath.row]
        cell.updape(parking: parking)
        cell.showsReorderControl = true
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            parkings.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let moveParking = parkings.remove(at: fromIndexPath.row)
        parkings.insert(moveParking, at: to.row)
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "EditParking") {
            let addEditParkingTableViewController = segue.destination as! AddEditParkingTableViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let parking = parkings[indexPath.row]
            addEditParkingTableViewController.parking = parking
            segue.destination.navigationItem.title = "Edit \(String(describing: parking.adresse))"
        } else {
            segue.destination.navigationItem.title = "Create a new parking"
        }
    }
    
    // ajoute/modifier parking
    @IBAction func unwindFromAddEditParkingController(segue: UIStoryboardSegue) {
        if (segue.identifier == "saveUnwind") {
            let sourceTableViewController = segue.source as! AddEditParkingTableViewController
            if let parking = sourceTableViewController.parking {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    parkings[selectedIndexPath.row] = parking
                    tableView.reloadData()
                }
                else {
                    let newIndexPath = IndexPath(row: parkings.count, section: 0)
                    parkings.append(parking)
                    tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            }
        }
    }
    

}
