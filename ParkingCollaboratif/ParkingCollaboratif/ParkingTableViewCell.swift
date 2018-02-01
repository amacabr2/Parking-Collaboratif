//
//  ParkingTableViewCell.swift
//  ParkingCollaboratif
//
//  Created by  on 22/01/2018.
//  Copyright © 2018 iut.bm. All rights reserved.
//

import UIKit

class ParkingTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var adresseLabel: UILabel!
    
    @IBOutlet weak var prixLabel: UILabel!

    @IBOutlet weak var imageDisponible: UIImageView!
    
    @IBOutlet weak var imageSurveille: UIImageView!
    
    @IBOutlet weak var imageSouterrain: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updape(parking: Parking) {
        adresseLabel.text = parking.adresse
        prixLabel.text = "\(parking.prixHorraire) €/h"
        if parking.disponible {
            imageDisponible.image = #imageLiteral(resourceName: "validé")
        } else {
            imageDisponible.image = #imageLiteral(resourceName: "non_valide_g")
        }
        if parking.surveille {
            imageSurveille.image = #imageLiteral(resourceName: "camera")
        } else {
            imageSurveille.image = #imageLiteral(resourceName: "Pas-surveillé")
        }
        if parking.souterrain {
            imageSouterrain.image = #imageLiteral(resourceName: "Souterrain")
        } else {
            imageSouterrain.image = nil
        }
    }

}
