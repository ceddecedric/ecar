//
//  ViewController.swift
//  ProjetSwift
//
//  Created by Mac OS X on 16/01/2017.
//  Copyright © 2017 Mac OS X. All rights reserved.
//


//adding UIKit, MapKit and CoreLocation Packages
import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // The Maps
    @IBOutlet weak var map: MKMapView!
    
    // location manager var
    let manager = CLLocationManager()
    
    // variables for location data value
    var malatitude: String!
    var malongitude: String!
    var monaltitude: String!
    
    var lal : Double = 0.0
    var lol : Double = 0.0
    
    let newPin = MKPointAnnotation()
    let Pin = MKPointAnnotation()
    
    // function to get user location display on tthe maps and set data value
    func  locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        map.removeAnnotation(newPin)
        
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        map.setRegion(region, animated: true)
        newPin.coordinate = location.coordinate
       
        
        self.map.showsUserLocation = true
        
        self.malatitude = String(location.coordinate.latitude)
        self.malongitude = String(location.coordinate.longitude)
        self .monaltitude = String(location.altitude)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
     //location manager set user authorization
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        if (lal != 0.0 && lol != 0.0)
        {
            Pin.coordinate = CLLocationCoordinate2DMake(lal, lol)
            map.addAnnotation(Pin)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Transfert data to SaveViewController, perform by segue "MyDetail"
        if (segue.identifier == "MyDetail"){
            let detailVC = segue.destination as! SaveViewController
            
            detailVC.mlatitude = self.malatitude
            detailVC.mlongitude = self.malongitude
            detailVC.maltitude = self.monaltitude
            
        }
    }
}
