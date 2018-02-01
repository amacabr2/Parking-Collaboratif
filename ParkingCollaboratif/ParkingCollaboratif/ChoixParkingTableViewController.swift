//
//  ChoixParkingTableViewController.swift
//  ParkingCollaboratif
//
//  Created by  on 29/01/2018.
//  Copyright © 2018 iut.bm. All rights reserved.
//

import UIKit

class ChoixParkingTableViewController: UITableViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var adresseLabel: UILabel!
    
    @IBOutlet weak var disponibiliteImage: UIImageView!
    
    @IBOutlet weak var cameraImage: UIImageView!
    
    @IBOutlet weak var souterrainImage: UIImageView!
    
    @IBOutlet weak var prixLabel: UILabel!
    
    @IBOutlet weak var disponibiliteSwitch: UISwitch!
    
    @IBOutlet weak var disponibiliteLabel: UILabel!
    
    var parking: Parking?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let parking = parking {
            saveButton.isEnabled = true
            adresseLabel.text = parking.adresse
            prixLabel.text = "\(parking.prixHorraire) euros par heure"
            disponibiliteSwitch.isOn = parking.disponible
            if parking.disponible {
                disponibiliteLabel.text = "Disponible"
                disponibiliteImage.image = #imageLiteral(resourceName: "validé")
            } else {
                disponibiliteLabel.text = "Pas disponible"
                disponibiliteImage.image = #imageLiteral(resourceName: "non_valide_g")
            }
            if parking.surveille {
                cameraImage.image = #imageLiteral(resourceName: "camera")
            } else {
                cameraImage.image = #imageLiteral(resourceName: "Pas-surveillé")
            }
            if parking.souterrain {
                souterrainImage.image = #imageLiteral(resourceName: "Souterrain")
            } else {
                souterrainImage.image = nil
            }

        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func changeDisponibilite(_ sender: UISwitch) {
        if sender.isOn {
            disponibiliteLabel.text = "Disponible"
            disponibiliteImage.image = #imageLiteral(resourceName: "validé")
        } else {
            disponibiliteLabel.text = "Pas disponible"
            disponibiliteImage.image = #imageLiteral(resourceName: "non_valide_g")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "saveUnwind") {
            parking = Parking(id: (parking?.id)!, adresse: (parking?.adresse)!, prixHorraire: (parking?.prixHorraire)!, surveille: (parking?.surveille)!, souterrain: (parking?.souterrain)!, disponible: disponibiliteSwitch.isOn)
        }
    }


}
