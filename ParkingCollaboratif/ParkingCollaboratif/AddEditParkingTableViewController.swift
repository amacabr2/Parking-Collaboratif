//
//  AddEditParkingTableViewController.swift
//  ParkingCollaboratif
//
//  Created by  on 22/01/2018.
//  Copyright © 2018 iut.bm. All rights reserved.
//

import UIKit

class AddEditParkingTableViewController: UITableViewController {
    
    @IBOutlet weak var adresseTextField: UITextField!
    
    @IBOutlet weak var prixTextField: UITextField!
    
    @IBOutlet weak var surveilleSwitch: UISwitch!
    
    @IBOutlet weak var dispoibleSwitch: UISwitch!
    
    @IBOutlet weak var souterrainSwitch: UISwitch!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var labelSurveille: UILabel!
    
    @IBOutlet weak var labelDisponible: UILabel!
    
    @IBOutlet weak var labelSouterrain: UILabel!

    var parking: Parking?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        configureTextFields()
        updateTextField()
        
        if let parking = parking {
            saveButton.isEnabled = true
            adresseTextField.text = parking.adresse
            prixTextField.text = String(parking.prixHorraire)
            surveilleSwitch.isOn = parking.surveille
            souterrainSwitch.isOn = parking.souterrain
            dispoibleSwitch.isOn = parking.disponible
            if surveilleSwitch.isOn {
                labelSurveille.text = "Surveillance"
            } else {
                labelSurveille.text = "Pas de surveillance"
            }
            if dispoibleSwitch.isOn {
                labelDisponible.text = "Disponible"
            } else {
                labelDisponible.text = "Pas disponible"
            }
            if souterrainSwitch.isOn {
                labelSouterrain.text = "Parking souterrain"
            } else {
                labelSouterrain.text = "Parking non souterrain"
            }
        } else {
            surveilleSwitch.isOn = false
            souterrainSwitch.isOn = false
            dispoibleSwitch.isOn = false
            labelSurveille.text = "Pas de surveillance"
            labelDisponible.text = "Pas disponible"
            labelSouterrain.text = "Parking non souterrain"
        }
    }
    
    func configureTextFields() {
        // create an array of textfields
        let textFieldArray = [adresseTextField, prixTextField]
        
        // configure them...
        for textField in textFieldArray {
            // make sure you set the delegate to be self
            textField?.delegate = self as? UITextFieldDelegate
                // add a ta)rget to them
            textField?.addTarget(self, action: #selector(AddEditParkingTableViewController.updateTextField), for: .editingChanged)
        }
    }
    
    // this is the target that gets called when editing changes
    func updateTextField() {
        // create an array of textFields
        let textFields = [adresseTextField, prixTextField]
        // create a bool to test if a textField is blank in the textFields array
        let oneOfTheTextFieldsIsBlank = textFields.contains(where: {($0?.text ?? "").isEmpty})
        if oneOfTheTextFieldsIsBlank {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
    
    
    @IBAction func modifPrix(_ sender: UIStepper) {
        self.prixTextField.text = String(sender.value)
    }
    
    
    @IBAction func switchSurveille(_ sender: UISwitch) {
        if surveilleSwitch.isOn {
            labelSurveille.text = "Surveillance"
        } else {
            labelSurveille.text = "Pas de surveillance"
        }
    }
    
    @IBAction func switchDisponible(_ sender: UISwitch) {
        if dispoibleSwitch.isOn {
            labelDisponible.text = "Disponible"
        } else {
            labelDisponible.text = "Pas disponible"
        }
    }
    
    @IBAction func switchSouterrain(_ sender: UISwitch) {
        if souterrainSwitch.isOn {
            labelSouterrain.text = "Parking souterrain"
        } else {
            labelSouterrain.text = "Parking non souterrain"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
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
            parking = Parking(adresse: adresseTextField.text!, prixHorraire: Double(prixTextField.text!)!, surveille: surveilleSwitch.isOn, souterrain: souterrainSwitch.isOn, disponible: dispoibleSwitch.isOn)
        }
    }
    

}
