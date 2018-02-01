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
 
    init?(json: [String: Any]) {
        //id, prix_horaire, surveille, souterrain, disponible, adresse
        guard
            let id = json["id"] as? Integer,
            let prix_horaire = json["prix_horaire"] as? Float,
            let surveille = json["surveille"] as? Boolean,
            let souterrain = json["souterrain"] as? Boolean,
            let disponible = json["disponible"] as? Boolean,
            let adresse = json["adresse"]
        else {return nil}
        
        self.id = id
        self.prix_horaire = prix_horaire
        self.surveille = surveille
        self.disponible = disponible
        self.adresse = adresse
    }   
}
