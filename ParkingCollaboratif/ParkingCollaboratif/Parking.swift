//
//  Parking.swift
//  ParkingCollaboratif
//
//  Created by  on 22/01/2018.
//  Copyright © 2018 iut.bm. All rights reserved.
//

import Foundation

class Parking {
    
    var id: Int?
    var adresse: String
    var prixHorraire: Double
    var surveille: Bool
    var souterrain: Bool
    var disponible: Bool
    
    init(adresse: String, prixHorraire: Double, surveille: Bool, souterrain: Bool, disponible: Bool) {
        self.adresse = adresse
        self.prixHorraire = prixHorraire
        self.surveille = surveille
        self.souterrain = souterrain
        self.disponible = disponible
    }
    
    required convenience init?(id: Int, adresse: String, prixHorraire: Double, surveille: Bool, souterrain: Bool, disponible: Bool) {
        self.init(adresse: adresse, prixHorraire: prixHorraire, surveille: surveille, souterrain: souterrain, disponible: disponible)
        self.id = id
    }
    
}
