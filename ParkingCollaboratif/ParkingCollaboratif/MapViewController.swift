//
//  MapViewController.swift
//  ParkingCollaboratif
//
//  Created by  on 24/01/2018.
//  Copyright © 2018 iut.bm. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    //var parkings = [
        //Parking(id: 1, adresse: "France, Conflans-sur-Lanterne, 7 rue de la Cornée", prixHorraire: 45, surveille: true, souterrain: true, disponible: true),
        //Parking(id: 2, adresse: "France, Conflans-sur-Lanterne, 9 Avenue Jules Seguin", prixHorraire: 45, surveille: true, souterrain: true, disponible: true),
    //]
    var parkings = []
    
    let locationManager = CLLocationManager()
    
    var affichagePosition: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            map.delegate = self
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        self.position();
        
    }

    private func position() {
    	let parkingController = ParkingController()
        parkingController.fetchAllParking { (parkingArray) in
            DispatchQueue.main.async {
                parkings = parkingArray
            }
        }

        for i in 0 ... parkings.count - 1 {
            self.geoCode(parking: parkings[i]!)
        }
    }
    
    func geoCode(parking: Parking) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(parking.adresse) { (placemarks, error) in
            var location: CLLocation?
            if let error = error {
                print("Unable to Forward Geocode Address (\(error))")
            } else {
                
                if let placemarks = placemarks, placemarks.count > 0 {
                    location = placemarks.first?.location
                }
                
                if let location = location {
                    let coordinate = location.coordinate
                    let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.subtitle = parking.adresse
                    if parking.disponible {
                        annotation.title = "Disponible"
                    } else {
                        annotation.title = "Insdisponible"
                    }
                    self.map.addAnnotation(annotation)
                } else {
                    //locationLabel.text = "No Matching Location Found"
                }
            }

        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        pin.canShowCallout = true
        pin.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return pin
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annView = view.annotation
        for i in 0...parkings.count - 1 {
            if parkings[i]?.adresse == ((annView?.subtitle)!)! {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let detailleVC = storyboard.instantiateViewController(withIdentifier:"detailleVC") as! ChoixParkingTableViewController
                detailleVC.parking = parkings[i]
                self.present(detailleVC, animated: true, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let span = MKCoordinateSpanMake(0.002, 0.002)
        let location = CLLocationCoordinate2DMake(locations[0].coordinate.latitude, locations[0].coordinate.longitude)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.navigationItem.title = "Create a new parking"
    }
    

    // ajoute/modifier note
    @IBAction func unwindFromAddEditParkingController(segue: UIStoryboardSegue) {
        if (segue.identifier == "saveUnwind") {
            let sourceTableViewController = segue.source as! AddEditParkingTableViewController
            if let parking = sourceTableViewController.parking {
                parkings.append(parking)
            }
            self.position();
        }

        if (segue.identifier == "editUnwind") {
            let sourceTableViewController = segue.source as! ChoixParkingTableViewController
            if let parking = sourceTableViewController.parking {
                parkings[parking.id! - 1] = parking
            }
            self.position();
        }
    }
    


}
